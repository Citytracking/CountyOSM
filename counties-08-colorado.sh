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
    --bp completeWays=yes file=polys/08/08001-Adams-County.txt       --wx out/08/n/08001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08013-Boulder-County.txt     --wx out/08/n/08013-boulder-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08014-Broomfield-County.txt  --wx out/08/n/08014-broomfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08047-Gilpin-County.txt      --wx out/08/n/08047-gilpin-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08049-Grand-County.txt       --wx out/08/n/08049-grand-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08057-Jackson-County.txt     --wx out/08/n/08057-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08069-Larimer-County.txt     --wx out/08/n/08069-larimer-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08075-Logan-County.txt       --wx out/08/n/08075-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08081-Moffat-County.txt      --wx out/08/n/08081-moffat-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08087-Morgan-County.txt      --wx out/08/n/08087-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08095-Phillips-County.txt    --wx out/08/n/08095-phillips-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08103-Rio-Blanco-County.txt  --wx out/08/n/08103-rio-blanco-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08107-Routt-County.txt       --wx out/08/n/08107-routt-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08115-Sedgwick-County.txt    --wx out/08/n/08115-sedgwick-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08121-Washington-County.txt  --wx out/08/n/08121-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08123-Weld-County.txt        --wx out/08/n/08123-weld-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08125-Yuma-County.txt        --wx out/08/n/08125-yuma-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08005-Arapahoe-County.txt    --wx out/08/c/08005-arapahoe-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08015-Chaffee-County.txt     --wx out/08/c/08015-chaffee-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08017-Cheyenne-County.txt    --wx out/08/c/08017-cheyenne-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08019-Clear-Creek-County.txt --wx out/08/c/08019-clear-creek-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08029-Delta-County.txt       --wx out/08/c/08029-delta-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08031-Denver-County.txt      --wx out/08/c/08031-denver-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08035-Douglas-County.txt     --wx out/08/c/08035-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08037-Eagle-County.txt       --wx out/08/c/08037-eagle-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08039-Elbert-County.txt      --wx out/08/c/08039-elbert-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08041-El-Paso-County.txt     --wx out/08/c/08041-el-paso-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08043-Fremont-County.txt     --wx out/08/c/08043-fremont-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08045-Garfield-County.txt    --wx out/08/c/08045-garfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08051-Gunnison-County.txt    --wx out/08/c/08051-gunnison-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08059-Jefferson-County.txt   --wx out/08/c/08059-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08063-Kit-Carson-County.txt  --wx out/08/c/08063-kit-carson-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08065-Lake-County.txt        --wx out/08/c/08065-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08073-Lincoln-County.txt     --wx out/08/c/08073-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08077-Mesa-County.txt        --wx out/08/c/08077-mesa-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08093-Park-County.txt        --wx out/08/c/08093-park-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08097-Pitkin-County.txt      --wx out/08/c/08097-pitkin-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08117-Summit-County.txt      --wx out/08/c/08117-summit-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08119-Teller-County.txt      --wx out/08/c/08119-teller-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08003-Alamosa-County.txt     --wx out/08/s/08003-alamosa-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08007-Archuleta-County.txt   --wx out/08/s/08007-archuleta-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08009-Baca-County.txt        --wx out/08/s/08009-baca-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08011-Bent-County.txt        --wx out/08/s/08011-bent-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08021-Conejos-County.txt     --wx out/08/s/08021-conejos-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08023-Costilla-County.txt    --wx out/08/s/08023-costilla-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08025-Crowley-County.txt     --wx out/08/s/08025-crowley-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08027-Custer-County.txt      --wx out/08/s/08027-custer-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08033-Dolores-County.txt     --wx out/08/s/08033-dolores-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08053-Hinsdale-County.txt    --wx out/08/s/08053-hinsdale-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08055-Huerfano-County.txt    --wx out/08/s/08055-huerfano-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08061-Kiowa-County.txt       --wx out/08/s/08061-kiowa-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08067-La-Plata-County.txt    --wx out/08/s/08067-la-plata-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08071-Las-Animas-County.txt  --wx out/08/s/08071-las-animas-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08079-Mineral-County.txt     --wx out/08/s/08079-mineral-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08083-Montezuma-County.txt   --wx out/08/s/08083-montezuma-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08085-Montrose-County.txt    --wx out/08/s/08085-montrose-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08089-Otero-County.txt       --wx out/08/s/08089-otero-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08091-Ouray-County.txt       --wx out/08/s/08091-ouray-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08099-Prowers-County.txt     --wx out/08/s/08099-prowers-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08101-Pueblo-County.txt      --wx out/08/s/08101-pueblo-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08105-Rio-Grande-County.txt  --wx out/08/s/08105-rio-grande-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08109-Saguache-County.txt    --wx out/08/s/08109-saguache-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08111-San-Juan-County.txt    --wx out/08/s/08111-san-juan-county.osm.bz2 \
    --bp completeWays=yes file=polys/08/08113-San-Miguel-County.txt  --wx out/08/s/08113-san-miguel-county.osm.bz2 \

./skeletron-routes.sh tmp/colorado-routes.osm.bz2 out/08 colorado
./skeletron-roads.sh tmp/colorado-roads.osm.pbf out/08 colorado
