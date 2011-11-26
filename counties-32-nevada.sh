#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/32/w out/32/c out/32/e

curl -Rs -o tmp/nevada.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/nevada.osm.pbf

osmosis --rb tmp/nevada.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/nevada-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/nevada-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/nevada-routes-B.osm.pbf \
            --tf accept-relations "network=US:NV" --used-way --used-node --wb omitmetadata=true tmp/nevada-routes-C.osm.pbf \
            --tf accept-relations "network=US:NV:CR" --used-way --used-node --wb omitmetadata=true tmp/nevada-routes-D.osm.pbf \

osmosis \
    --rb tmp/nevada-routes-A.osm.pbf \
    --rb tmp/nevada-routes-B.osm.pbf \
    --rb tmp/nevada-routes-C.osm.pbf \
    --rb tmp/nevada-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/nevada-routes.osm.bz2

osmosis \
    --rb tmp/nevada-roads.osm.pbf \
    --tee outputCount=17 \
    --bp completeWays=yes file=polys/32/32001-Churchill-County.txt  --wx out/32/w/32001-churchill-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32005-Douglas-County.txt    --wx out/32/w/32005-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32009-Esmeralda-County.txt  --wx out/32/w/32009-esmeralda-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32013-Humboldt-County.txt   --wx out/32/w/32013-humboldt-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32019-Lyon-County.txt       --wx out/32/w/32019-lyon-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32021-Mineral-County.txt    --wx out/32/w/32021-mineral-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32027-Pershing-County.txt   --wx out/32/w/32027-pershing-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32029-Storey-County.txt     --wx out/32/w/32029-storey-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32031-Washoe-County.txt     --wx out/32/w/32031-washoe-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32510-Carson-City.txt       --wx out/32/w/32510-carson-city.osm.bz2 \
    --bp completeWays=yes file=polys/32/32015-Lander-County.txt     --wx out/32/c/32015-lander-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32023-Nye-County.txt        --wx out/32/c/32023-nye-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32003-Clark-County.txt      --wx out/32/e/32003-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32007-Elko-County.txt       --wx out/32/e/32007-elko-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32011-Eureka-County.txt     --wx out/32/e/32011-eureka-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32017-Lincoln-County.txt    --wx out/32/e/32017-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/32/32033-White-Pine-County.txt --wx out/32/e/32033-white-pine-county.osm.bz2 \

touch -r tmp/nevada.osm.pbf out/32/*/*.osm.???

./skeletron-roads.sh tmp/nevada-roads.osm.pbf out/32 nevada
./skeletron-routes.sh tmp/nevada-routes.osm.bz2 out/32 nevada
