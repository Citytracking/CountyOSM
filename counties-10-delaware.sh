#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/10

curl -Rs -o tmp/delaware.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/delaware.osm.pbf

osmosis --rb tmp/delaware.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/delaware-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/delaware-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/delaware-routes-B.osm.pbf \
            --tf accept-relations "network=US:DE" --used-way --used-node --wb omitmetadata=true tmp/delaware-routes-C.osm.pbf \
            --tf accept-relations "network=US:DE:CR" --used-way --used-node --wb omitmetadata=true tmp/delaware-routes-D.osm.pbf \

osmosis \
    --rb tmp/delaware-routes-A.osm.pbf \
    --rb tmp/delaware-routes-B.osm.pbf \
    --rb tmp/delaware-routes-C.osm.pbf \
    --rb tmp/delaware-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/delaware-routes.osm.bz2

osmosis \
    --rb tmp/delaware-roads.osm.pbf \
    --tee outputCount=3 \
    --bp completeWays=yes file=polys/10/10001-Kent-County.txt          --wx out/10/10001-kent-roads.osm.bz2 \
    --bp completeWays=yes file=polys/10/10003-New-Castle-County.txt    --wx out/10/10003-new-castle-roads.osm.bz2 \
    --bp completeWays=yes file=polys/10/10005-Sussex-County.txt        --wx out/10/10005-sussex-roads.osm.bz2 \

touch -r tmp/delaware.osm.pbf out/10/*.osm.???

./skeletron-roads.sh tmp/delaware-roads.osm.pbf out/10 delaware
./skeletron-routes.sh tmp/delaware-routes.osm.bz2 out/10 delaware
