#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/41/n out/41/s

curl -s -o tmp/oregon.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/oregon.osm.pbf

osmosis --rb tmp/oregon.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/oregon-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/oregon-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/oregon-routes-B.osm.pbf \
            --tf accept-relations "network=US:OR" --used-way --used-node --wb omitmetadata=true tmp/oregon-routes-C.osm.pbf \
            --tf accept-relations "network=US:OR:CR" --used-way --used-node --wb omitmetadata=true tmp/oregon-routes-D.osm.pbf \

osmosis \
    --rb tmp/oregon-routes-A.osm.pbf \
    --rb tmp/oregon-routes-B.osm.pbf \
    --rb tmp/oregon-routes-C.osm.pbf \
    --rb tmp/oregon-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/oregon-routes.osm.bz2

osmosis \
    --rb tmp/oregon-roads.osm.pbf \
    --tee outputCount=36 \
    --bp completeWays=yes file=polys/41/41001-Baker-County.txt      --wx out/41/n/41001-baker-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41003-Benton-County.txt     --wx out/41/n/41003-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41005-Clackamas-County.txt  --wx out/41/n/41005-clackamas-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41007-Clatsop-County.txt    --wx out/41/n/41007-clatsop-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41009-Columbia-County.txt   --wx out/41/n/41009-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41021-Gilliam-County.txt    --wx out/41/n/41021-gilliam-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41023-Grant-County.txt      --wx out/41/n/41023-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41027-Hood-River-County.txt --wx out/41/n/41027-hood-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41031-Jefferson-County.txt  --wx out/41/n/41031-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41041-Lincoln-County.txt    --wx out/41/n/41041-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41043-Linn-County.txt       --wx out/41/n/41043-linn-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41047-Marion-County.txt     --wx out/41/n/41047-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41049-Morrow-County.txt     --wx out/41/n/41049-morrow-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41051-Multnomah-County.txt  --wx out/41/n/41051-multnomah-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41053-Polk-County.txt       --wx out/41/n/41053-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41055-Sherman-County.txt    --wx out/41/n/41055-sherman-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41057-Tillamook-County.txt  --wx out/41/n/41057-tillamook-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41059-Umatilla-County.txt   --wx out/41/n/41059-umatilla-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41061-Union-County.txt      --wx out/41/n/41061-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41063-Wallowa-County.txt    --wx out/41/n/41063-wallowa-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41065-Wasco-County.txt      --wx out/41/n/41065-wasco-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41067-Washington-County.txt --wx out/41/n/41067-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41069-Wheeler-County.txt    --wx out/41/n/41069-wheeler-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41071-Yamhill-County.txt    --wx out/41/n/41071-yamhill-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41011-Coos-County.txt       --wx out/41/s/41011-coos-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41013-Crook-County.txt      --wx out/41/s/41013-crook-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41015-Curry-County.txt      --wx out/41/s/41015-curry-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41017-Deschutes-County.txt  --wx out/41/s/41017-deschutes-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41019-Douglas-County.txt    --wx out/41/s/41019-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41025-Harney-County.txt     --wx out/41/s/41025-harney-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41029-Jackson-County.txt    --wx out/41/s/41029-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41033-Josephine-County.txt  --wx out/41/s/41033-josephine-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41035-Klamath-County.txt    --wx out/41/s/41035-klamath-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41037-Lake-County.txt       --wx out/41/s/41037-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41039-Lane-County.txt       --wx out/41/s/41039-lane-county.osm.bz2 \
    --bp completeWays=yes file=polys/41/41045-Malheur-County.txt    --wx out/41/s/41045-malheur-county.osm.bz2 \

