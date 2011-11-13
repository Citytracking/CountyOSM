#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/09

curl -s -o tmp/connecticut.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/connecticut.osm.pbf

osmosis --rb tmp/connecticut.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/connecticut-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/connecticut-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/connecticut-routes-B.osm.pbf \
            --tf accept-relations "network=US:CT" --used-way --used-node --wb omitmetadata=true tmp/connecticut-routes-C.osm.pbf \
            --tf accept-relations "network=US:CT:CR" --used-way --used-node --wb omitmetadata=true tmp/connecticut-routes-D.osm.pbf \

osmosis \
    --rb tmp/connecticut-routes-A.osm.pbf \
    --rb tmp/connecticut-routes-B.osm.pbf \
    --rb tmp/connecticut-routes-C.osm.pbf \
    --rb tmp/connecticut-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/connecticut-routes.osm.bz2

osmosis \
    --rb tmp/connecticut-roads.osm.pbf \
    --tee outputCount=8 \
    --bp completeWays=yes file=polys/09/09001-Fairfield-County.txt  --wx out/09/09001-fairfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09003-Hartford-County.txt   --wx out/09/09003-hartford-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09005-Litchfield-County.txt --wx out/09/09005-litchfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09007-Middlesex-County.txt  --wx out/09/09007-middlesex-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09009-New-Haven-County.txt  --wx out/09/09009-new-haven-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09011-New-London-County.txt --wx out/09/09011-new-london-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09013-Tolland-County.txt    --wx out/09/09013-tolland-county.osm.bz2 \
    --bp completeWays=yes file=polys/09/09015-Windham-County.txt    --wx out/09/09015-windham-county.osm.bz2 \

./skeletron-roads.sh tmp/connecticut-roads.osm.pbf out/09 connecticut
./skeletron-routes.sh tmp/connecticut-routes.osm.bz2 out/09 connecticut
