#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/53/n out/53/s

curl -s -o tmp/washington.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/washington.osm.pbf

osmosis --rb tmp/washington.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/washington-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/washington-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/washington-routes-B.osm.pbf \
            --tf accept-relations "network=US:WA" --used-way --used-node --wb omitmetadata=true tmp/washington-routes-C.osm.pbf \
            --tf accept-relations "network=US:WA:CR" --used-way --used-node --wb omitmetadata=true tmp/washington-routes-D.osm.pbf \

osmosis \
    --rb tmp/washington-routes-A.osm.pbf \
    --rb tmp/washington-routes-B.osm.pbf \
    --rb tmp/washington-routes-C.osm.pbf \
    --rb tmp/washington-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/washington-routes.osm.bz2

osmosis \
    --rb tmp/washington-roads.osm.pbf \
    --tee outputCount=39 \
    --bp completeWays=yes file=polys/53/53007-Chelan-County.txt       --wx out/53/n/53007-chelan-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53009-Clallam-County.txt      --wx out/53/n/53009-clallam-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53017-Douglas-County.txt      --wx out/53/n/53017-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53019-Ferry-County.txt        --wx out/53/n/53019-ferry-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53029-Island-County.txt       --wx out/53/n/53029-island-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53031-Jefferson-County.txt    --wx out/53/n/53031-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53033-King-County.txt         --wx out/53/n/53033-king-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53035-Kitsap-County.txt       --wx out/53/n/53035-kitsap-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53043-Lincoln-County.txt      --wx out/53/n/53043-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53047-Okanogan-County.txt     --wx out/53/n/53047-okanogan-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53051-Pend-Oreille-County.txt --wx out/53/n/53051-pend-oreille-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53055-San-Juan-County.txt     --wx out/53/n/53055-san-juan-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53057-Skagit-County.txt       --wx out/53/n/53057-skagit-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53061-Snohomish-County.txt    --wx out/53/n/53061-snohomish-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53063-Spokane-County.txt      --wx out/53/n/53063-spokane-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53065-Stevens-County.txt      --wx out/53/n/53065-stevens-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53073-Whatcom-County.txt      --wx out/53/n/53073-whatcom-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53001-Adams-County.txt        --wx out/53/s/53001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53003-Asotin-County.txt       --wx out/53/s/53003-asotin-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53005-Benton-County.txt       --wx out/53/s/53005-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53011-Clark-County.txt        --wx out/53/s/53011-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53013-Columbia-County.txt     --wx out/53/s/53013-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53015-Cowlitz-County.txt      --wx out/53/s/53015-cowlitz-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53021-Franklin-County.txt     --wx out/53/s/53021-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53023-Garfield-County.txt     --wx out/53/s/53023-garfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53025-Grant-County.txt        --wx out/53/s/53025-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53027-Grays-Harbor-County.txt --wx out/53/s/53027-grays-harbor-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53037-Kittitas-County.txt     --wx out/53/s/53037-kittitas-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53039-Klickitat-County.txt    --wx out/53/s/53039-klickitat-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53041-Lewis-County.txt        --wx out/53/s/53041-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53045-Mason-County.txt        --wx out/53/s/53045-mason-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53049-Pacific-County.txt      --wx out/53/s/53049-pacific-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53053-Pierce-County.txt       --wx out/53/s/53053-pierce-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53059-Skamania-County.txt     --wx out/53/s/53059-skamania-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53067-Thurston-County.txt     --wx out/53/s/53067-thurston-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53069-Wahkiakum-County.txt    --wx out/53/s/53069-wahkiakum-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53071-Walla-Walla-County.txt  --wx out/53/s/53071-walla-walla-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53075-Whitman-County.txt      --wx out/53/s/53075-whitman-county.osm.bz2 \
    --bp completeWays=yes file=polys/53/53077-Yakima-County.txt       --wx out/53/s/53077-yakima-county.osm.bz2 \

./skeletron-roads.sh tmp/washington-roads.osm.pbf out/53 washington
./skeletron-routes.sh tmp/washington-routes.osm.bz2 out/53 washington
