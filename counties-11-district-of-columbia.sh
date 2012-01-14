#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/11

curl -Rs -o tmp/district-of-columbia.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/district-of-columbia.osm.pbf

osmosis --rb tmp/district-of-columbia.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/district-of-columbia-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/district-of-columbia-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/district-of-columbia-routes-B.osm.pbf \
            --tf accept-relations "network=US:DC" --used-way --used-node --wb omitmetadata=true tmp/district-of-columbia-routes-C.osm.pbf \
            --tf accept-relations "network=US:DC:CR" --used-way --used-node --wb omitmetadata=true tmp/district-of-columbia-routes-D.osm.pbf \

osmosis \
    --rb tmp/district-of-columbia-routes-A.osm.pbf \
    --rb tmp/district-of-columbia-routes-B.osm.pbf \
    --rb tmp/district-of-columbia-routes-C.osm.pbf \
    --rb tmp/district-of-columbia-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/district-of-columbia-routes.osm.bz2

osmosis \
    --rb tmp/district-of-columbia-roads.osm.pbf \
    --tee outputCount=1 \
    --bp completeWays=yes file=polys/11/11001-District-of-Columbia.txt --wx out/11/11001-district-of-columbia-roads.osm.bz2 \

touch -r tmp/district-of-columbia.osm.pbf out/11/*.osm.???

./skeletron-roads.sh tmp/district-of-columbia-roads.osm.pbf out/11 district-of-columbia
./skeletron-routes.sh tmp/district-of-columbia-routes.osm.bz2 out/11 district-of-columbia
