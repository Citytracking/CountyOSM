#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/04/w out/04/c out/04/e

curl -Rs -o tmp/arizona.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/arizona.osm.pbf

osmosis --rb tmp/arizona.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/arizona-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/arizona-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/arizona-routes-B.osm.pbf \
            --tf accept-relations "network=US:AZ" --used-way --used-node --wb omitmetadata=true tmp/arizona-routes-C.osm.pbf \
            --tf accept-relations "network=US:AZ:CR" --used-way --used-node --wb omitmetadata=true tmp/arizona-routes-D.osm.pbf \

osmosis \
    --rb tmp/arizona-routes-A.osm.pbf \
    --rb tmp/arizona-routes-B.osm.pbf \
    --rb tmp/arizona-routes-C.osm.pbf \
    --rb tmp/arizona-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/arizona-routes.osm.bz2

osmosis \
    --rb tmp/arizona-roads.osm.pbf \
    --tee outputCount=15 \
    --bp completeWays=yes file=polys/04/04012-La-Paz-County.txt     --wx out/04/w/04012-la-paz-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04015-Mohave-County.txt     --wx out/04/w/04015-mohave-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04027-Yuma-County.txt       --wx out/04/w/04027-yuma-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04005-Coconino-County.txt   --wx out/04/c/04005-coconino-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04013-Maricopa-County.txt   --wx out/04/c/04013-maricopa-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04019-Pima-County.txt       --wx out/04/c/04019-pima-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04021-Pinal-County.txt      --wx out/04/c/04021-pinal-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04023-Santa-Cruz-County.txt --wx out/04/c/04023-santa-cruz-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04025-Yavapai-County.txt    --wx out/04/c/04025-yavapai-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04001-Apache-County.txt     --wx out/04/e/04001-apache-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04003-Cochise-County.txt    --wx out/04/e/04003-cochise-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04007-Gila-County.txt       --wx out/04/e/04007-gila-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04009-Graham-County.txt     --wx out/04/e/04009-graham-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04011-Greenlee-County.txt   --wx out/04/e/04011-greenlee-county.osm.bz2 \
    --bp completeWays=yes file=polys/04/04017-Navajo-County.txt     --wx out/04/e/04017-navajo-county.osm.bz2 \

touch -r tmp/arizona.osm.pbf out/04/*/*.osm.???

./skeletron-roads.sh tmp/arizona-roads.osm.pbf out/04 arizona AZ
./skeletron-routes.sh tmp/arizona-routes.osm.bz2 out/04 arizona AZ
