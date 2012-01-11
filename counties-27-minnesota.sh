#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/27/n out/27/c out/27/s

curl -Rs -o tmp/minnesota.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/minnesota.osm.pbf

osmosis --rb tmp/minnesota.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/minnesota-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/minnesota-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/minnesota-routes-B.osm.pbf \
            --tf accept-relations "network=US:MN" --used-way --used-node --wb omitmetadata=true tmp/minnesota-routes-C.osm.pbf \
            --tf accept-relations "network=US:MN:CR" --used-way --used-node --wb omitmetadata=true tmp/minnesota-routes-D.osm.pbf \

osmosis \
    --rb tmp/minnesota-routes-A.osm.pbf \
    --rb tmp/minnesota-routes-B.osm.pbf \
    --rb tmp/minnesota-routes-C.osm.pbf \
    --rb tmp/minnesota-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/minnesota-routes.osm.bz2

osmosis \
    --rb tmp/minnesota-roads.osm.pbf \
    --tee outputCount=87 \
    --bp completeWays=yes file=polys/27/27007-Beltrami-County.txt          --wx out/27/n/27007-beltrami-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27029-Clearwater-County.txt        --wx out/27/n/27029-clearwater-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27031-Cook-County.txt              --wx out/27/n/27031-cook-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27061-Itasca-County.txt            --wx out/27/n/27061-itasca-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27069-Kittson-County.txt           --wx out/27/n/27069-kittson-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27071-Koochiching-County.txt       --wx out/27/n/27071-koochiching-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27077-Lake-of-the-Woods-County.txt --wx out/27/n/27077-lake-of-the-woods-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27075-Lake-County.txt              --wx out/27/n/27075-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27087-Mahnomen-County.txt          --wx out/27/n/27087-mahnomen-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27089-Marshall-County.txt          --wx out/27/n/27089-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27107-Norman-County.txt            --wx out/27/n/27107-norman-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27113-Pennington-County.txt        --wx out/27/n/27113-pennington-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27119-Polk-County.txt              --wx out/27/n/27119-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27125-Red-Lake-County.txt          --wx out/27/n/27125-red-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27135-Roseau-County.txt            --wx out/27/n/27135-roseau-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27137-St.-Louis-County.txt         --wx out/27/n/27137-st.-louis-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27001-Aitkin-County.txt            --wx out/27/c/27001-aitkin-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27005-Becker-County.txt            --wx out/27/c/27005-becker-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27009-Benton-County.txt            --wx out/27/c/27009-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27017-Carlton-County.txt           --wx out/27/c/27017-carlton-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27021-Cass-County.txt              --wx out/27/c/27021-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27025-Chisago-County.txt           --wx out/27/c/27025-chisago-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27027-Clay-County.txt              --wx out/27/c/27027-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27035-Crow-Wing-County.txt         --wx out/27/c/27035-crow-wing-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27041-Douglas-County.txt           --wx out/27/c/27041-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27051-Grant-County.txt             --wx out/27/c/27051-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27057-Hubbard-County.txt           --wx out/27/c/27057-hubbard-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27059-Isanti-County.txt            --wx out/27/c/27059-isanti-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27065-Kanabec-County.txt           --wx out/27/c/27065-kanabec-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27095-Mille-Lacs-County.txt        --wx out/27/c/27095-mille-lacs-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27097-Morrison-County.txt          --wx out/27/c/27097-morrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27111-Otter-Tail-County.txt        --wx out/27/c/27111-otter-tail-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27115-Pine-County.txt              --wx out/27/c/27115-pine-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27121-Pope-County.txt              --wx out/27/c/27121-pope-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27145-Stearns-County.txt           --wx out/27/c/27145-stearns-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27149-Stevens-County.txt           --wx out/27/c/27149-stevens-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27153-Todd-County.txt              --wx out/27/c/27153-todd-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27155-Traverse-County.txt          --wx out/27/c/27155-traverse-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27159-Wadena-County.txt            --wx out/27/c/27159-wadena-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27167-Wilkin-County.txt            --wx out/27/c/27167-wilkin-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27003-Anoka-County.txt             --wx out/27/s/27003-anoka-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27011-Big-Stone-County.txt         --wx out/27/s/27011-big-stone-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27013-Blue-Earth-County.txt        --wx out/27/s/27013-blue-earth-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27015-Brown-County.txt             --wx out/27/s/27015-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27019-Carver-County.txt            --wx out/27/s/27019-carver-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27023-Chippewa-County.txt          --wx out/27/s/27023-chippewa-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27033-Cottonwood-County.txt        --wx out/27/s/27033-cottonwood-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27037-Dakota-County.txt            --wx out/27/s/27037-dakota-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27039-Dodge-County.txt             --wx out/27/s/27039-dodge-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27043-Faribault-County.txt         --wx out/27/s/27043-faribault-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27045-Fillmore-County.txt          --wx out/27/s/27045-fillmore-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27047-Freeborn-County.txt          --wx out/27/s/27047-freeborn-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27049-Goodhue-County.txt           --wx out/27/s/27049-goodhue-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27053-Hennepin-County.txt          --wx out/27/s/27053-hennepin-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27055-Houston-County.txt           --wx out/27/s/27055-houston-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27063-Jackson-County.txt           --wx out/27/s/27063-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27067-Kandiyohi-County.txt         --wx out/27/s/27067-kandiyohi-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27073-Lac-qui-Parle-County.txt     --wx out/27/s/27073-lac-qui-parle-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27079-Le-Sueur-County.txt          --wx out/27/s/27079-le-sueur-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27081-Lincoln-County.txt           --wx out/27/s/27081-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27083-Lyon-County.txt              --wx out/27/s/27083-lyon-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27085-McLeod-County.txt            --wx out/27/s/27085-mcleod-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27091-Martin-County.txt            --wx out/27/s/27091-martin-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27093-Meeker-County.txt            --wx out/27/s/27093-meeker-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27099-Mower-County.txt             --wx out/27/s/27099-mower-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27101-Murray-County.txt            --wx out/27/s/27101-murray-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27103-Nicollet-County.txt          --wx out/27/s/27103-nicollet-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27105-Nobles-County.txt            --wx out/27/s/27105-nobles-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27109-Olmsted-County.txt           --wx out/27/s/27109-olmsted-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27117-Pipestone-County.txt         --wx out/27/s/27117-pipestone-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27123-Ramsey-County.txt            --wx out/27/s/27123-ramsey-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27127-Redwood-County.txt           --wx out/27/s/27127-redwood-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27129-Renville-County.txt          --wx out/27/s/27129-renville-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27131-Rice-County.txt              --wx out/27/s/27131-rice-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27133-Rock-County.txt              --wx out/27/s/27133-rock-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27139-Scott-County.txt             --wx out/27/s/27139-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27141-Sherburne-County.txt         --wx out/27/s/27141-sherburne-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27143-Sibley-County.txt            --wx out/27/s/27143-sibley-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27147-Steele-County.txt            --wx out/27/s/27147-steele-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27151-Swift-County.txt             --wx out/27/s/27151-swift-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27157-Wabasha-County.txt           --wx out/27/s/27157-wabasha-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27161-Waseca-County.txt            --wx out/27/s/27161-waseca-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27163-Washington-County.txt        --wx out/27/s/27163-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27165-Watonwan-County.txt          --wx out/27/s/27165-watonwan-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27169-Winona-County.txt            --wx out/27/s/27169-winona-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27171-Wright-County.txt            --wx out/27/s/27171-wright-county.osm.bz2 \
    --bp completeWays=yes file=polys/27/27173-Yellow-Medicine-County.txt   --wx out/27/s/27173-yellow-medicine-county.osm.bz2 \

touch -r tmp/minnesota.osm.pbf out/27/*/*.osm.???

./skeletron-roads.sh tmp/minnesota-roads.osm.pbf out/27 minnesota MN
./skeletron-routes.sh tmp/minnesota-routes.osm.bz2 out/27 minnesota MN
