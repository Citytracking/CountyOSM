#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/25/m out/25/i

curl -Rs -o tmp/massachusetts.osm.pbf -L http://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf

osmosis --rb tmp/massachusetts.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/massachusetts-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/massachusetts-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/massachusetts-routes-B.osm.pbf \
            --tf accept-relations "network=US:MA" --used-way --used-node --wb omitmetadata=true tmp/massachusetts-routes-C.osm.pbf \
            --tf accept-relations "network=US:MA:CR" --used-way --used-node --wb omitmetadata=true tmp/massachusetts-routes-D.osm.pbf \

osmosis \
    --rb tmp/massachusetts-routes-A.osm.pbf \
    --rb tmp/massachusetts-routes-B.osm.pbf \
    --rb tmp/massachusetts-routes-C.osm.pbf \
    --rb tmp/massachusetts-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/massachusetts-routes.osm.bz2

osmosis \
    --rb tmp/massachusetts-roads.osm.pbf \
    --tee outputCount=14 \
    --bp completeWays=yes file=polys/25/25001-Barnstable-County.txt --wx out/25/m/25001-barnstable-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25003-Berkshire-County.txt  --wx out/25/m/25003-berkshire-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25005-Bristol-County.txt    --wx out/25/m/25005-bristol-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25009-Essex-County.txt      --wx out/25/m/25009-essex-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25011-Franklin-County.txt   --wx out/25/m/25011-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25013-Hampden-County.txt    --wx out/25/m/25013-hampden-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25015-Hampshire-County.txt  --wx out/25/m/25015-hampshire-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25017-Middlesex-County.txt  --wx out/25/m/25017-middlesex-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25021-Norfolk-County.txt    --wx out/25/m/25021-norfolk-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25023-Plymouth-County.txt   --wx out/25/m/25023-plymouth-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25025-Suffolk-County.txt    --wx out/25/m/25025-suffolk-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25027-Worcester-County.txt  --wx out/25/m/25027-worcester-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25007-Dukes-County.txt      --wx out/25/i/25007-dukes-county.osm.bz2 \
    --bp completeWays=yes file=polys/25/25019-Nantucket-County.txt  --wx out/25/i/25019-nantucket-county.osm.bz2 \

touch -r tmp/massachusetts.osm.pbf out/25/*/*.osm.???

./skeletron-roads.sh tmp/massachusetts-roads.osm.pbf out/25 massachusetts MA
./skeletron-routes.sh tmp/massachusetts-routes.osm.bz2 out/25 massachusetts MA
