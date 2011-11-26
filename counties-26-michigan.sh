#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/26/n out/26/c out/26/s

curl -s -o tmp/michigan.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/michigan.osm.pbf

osmosis --rb tmp/michigan.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/michigan-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/michigan-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/michigan-routes-B.osm.pbf \
            --tf accept-relations "network=US:MI" --used-way --used-node --wb omitmetadata=true tmp/michigan-routes-C.osm.pbf \
            --tf accept-relations "network=US:MI:CR" --used-way --used-node --wb omitmetadata=true tmp/michigan-routes-D.osm.pbf \

osmosis \
    --rb tmp/michigan-routes-A.osm.pbf \
    --rb tmp/michigan-routes-B.osm.pbf \
    --rb tmp/michigan-routes-C.osm.pbf \
    --rb tmp/michigan-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/michigan-routes.osm.bz2

osmosis \
    --rb tmp/michigan-roads.osm.pbf \
    --tee outputCount=83 \
    --bp completeWays=yes file=polys/26/26003-Alger-County.txt        --wx out/26/n/26003-alger-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26013-Baraga-County.txt       --wx out/26/n/26013-baraga-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26033-Chippewa-County.txt     --wx out/26/n/26033-chippewa-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26041-Delta-County.txt        --wx out/26/n/26041-delta-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26043-Dickinson-County.txt    --wx out/26/n/26043-dickinson-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26053-Gogebic-County.txt      --wx out/26/n/26053-gogebic-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26061-Houghton-County.txt     --wx out/26/n/26061-houghton-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26071-Iron-County.txt         --wx out/26/n/26071-iron-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26083-Keweenaw-County.txt     --wx out/26/n/26083-keweenaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26095-Luce-County.txt         --wx out/26/n/26095-luce-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26097-Mackinac-County.txt     --wx out/26/n/26097-mackinac-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26103-Marquette-County.txt    --wx out/26/n/26103-marquette-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26109-Menominee-County.txt    --wx out/26/n/26109-menominee-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26131-Ontonagon-County.txt    --wx out/26/n/26131-ontonagon-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26153-Schoolcraft-County.txt  --wx out/26/n/26153-schoolcraft-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26001-Alcona-County.txt       --wx out/26/c/26001-alcona-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26007-Alpena-County.txt       --wx out/26/c/26007-alpena-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26009-Antrim-County.txt       --wx out/26/c/26009-antrim-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26011-Arenac-County.txt       --wx out/26/c/26011-arenac-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26019-Benzie-County.txt       --wx out/26/c/26019-benzie-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26029-Charlevoix-County.txt   --wx out/26/c/26029-charlevoix-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26031-Cheboygan-County.txt    --wx out/26/c/26031-cheboygan-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26035-Clare-County.txt        --wx out/26/c/26035-clare-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26039-Crawford-County.txt     --wx out/26/c/26039-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26047-Emmet-County.txt        --wx out/26/c/26047-emmet-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26051-Gladwin-County.txt      --wx out/26/c/26051-gladwin-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26055-Grand-Traverse-County.txt                            --wx out/26/c/26055-grand-traverse-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26069-Iosco-County.txt        --wx out/26/c/26069-iosco-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26079-Kalkaska-County.txt     --wx out/26/c/26079-kalkaska-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26085-Lake-County.txt         --wx out/26/c/26085-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26089-Leelanau-County.txt     --wx out/26/c/26089-leelanau-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26101-Manistee-County.txt     --wx out/26/c/26101-manistee-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26105-Mason-County.txt        --wx out/26/c/26105-mason-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26113-Missaukee-County.txt    --wx out/26/c/26113-missaukee-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26119-Montmorency-County.txt  --wx out/26/c/26119-montmorency-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26129-Ogemaw-County.txt       --wx out/26/c/26129-ogemaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26133-Osceola-County.txt      --wx out/26/c/26133-osceola-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26135-Oscoda-County.txt       --wx out/26/c/26135-oscoda-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26137-Otsego-County.txt       --wx out/26/c/26137-otsego-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26141-Presque-Isle-County.txt --wx out/26/c/26141-presque-isle-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26143-Roscommon-County.txt    --wx out/26/c/26143-roscommon-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26165-Wexford-County.txt      --wx out/26/c/26165-wexford-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26005-Allegan-County.txt      --wx out/26/s/26005-allegan-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26015-Barry-County.txt        --wx out/26/s/26015-barry-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26017-Bay-County.txt          --wx out/26/s/26017-bay-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26021-Berrien-County.txt      --wx out/26/s/26021-berrien-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26023-Branch-County.txt       --wx out/26/s/26023-branch-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26025-Calhoun-County.txt      --wx out/26/s/26025-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26027-Cass-County.txt         --wx out/26/s/26027-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26037-Clinton-County.txt      --wx out/26/s/26037-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26045-Eaton-County.txt        --wx out/26/s/26045-eaton-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26049-Genesee-County.txt      --wx out/26/s/26049-genesee-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26057-Gratiot-County.txt      --wx out/26/s/26057-gratiot-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26059-Hillsdale-County.txt    --wx out/26/s/26059-hillsdale-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26063-Huron-County.txt        --wx out/26/s/26063-huron-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26065-Ingham-County.txt       --wx out/26/s/26065-ingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26067-Ionia-County.txt        --wx out/26/s/26067-ionia-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26073-Isabella-County.txt     --wx out/26/s/26073-isabella-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26075-Jackson-County.txt      --wx out/26/s/26075-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26077-Kalamazoo-County.txt    --wx out/26/s/26077-kalamazoo-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26081-Kent-County.txt         --wx out/26/s/26081-kent-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26087-Lapeer-County.txt       --wx out/26/s/26087-lapeer-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26091-Lenawee-County.txt      --wx out/26/s/26091-lenawee-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26093-Livingston-County.txt   --wx out/26/s/26093-livingston-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26099-Macomb-County.txt       --wx out/26/s/26099-macomb-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26107-Mecosta-County.txt      --wx out/26/s/26107-mecosta-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26111-Midland-County.txt      --wx out/26/s/26111-midland-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26115-Monroe-County.txt       --wx out/26/s/26115-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26117-Montcalm-County.txt     --wx out/26/s/26117-montcalm-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26121-Muskegon-County.txt     --wx out/26/s/26121-muskegon-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26123-Newaygo-County.txt      --wx out/26/s/26123-newaygo-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26125-Oakland-County.txt      --wx out/26/s/26125-oakland-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26127-Oceana-County.txt       --wx out/26/s/26127-oceana-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26139-Ottawa-County.txt       --wx out/26/s/26139-ottawa-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26145-Saginaw-County.txt      --wx out/26/s/26145-saginaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26147-St.-Clair-County.txt    --wx out/26/s/26147-st.-clair-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26149-St.-Joseph-County.txt   --wx out/26/s/26149-st.-joseph-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26151-Sanilac-County.txt      --wx out/26/s/26151-sanilac-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26155-Shiawassee-County.txt   --wx out/26/s/26155-shiawassee-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26157-Tuscola-County.txt      --wx out/26/s/26157-tuscola-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26159-Van-Buren-County.txt    --wx out/26/s/26159-van-buren-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26161-Washtenaw-County.txt    --wx out/26/s/26161-washtenaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/26/26163-Wayne-County.txt        --wx out/26/s/26163-wayne-county.osm.bz2 \

./skeletron-roads.sh tmp/michigan-roads.osm.pbf out/26 michigan
./skeletron-routes.sh tmp/michigan-routes.osm.bz2 out/26 michigan
