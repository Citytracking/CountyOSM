#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/56/w out/56/wc out/56/ec out/56/e

curl -Rs -o tmp/wyoming.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/wyoming.osm.pbf

osmosis --rb tmp/wyoming.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/wyoming-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/wyoming-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/wyoming-routes-B.osm.pbf \
            --tf accept-relations "network=US:WY" --used-way --used-node --wb omitmetadata=true tmp/wyoming-routes-C.osm.pbf \
            --tf accept-relations "network=US:WY:CR" --used-way --used-node --wb omitmetadata=true tmp/wyoming-routes-D.osm.pbf \

osmosis \
    --rb tmp/wyoming-routes-A.osm.pbf \
    --rb tmp/wyoming-routes-B.osm.pbf \
    --rb tmp/wyoming-routes-C.osm.pbf \
    --rb tmp/wyoming-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/wyoming-routes.osm.bz2

osmosis \
    --rb tmp/wyoming-roads.osm.pbf \
    --tee outputCount=23 \
    --bp completeWays=yes file=polys/56/56023-Lincoln-County.txt     --wx out/56/w/56023-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56035-Sublette-County.txt    --wx out/56/w/56035-sublette-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56039-Teton-County.txt       --wx out/56/w/56039-teton-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56041-Uinta-County.txt       --wx out/56/w/56041-uinta-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56013-Fremont-County.txt     --wx out/56/wc/56013-fremont-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56017-Hot-Springs-County.txt --wx out/56/wc/56017-hot-springs-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56029-Park-County.txt        --wx out/56/wc/56029-park-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56037-Sweetwater-County.txt  --wx out/56/wc/56037-sweetwater-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56003-Big-Horn-County.txt    --wx out/56/ec/56003-big-horn-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56007-Carbon-County.txt      --wx out/56/ec/56007-carbon-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56019-Johnson-County.txt     --wx out/56/ec/56019-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56025-Natrona-County.txt     --wx out/56/ec/56025-natrona-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56033-Sheridan-County.txt    --wx out/56/ec/56033-sheridan-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56043-Washakie-County.txt    --wx out/56/ec/56043-washakie-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56001-Albany-County.txt      --wx out/56/e/56001-albany-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56005-Campbell-County.txt    --wx out/56/e/56005-campbell-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56009-Converse-County.txt    --wx out/56/e/56009-converse-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56011-Crook-County.txt       --wx out/56/e/56011-crook-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56015-Goshen-County.txt      --wx out/56/e/56015-goshen-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56021-Laramie-County.txt     --wx out/56/e/56021-laramie-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56027-Niobrara-County.txt    --wx out/56/e/56027-niobrara-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56031-Platte-County.txt      --wx out/56/e/56031-platte-county.osm.bz2 \
    --bp completeWays=yes file=polys/56/56045-Weston-County.txt      --wx out/56/e/56045-weston-county.osm.bz2 \

touch -r tmp/wyoming.osm.pbf out/56/*/*.osm.???

./skeletron-roads.sh tmp/wyoming-roads.osm.pbf out/56 wyoming WY
./skeletron-routes.sh tmp/wyoming-routes.osm.bz2 out/56 wyoming WY
