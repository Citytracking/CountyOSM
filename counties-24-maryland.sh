#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/24

curl -Rs -o tmp/maryland.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/maryland.osm.pbf

osmosis --rb tmp/maryland.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/maryland-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/maryland-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/maryland-routes-B.osm.pbf \
            --tf accept-relations "network=US:MD" --used-way --used-node --wb omitmetadata=true tmp/maryland-routes-C.osm.pbf \
            --tf accept-relations "network=US:MD:CR" --used-way --used-node --wb omitmetadata=true tmp/maryland-routes-D.osm.pbf \

osmosis \
    --rb tmp/maryland-routes-A.osm.pbf \
    --rb tmp/maryland-routes-B.osm.pbf \
    --rb tmp/maryland-routes-C.osm.pbf \
    --rb tmp/maryland-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/maryland-routes.osm.bz2

osmosis \
    --rb tmp/maryland-roads.osm.pbf \
    --tee outputCount=24 \
    --bp completeWays=yes file=polys/24/24001-Allegany-County.txt       --wx out/24/24001-allegany-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24003-Anne-Arundel-County.txt   --wx out/24/24003-anne-arundel-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24005-Baltimore-County.txt      --wx out/24/24005-baltimore-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24009-Calvert-County.txt        --wx out/24/24009-calvert-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24011-Caroline-County.txt       --wx out/24/24011-caroline-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24013-Carroll-County.txt        --wx out/24/24013-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24015-Cecil-County.txt          --wx out/24/24015-cecil-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24017-Charles-County.txt        --wx out/24/24017-charles-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24019-Dorchester-County.txt     --wx out/24/24019-dorchester-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24021-Frederick-County.txt      --wx out/24/24021-frederick-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24023-Garrett-County.txt        --wx out/24/24023-garrett-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24025-Harford-County.txt        --wx out/24/24025-harford-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24027-Howard-County.txt         --wx out/24/24027-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24029-Kent-County.txt           --wx out/24/24029-kent-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24031-Montgomery-County.txt     --wx out/24/24031-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24033-Prince-Georges-County.txt --wx out/24/24033-prince-georges-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24035-Queen-Annes-County.txt    --wx out/24/24035-queen-annes-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24037-St.-Marys-County.txt      --wx out/24/24037-st.-marys-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24039-Somerset-County.txt       --wx out/24/24039-somerset-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24041-Talbot-County.txt         --wx out/24/24041-talbot-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24043-Washington-County.txt     --wx out/24/24043-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24045-Wicomico-County.txt       --wx out/24/24045-wicomico-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24047-Worcester-County.txt      --wx out/24/24047-worcester-county.osm.bz2 \
    --bp completeWays=yes file=polys/24/24510-Baltimore-city.txt        --wx out/24/24510-baltimore-city.osm.bz2 \

touch -r tmp/maryland.osm.pbf out/24/*.osm.???

./skeletron-roads.sh tmp/maryland-roads.osm.pbf out/24 maryland MD
./skeletron-routes.sh tmp/maryland-routes.osm.bz2 out/24 maryland MD
