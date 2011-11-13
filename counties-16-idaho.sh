#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/16/w out/16/c out/16/e

curl -s -o tmp/idaho.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/idaho.osm.pbf

osmosis --rb tmp/idaho.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/idaho-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/idaho-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/idaho-routes-B.osm.pbf \
            --tf accept-relations "network=US:ID" --used-way --used-node --wb omitmetadata=true tmp/idaho-routes-C.osm.pbf \
            --tf accept-relations "network=US:ID:CR" --used-way --used-node --wb omitmetadata=true tmp/idaho-routes-D.osm.pbf \

osmosis \
    --rb tmp/idaho-routes-A.osm.pbf \
    --rb tmp/idaho-routes-B.osm.pbf \
    --rb tmp/idaho-routes-C.osm.pbf \
    --rb tmp/idaho-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/idaho-routes.osm.bz2

osmosis \
    --rb tmp/idaho-roads.osm.pbf \
    --tee outputCount=44 \
    --bp completeWays=yes file=polys/16/16001-Ada-County.txt        --wx out/16/w/16001-ada-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16003-Adams-County.txt      --wx out/16/w/16003-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16009-Benewah-County.txt    --wx out/16/w/16009-benewah-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16015-Boise-County.txt      --wx out/16/w/16015-boise-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16017-Bonner-County.txt     --wx out/16/w/16017-bonner-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16021-Boundary-County.txt   --wx out/16/w/16021-boundary-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16027-Canyon-County.txt     --wx out/16/w/16027-canyon-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16035-Clearwater-County.txt --wx out/16/w/16035-clearwater-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16039-Elmore-County.txt     --wx out/16/w/16039-elmore-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16045-Gem-County.txt        --wx out/16/w/16045-gem-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16049-Idaho-County.txt      --wx out/16/w/16049-idaho-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16055-Kootenai-County.txt   --wx out/16/w/16055-kootenai-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16057-Latah-County.txt      --wx out/16/w/16057-latah-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16061-Lewis-County.txt      --wx out/16/w/16061-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16069-Nez-Perce-County.txt  --wx out/16/w/16069-nez-perce-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16073-Owyhee-County.txt     --wx out/16/w/16073-owyhee-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16075-Payette-County.txt    --wx out/16/w/16075-payette-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16079-Shoshone-County.txt   --wx out/16/w/16079-shoshone-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16085-Valley-County.txt     --wx out/16/w/16085-valley-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16087-Washington-County.txt --wx out/16/w/16087-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16013-Blaine-County.txt     --wx out/16/c/16013-blaine-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16023-Butte-County.txt      --wx out/16/c/16023-butte-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16025-Camas-County.txt      --wx out/16/c/16025-camas-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16031-Cassia-County.txt     --wx out/16/c/16031-cassia-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16037-Custer-County.txt     --wx out/16/c/16037-custer-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16047-Gooding-County.txt    --wx out/16/c/16047-gooding-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16053-Jerome-County.txt     --wx out/16/c/16053-jerome-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16059-Lemhi-County.txt      --wx out/16/c/16059-lemhi-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16063-Lincoln-County.txt    --wx out/16/c/16063-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16067-Minidoka-County.txt   --wx out/16/c/16067-minidoka-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16083-Twin-Falls-County.txt --wx out/16/c/16083-twin-falls-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16005-Bannock-County.txt    --wx out/16/e/16005-bannock-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16007-Bear-Lake-County.txt  --wx out/16/e/16007-bear-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16011-Bingham-County.txt    --wx out/16/e/16011-bingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16019-Bonneville-County.txt --wx out/16/e/16019-bonneville-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16029-Caribou-County.txt    --wx out/16/e/16029-caribou-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16033-Clark-County.txt      --wx out/16/e/16033-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16041-Franklin-County.txt   --wx out/16/e/16041-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16043-Fremont-County.txt    --wx out/16/e/16043-fremont-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16051-Jefferson-County.txt  --wx out/16/e/16051-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16065-Madison-County.txt    --wx out/16/e/16065-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16071-Oneida-County.txt     --wx out/16/e/16071-oneida-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16077-Power-County.txt      --wx out/16/e/16077-power-county.osm.bz2 \
    --bp completeWays=yes file=polys/16/16081-Teton-County.txt      --wx out/16/e/16081-teton-county.osm.bz2 \

./skeletron-roads.sh tmp/idaho-roads.osm.pbf out/16 idaho
./skeletron-routes.sh tmp/idaho-routes.osm.bz2 out/16 idaho
