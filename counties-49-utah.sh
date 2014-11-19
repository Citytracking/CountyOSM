#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/49/n out/49/c out/49/s

curl -Rs -o tmp/utah.osm.pbf -L http://download.geofabrik.de/north-america/us/utah-latest.osm.pbf

osmosis --rb tmp/utah.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/utah-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/utah-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/utah-routes-B.osm.pbf \
            --tf accept-relations "network=US:UT" --used-way --used-node --wb omitmetadata=true tmp/utah-routes-C.osm.pbf \
            --tf accept-relations "network=US:UT:CR" --used-way --used-node --wb omitmetadata=true tmp/utah-routes-D.osm.pbf \

osmosis \
    --rb tmp/utah-routes-A.osm.pbf \
    --rb tmp/utah-routes-B.osm.pbf \
    --rb tmp/utah-routes-C.osm.pbf \
    --rb tmp/utah-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/utah-routes.osm.bz2

osmosis \
    --rb tmp/utah-roads.osm.pbf \
    --tee outputCount=29 \
    --bp completeWays=yes file=polys/49/49003-Box-Elder-County.txt  --wx out/49/n/49003-box-elder-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49005-Cache-County.txt      --wx out/49/n/49005-cache-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49009-Daggett-County.txt    --wx out/49/n/49009-daggett-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49011-Davis-County.txt      --wx out/49/n/49011-davis-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49029-Morgan-County.txt     --wx out/49/n/49029-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49033-Rich-County.txt       --wx out/49/n/49033-rich-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49043-Summit-County.txt     --wx out/49/n/49043-summit-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49057-Weber-County.txt      --wx out/49/n/49057-weber-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49007-Carbon-County.txt     --wx out/49/c/49007-carbon-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49013-Duchesne-County.txt   --wx out/49/c/49013-duchesne-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49015-Emery-County.txt      --wx out/49/c/49015-emery-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49019-Grand-County.txt      --wx out/49/c/49019-grand-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49023-Juab-County.txt       --wx out/49/c/49023-juab-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49027-Millard-County.txt    --wx out/49/c/49027-millard-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49035-Salt-Lake-County.txt  --wx out/49/c/49035-salt-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49039-Sanpete-County.txt    --wx out/49/c/49039-sanpete-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49041-Sevier-County.txt     --wx out/49/c/49041-sevier-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49045-Tooele-County.txt     --wx out/49/c/49045-tooele-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49047-Uintah-County.txt     --wx out/49/c/49047-uintah-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49049-Utah-County.txt       --wx out/49/c/49049-utah-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49051-Wasatch-County.txt    --wx out/49/c/49051-wasatch-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49001-Beaver-County.txt     --wx out/49/s/49001-beaver-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49017-Garfield-County.txt   --wx out/49/s/49017-garfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49021-Iron-County.txt       --wx out/49/s/49021-iron-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49025-Kane-County.txt       --wx out/49/s/49025-kane-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49031-Piute-County.txt      --wx out/49/s/49031-piute-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49037-San-Juan-County.txt   --wx out/49/s/49037-san-juan-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49053-Washington-County.txt --wx out/49/s/49053-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/49/49055-Wayne-County.txt      --wx out/49/s/49055-wayne-county.osm.bz2 \

touch -r tmp/utah.osm.pbf out/49/*/*.osm.???

./skeletron-roads.sh tmp/utah-roads.osm.pbf out/49 utah UT
./skeletron-routes.sh tmp/utah-routes.osm.bz2 out/49 utah UT
