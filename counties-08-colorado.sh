#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/08/n out/08/c out/08/s

curl -s -o tmp/colorado.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/colorado.osm.pbf

osmosis --rb tmp/colorado.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/colorado-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/colorado-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/colorado-routes-B.osm.pbf \
            --tf accept-relations "network=US:CO" --used-way --used-node --wb omitmetadata=true tmp/colorado-routes-C.osm.pbf \
            --tf accept-relations "network=US:CO:CR" --used-way --used-node --wb omitmetadata=true tmp/colorado-routes-D.osm.pbf \

osmosis \
    --rb tmp/colorado-routes-A.osm.pbf \
    --rb tmp/colorado-routes-B.osm.pbf \
    --rb tmp/colorado-routes-C.osm.pbf \
    --rb tmp/colorado-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/colorado-routes.osm.bz2

osmosis \
    --rb tmp/colorado-roads.osm.pbf \
    --tee outputCount=64 \
    --bp completeWays=yes file=polys/08/08001-Adams-County.txt       --wx out/08001-Adams-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08013-Boulder-County.txt     --wx out/08013-Boulder-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08014-Broomfield-County.txt  --wx out/08014-Broomfield-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08047-Gilpin-County.txt      --wx out/08047-Gilpin-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08049-Grand-County.txt       --wx out/08049-Grand-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08057-Jackson-County.txt     --wx out/08057-Jackson-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08069-Larimer-County.txt     --wx out/08069-Larimer-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08075-Logan-County.txt       --wx out/08075-Logan-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08081-Moffat-County.txt      --wx out/08081-Moffat-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08087-Morgan-County.txt      --wx out/08087-Morgan-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08095-Phillips-County.txt    --wx out/08095-Phillips-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08103-Rio-Blanco-County.txt  --wx out/08103-Rio-Blanco-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08107-Routt-County.txt       --wx out/08107-Routt-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08115-Sedgwick-County.txt    --wx out/08115-Sedgwick-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08121-Washington-County.txt  --wx out/08121-Washington-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08123-Weld-County.txt        --wx out/08123-Weld-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08125-Yuma-County.txt        --wx out/08125-Yuma-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08005-Arapahoe-County.txt    --wx out/08005-Arapahoe-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08015-Chaffee-County.txt     --wx out/08015-Chaffee-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08017-Cheyenne-County.txt    --wx out/08017-Cheyenne-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08019-Clear-Creek-County.txt --wx out/08019-Clear-Creek-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08029-Delta-County.txt       --wx out/08029-Delta-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08031-Denver-County.txt      --wx out/08031-Denver-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08035-Douglas-County.txt     --wx out/08035-Douglas-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08037-Eagle-County.txt       --wx out/08037-Eagle-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08039-Elbert-County.txt      --wx out/08039-Elbert-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08041-El-Paso-County.txt     --wx out/08041-El-Paso-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08043-Fremont-County.txt     --wx out/08043-Fremont-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08045-Garfield-County.txt    --wx out/08045-Garfield-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08051-Gunnison-County.txt    --wx out/08051-Gunnison-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08059-Jefferson-County.txt   --wx out/08059-Jefferson-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08063-Kit-Carson-County.txt  --wx out/08063-Kit-Carson-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08065-Lake-County.txt        --wx out/08065-Lake-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08073-Lincoln-County.txt     --wx out/08073-Lincoln-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08077-Mesa-County.txt        --wx out/08077-Mesa-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08093-Park-County.txt        --wx out/08093-Park-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08097-Pitkin-County.txt      --wx out/08097-Pitkin-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08117-Summit-County.txt      --wx out/08117-Summit-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08119-Teller-County.txt      --wx out/08119-Teller-County/c/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08003-Alamosa-County.txt     --wx out/08003-Alamosa-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08007-Archuleta-County.txt   --wx out/08007-Archuleta-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08009-Baca-County.txt        --wx out/08009-Baca-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08011-Bent-County.txt        --wx out/08011-Bent-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08021-Conejos-County.txt     --wx out/08021-Conejos-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08023-Costilla-County.txt    --wx out/08023-Costilla-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08025-Crowley-County.txt     --wx out/08025-Crowley-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08027-Custer-County.txt      --wx out/08027-Custer-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08033-Dolores-County.txt     --wx out/08033-Dolores-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08053-Hinsdale-County.txt    --wx out/08053-Hinsdale-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08055-Huerfano-County.txt    --wx out/08055-Huerfano-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08061-Kiowa-County.txt       --wx out/08061-Kiowa-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08067-La-Plata-County.txt    --wx out/08067-La-Plata-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08071-Las-Animas-County.txt  --wx out/08071-Las-Animas-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08079-Mineral-County.txt     --wx out/08079-Mineral-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08083-Montezuma-County.txt   --wx out/08083-Montezuma-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08085-Montrose-County.txt    --wx out/08085-Montrose-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08089-Otero-County.txt       --wx out/08089-Otero-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08091-Ouray-County.txt       --wx out/08091-Ouray-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08099-Prowers-County.txt     --wx out/08099-Prowers-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08101-Pueblo-County.txt      --wx out/08101-Pueblo-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08105-Rio-Grande-County.txt  --wx out/08105-Rio-Grande-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08109-Saguache-County.txt    --wx out/08109-Saguache-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08111-San-Juan-County.txt    --wx out/08111-San-Juan-County/s/.osm.bz2 \
    --bp completeWays=yes file=polys/08/08113-San-Miguel-County.txt  --wx out/08113-San-Miguel-County/s/.osm.bz2 \

./skeletron-routes.sh tmp/colorado-routes.osm.bz2 out/08 colorado
./skeletron-roads.sh tmp/colorado-roads.osm.pbf out/08 colorado
