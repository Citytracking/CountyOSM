#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/12/n out/12/w out/12/e

curl -s -o tmp/florida.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/florida.osm.pbf

osmosis --rb tmp/florida.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/florida-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/florida-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/florida-routes-B.osm.pbf \
            --tf accept-relations "network=US:FL" --used-way --used-node --wb omitmetadata=true tmp/florida-routes-C.osm.pbf \
            --tf accept-relations "network=US:FL:CR" --used-way --used-node --wb omitmetadata=true tmp/florida-routes-D.osm.pbf \

osmosis \
    --rb tmp/florida-routes-A.osm.pbf \
    --rb tmp/florida-routes-B.osm.pbf \
    --rb tmp/florida-routes-C.osm.pbf \
    --rb tmp/florida-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/florida-routes.osm.bz2

osmosis \
    --rb tmp/florida-roads.osm.pbf \
    --tee outputCount=67 \
    --bp completeWays=yes file=polys/12/12001-Alachua-County.txt      --wx out/12001-Alachua-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12003-Baker-County.txt        --wx out/12003-Baker-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12005-Bay-County.txt          --wx out/12005-Bay-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12007-Bradford-County.txt     --wx out/12007-Bradford-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12013-Calhoun-County.txt      --wx out/12013-Calhoun-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12023-Columbia-County.txt     --wx out/12023-Columbia-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12029-Dixie-County.txt        --wx out/12029-Dixie-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12033-Escambia-County.txt     --wx out/12033-Escambia-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12037-Franklin-County.txt     --wx out/12037-Franklin-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12039-Gadsden-County.txt      --wx out/12039-Gadsden-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12041-Gilchrist-County.txt    --wx out/12041-Gilchrist-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12045-Gulf-County.txt         --wx out/12045-Gulf-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12047-Hamilton-County.txt     --wx out/12047-Hamilton-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12059-Holmes-County.txt       --wx out/12059-Holmes-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12063-Jackson-County.txt      --wx out/12063-Jackson-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12065-Jefferson-County.txt    --wx out/12065-Jefferson-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12067-Lafayette-County.txt    --wx out/12067-Lafayette-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12073-Leon-County.txt         --wx out/12073-Leon-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12077-Liberty-County.txt      --wx out/12077-Liberty-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12079-Madison-County.txt      --wx out/12079-Madison-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12091-Okaloosa-County.txt     --wx out/12091-Okaloosa-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12113-Santa-Rosa-County.txt   --wx out/12113-Santa-Rosa-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12121-Suwannee-County.txt     --wx out/12121-Suwannee-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12123-Taylor-County.txt       --wx out/12123-Taylor-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12125-Union-County.txt        --wx out/12125-Union-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12129-Wakulla-County.txt      --wx out/12129-Wakulla-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12131-Walton-County.txt       --wx out/12131-Walton-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12133-Washington-County.txt   --wx out/12133-Washington-County/n/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12015-Charlotte-County.txt    --wx out/12015-Charlotte-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12017-Citrus-County.txt       --wx out/12017-Citrus-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12027-DeSoto-County.txt       --wx out/12027-DeSoto-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12049-Hardee-County.txt       --wx out/12049-Hardee-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12053-Hernando-County.txt     --wx out/12053-Hernando-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12057-Hillsborough-County.txt --wx out/12057-Hillsborough-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12071-Lee-County.txt          --wx out/12071-Lee-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12075-Levy-County.txt         --wx out/12075-Levy-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12081-Manatee-County.txt      --wx out/12081-Manatee-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12083-Marion-County.txt       --wx out/12083-Marion-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12101-Pasco-County.txt        --wx out/12101-Pasco-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12103-Pinellas-County.txt     --wx out/12103-Pinellas-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12105-Polk-County.txt         --wx out/12105-Polk-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12115-Sarasota-County.txt     --wx out/12115-Sarasota-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12119-Sumter-County.txt       --wx out/12119-Sumter-County/w/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12009-Brevard-County.txt      --wx out/12009-Brevard-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12011-Broward-County.txt      --wx out/12011-Broward-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12019-Clay-County.txt         --wx out/12019-Clay-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12021-Collier-County.txt      --wx out/12021-Collier-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12031-Duval-County.txt        --wx out/12031-Duval-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12035-Flagler-County.txt      --wx out/12035-Flagler-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12043-Glades-County.txt       --wx out/12043-Glades-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12051-Hendry-County.txt       --wx out/12051-Hendry-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12055-Highlands-County.txt    --wx out/12055-Highlands-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12061-Indian-River-County.txt --wx out/12061-Indian-River-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12069-Lake-County.txt         --wx out/12069-Lake-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12085-Martin-County.txt       --wx out/12085-Martin-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12086-Miami-Dade-County.txt   --wx out/12086-Miami-Dade-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12087-Monroe-County.txt       --wx out/12087-Monroe-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12089-Nassau-County.txt       --wx out/12089-Nassau-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12093-Okeechobee-County.txt   --wx out/12093-Okeechobee-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12095-Orange-County.txt       --wx out/12095-Orange-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12097-Osceola-County.txt      --wx out/12097-Osceola-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12099-Palm-Beach-County.txt   --wx out/12099-Palm-Beach-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12107-Putnam-County.txt       --wx out/12107-Putnam-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12109-St.-Johns-County.txt    --wx out/12109-St.-Johns-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12111-St.-Lucie-County.txt    --wx out/12111-St.-Lucie-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12117-Seminole-County.txt     --wx out/12117-Seminole-County/e/.osm.bz2 \
    --bp completeWays=yes file=polys/12/12127-Volusia-County.txt      --wx out/12127-Volusia-County/e/.osm.bz2 \

./skeletron-routes.sh tmp/florida-routes.osm.bz2 out/12 florida
./skeletron-roads.sh tmp/florida-roads.osm.pbf out/12 florida
