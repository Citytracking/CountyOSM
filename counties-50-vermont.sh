#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/50

curl -Rs -o tmp/vermont.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/vermont.osm.pbf

osmosis --rb tmp/vermont.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/vermont-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/vermont-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/vermont-routes-B.osm.pbf \
            --tf accept-relations "network=US:VT" --used-way --used-node --wb omitmetadata=true tmp/vermont-routes-C.osm.pbf \
            --tf accept-relations "network=US:VT:CR" --used-way --used-node --wb omitmetadata=true tmp/vermont-routes-D.osm.pbf \

osmosis \
    --rb tmp/vermont-routes-A.osm.pbf \
    --rb tmp/vermont-routes-B.osm.pbf \
    --rb tmp/vermont-routes-C.osm.pbf \
    --rb tmp/vermont-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/vermont-routes.osm.bz2

osmosis \
    --rb tmp/vermont-roads.osm.pbf \
    --tee outputCount=14 \
    --bp completeWays=yes file=polys/50/50001-Addison-County.txt    --wx out/50/50001-addison-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50003-Bennington-County.txt --wx out/50/50003-bennington-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50005-Caledonia-County.txt  --wx out/50/50005-caledonia-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50007-Chittenden-County.txt --wx out/50/50007-chittenden-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50009-Essex-County.txt      --wx out/50/50009-essex-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50011-Franklin-County.txt   --wx out/50/50011-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50013-Grand-Isle-County.txt --wx out/50/50013-grand-isle-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50015-Lamoille-County.txt   --wx out/50/50015-lamoille-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50017-Orange-County.txt     --wx out/50/50017-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50019-Orleans-County.txt    --wx out/50/50019-orleans-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50021-Rutland-County.txt    --wx out/50/50021-rutland-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50023-Washington-County.txt --wx out/50/50023-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50025-Windham-County.txt    --wx out/50/50025-windham-county.osm.bz2 \
    --bp completeWays=yes file=polys/50/50027-Windsor-County.txt    --wx out/50/50027-windsor-county.osm.bz2 \

touch -r tmp/vermont.osm.pbf out/50/*.osm.???

./skeletron-roads.sh tmp/vermont-roads.osm.pbf out/50 vermont
./skeletron-routes.sh tmp/vermont-routes.osm.bz2 out/50 vermont

touch -r tmp/vermont.osm.pbf out/50/*.pgsql
