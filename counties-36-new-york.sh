#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/36

curl -s -o tmp/new-york.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/new-york.osm.pbf

osmosis --rb tmp/new-york.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/new-york-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-B.osm.pbf \
            --tf accept-relations "network=US:NY" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-C.osm.pbf \
            --tf accept-relations "network=US:NY:CR" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-D.osm.pbf \

osmosis \
    --rb tmp/new-york-routes-A.osm.pbf \
    --rb tmp/new-york-routes-B.osm.pbf \
    --rb tmp/new-york-routes-C.osm.pbf \
    --rb tmp/new-york-routes-D.osm.pbf \
    --merge --merge --merge \
    --tee outputCount=7 \
    --bp completeWays=yes file=polys/36005-Bronx-County.txt         --wx out/36/36005-bronx-routes.osm.bz2 \
    --bp completeWays=yes file=polys/36047-Kings-County.txt         --wx out/36/36047-kings-routes.osm.bz2 \
    --bp completeWays=yes file=polys/36059-Nassau-County.txt        --wx out/36/36059-nassau-routes.osm.bz2 \
    --bp completeWays=yes file=polys/36061-New-York-County.txt      --wx out/36/36061-new-york-routes.osm.bz2 \
    --bp completeWays=yes file=polys/36081-Queens-County.txt        --wx out/36/36081-queens-routes.osm.bz2 \
    --bp completeWays=yes file=polys/36085-Richmond-County.txt      --wx out/36/36085-richmond-routes.osm.bz2 \
    --bp completeWays=yes file=polys/36119-Westchester-County.txt   --wx out/36/36119-westchester-routes.osm.bz2 \

osmosis \
    --rb tmp/new-york-roads.osm.pbf \
    --tee outputCount=7 \
    --bp completeWays=yes file=polys/36005-Bronx-County.txt         --wx out/36/36005-bronx-roads.osm.bz2 \
    --bp completeWays=yes file=polys/36047-Kings-County.txt         --wx out/36/36047-kings-roads.osm.bz2 \
    --bp completeWays=yes file=polys/36059-Nassau-County.txt        --wx out/36/36059-nassau-roads.osm.bz2 \
    --bp completeWays=yes file=polys/36061-New-York-County.txt      --wx out/36/36061-new-york-roads.osm.bz2 \
    --bp completeWays=yes file=polys/36081-Queens-County.txt        --wx out/36/36081-queens-roads.osm.bz2 \
    --bp completeWays=yes file=polys/36085-Richmond-County.txt      --wx out/36/36085-richmond-roads.osm.bz2 \
    --bp completeWays=yes file=polys/36119-Westchester-County.txt   --wx out/36/36119-westchester-roads.osm.bz2 \
