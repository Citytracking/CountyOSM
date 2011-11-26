#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/44

curl -Rs -o tmp/rhode-island.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/rhode-island.osm.pbf

osmosis --rb tmp/rhode-island.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/rhode-island-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/rhode-island-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/rhode-island-routes-B.osm.pbf \
            --tf accept-relations "network=US:RI" --used-way --used-node --wb omitmetadata=true tmp/rhode-island-routes-C.osm.pbf \
            --tf accept-relations "network=US:RI:CR" --used-way --used-node --wb omitmetadata=true tmp/rhode-island-routes-D.osm.pbf \

osmosis \
    --rb tmp/rhode-island-routes-A.osm.pbf \
    --rb tmp/rhode-island-routes-B.osm.pbf \
    --rb tmp/rhode-island-routes-C.osm.pbf \
    --rb tmp/rhode-island-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/rhode-island-routes.osm.bz2

osmosis \
    --rb tmp/rhode-island-roads.osm.pbf \
    --tee outputCount=5 \
    --bp completeWays=yes file=polys/44/44001-Bristol-County.txt       --wx out/44/44001-bristol-roads.osm.bz2 \
    --bp completeWays=yes file=polys/44/44003-Kent-County.txt          --wx out/44/44003-kent-roads.osm.bz2 \
    --bp completeWays=yes file=polys/44/44005-Newport-County.txt       --wx out/44/44005-newport-roads.osm.bz2 \
    --bp completeWays=yes file=polys/44/44007-Providence-County.txt    --wx out/44/44007-providence-roads.osm.bz2 \
    --bp completeWays=yes file=polys/44/44009-Washington-County.txt    --wx out/44/44009-washington-roads.osm.bz2 \

touch -r tmp/rhode-island.osm.pbf out/44/*.osm.???

./skeletron-roads.sh tmp/rhode-island-roads.osm.pbf out/44 rhode-island
./skeletron-routes.sh tmp/rhode-island-routes.osm.bz2 out/44 rhode-island
