#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/23/w out/23/e

curl -Rs -o tmp/maine.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/maine.osm.pbf

osmosis --rb tmp/maine.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/maine-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/maine-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/maine-routes-B.osm.pbf \
            --tf accept-relations "network=US:ME" --used-way --used-node --wb omitmetadata=true tmp/maine-routes-C.osm.pbf \
            --tf accept-relations "network=US:ME:CR" --used-way --used-node --wb omitmetadata=true tmp/maine-routes-D.osm.pbf \

osmosis \
    --rb tmp/maine-routes-A.osm.pbf \
    --rb tmp/maine-routes-B.osm.pbf \
    --rb tmp/maine-routes-C.osm.pbf \
    --rb tmp/maine-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/maine-routes.osm.bz2

osmosis \
    --rb tmp/maine-roads.osm.pbf \
    --tee outputCount=16 \
    --bp completeWays=yes file=polys/23/23001-Androscoggin-County.txt --wx out/23/w/23001-androscoggin-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23005-Cumberland-County.txt   --wx out/23/w/23005-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23007-Franklin-County.txt     --wx out/23/w/23007-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23011-Kennebec-County.txt     --wx out/23/w/23011-kennebec-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23015-Lincoln-County.txt      --wx out/23/w/23015-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23017-Oxford-County.txt       --wx out/23/w/23017-oxford-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23023-Sagadahoc-County.txt    --wx out/23/w/23023-sagadahoc-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23025-Somerset-County.txt     --wx out/23/w/23025-somerset-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23031-York-County.txt         --wx out/23/w/23031-york-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23003-Aroostook-County.txt    --wx out/23/e/23003-aroostook-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23009-Hancock-County.txt      --wx out/23/e/23009-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23013-Knox-County.txt         --wx out/23/e/23013-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23019-Penobscot-County.txt    --wx out/23/e/23019-penobscot-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23021-Piscataquis-County.txt  --wx out/23/e/23021-piscataquis-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23027-Waldo-County.txt        --wx out/23/e/23027-waldo-county.osm.bz2 \
    --bp completeWays=yes file=polys/23/23029-Washington-County.txt   --wx out/23/e/23029-washington-county.osm.bz2 \

touch -r tmp/maine.osm.pbf out/23/*/*.osm.???

./skeletron-roads.sh tmp/maine-roads.osm.pbf out/23 maine ME
./skeletron-routes.sh tmp/maine-routes.osm.bz2 out/23 maine ME
