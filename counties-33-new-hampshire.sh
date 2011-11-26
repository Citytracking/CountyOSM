#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/33

curl -Rs -o tmp/new-hampshire.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/new-hampshire.osm.pbf

osmosis --rb tmp/new-hampshire.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/new-hampshire-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/new-hampshire-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/new-hampshire-routes-B.osm.pbf \
            --tf accept-relations "network=US:NH" --used-way --used-node --wb omitmetadata=true tmp/new-hampshire-routes-C.osm.pbf \
            --tf accept-relations "network=US:NH:CR" --used-way --used-node --wb omitmetadata=true tmp/new-hampshire-routes-D.osm.pbf \

osmosis \
    --rb tmp/new-hampshire-routes-A.osm.pbf \
    --rb tmp/new-hampshire-routes-B.osm.pbf \
    --rb tmp/new-hampshire-routes-C.osm.pbf \
    --rb tmp/new-hampshire-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/new-hampshire-routes.osm.bz2

osmosis \
    --rb tmp/new-hampshire-roads.osm.pbf \
    --tee outputCount=10 \
    --bp completeWays=yes file=polys/33/33001-Belknap-County.txt      --wx out/33/33001-belknap-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33003-Carroll-County.txt      --wx out/33/33003-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33005-Cheshire-County.txt     --wx out/33/33005-cheshire-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33007-Coos-County.txt         --wx out/33/33007-coos-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33009-Grafton-County.txt      --wx out/33/33009-grafton-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33011-Hillsborough-County.txt --wx out/33/33011-hillsborough-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33013-Merrimack-County.txt    --wx out/33/33013-merrimack-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33015-Rockingham-County.txt   --wx out/33/33015-rockingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33017-Strafford-County.txt    --wx out/33/33017-strafford-county.osm.bz2 \
    --bp completeWays=yes file=polys/33/33019-Sullivan-County.txt     --wx out/33/33019-sullivan-county.osm.bz2 \

touch -r tmp/new-hampshire.osm.pbf out/33/*.osm.???

./skeletron-roads.sh tmp/new-hampshire-roads.osm.pbf out/33 new-hampshire
./skeletron-routes.sh tmp/new-hampshire-routes.osm.bz2 out/33 new-hampshire

touch -r tmp/new-hampshire.osm.pbf out/33/*.pgsql
