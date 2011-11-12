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
    --bp completeWays=yes file=polys/12/12001-Alachua-County.txt      --wx out/12/n/12001-alachua-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12003-Baker-County.txt        --wx out/12/n/12003-baker-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12005-Bay-County.txt          --wx out/12/n/12005-bay-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12007-Bradford-County.txt     --wx out/12/n/12007-bradford-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12013-Calhoun-County.txt      --wx out/12/n/12013-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12023-Columbia-County.txt     --wx out/12/n/12023-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12029-Dixie-County.txt        --wx out/12/n/12029-dixie-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12033-Escambia-County.txt     --wx out/12/n/12033-escambia-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12037-Franklin-County.txt     --wx out/12/n/12037-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12039-Gadsden-County.txt      --wx out/12/n/12039-gadsden-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12041-Gilchrist-County.txt    --wx out/12/n/12041-gilchrist-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12045-Gulf-County.txt         --wx out/12/n/12045-gulf-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12047-Hamilton-County.txt     --wx out/12/n/12047-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12059-Holmes-County.txt       --wx out/12/n/12059-holmes-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12063-Jackson-County.txt      --wx out/12/n/12063-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12065-Jefferson-County.txt    --wx out/12/n/12065-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12067-Lafayette-County.txt    --wx out/12/n/12067-lafayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12073-Leon-County.txt         --wx out/12/n/12073-leon-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12077-Liberty-County.txt      --wx out/12/n/12077-liberty-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12079-Madison-County.txt      --wx out/12/n/12079-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12091-Okaloosa-County.txt     --wx out/12/n/12091-okaloosa-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12113-Santa-Rosa-County.txt   --wx out/12/n/12113-santa-rosa-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12121-Suwannee-County.txt     --wx out/12/n/12121-suwannee-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12123-Taylor-County.txt       --wx out/12/n/12123-taylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12125-Union-County.txt        --wx out/12/n/12125-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12129-Wakulla-County.txt      --wx out/12/n/12129-wakulla-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12131-Walton-County.txt       --wx out/12/n/12131-walton-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12133-Washington-County.txt   --wx out/12/n/12133-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12015-Charlotte-County.txt    --wx out/12/w/12015-charlotte-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12017-Citrus-County.txt       --wx out/12/w/12017-citrus-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12027-DeSoto-County.txt       --wx out/12/w/12027-desoto-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12049-Hardee-County.txt       --wx out/12/w/12049-hardee-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12053-Hernando-County.txt     --wx out/12/w/12053-hernando-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12057-Hillsborough-County.txt --wx out/12/w/12057-hillsborough-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12071-Lee-County.txt          --wx out/12/w/12071-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12075-Levy-County.txt         --wx out/12/w/12075-levy-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12081-Manatee-County.txt      --wx out/12/w/12081-manatee-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12083-Marion-County.txt       --wx out/12/w/12083-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12101-Pasco-County.txt        --wx out/12/w/12101-pasco-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12103-Pinellas-County.txt     --wx out/12/w/12103-pinellas-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12105-Polk-County.txt         --wx out/12/w/12105-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12115-Sarasota-County.txt     --wx out/12/w/12115-sarasota-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12119-Sumter-County.txt       --wx out/12/w/12119-sumter-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12009-Brevard-County.txt      --wx out/12/e/12009-brevard-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12011-Broward-County.txt      --wx out/12/e/12011-broward-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12019-Clay-County.txt         --wx out/12/e/12019-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12021-Collier-County.txt      --wx out/12/e/12021-collier-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12031-Duval-County.txt        --wx out/12/e/12031-duval-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12035-Flagler-County.txt      --wx out/12/e/12035-flagler-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12043-Glades-County.txt       --wx out/12/e/12043-glades-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12051-Hendry-County.txt       --wx out/12/e/12051-hendry-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12055-Highlands-County.txt    --wx out/12/e/12055-highlands-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12061-Indian-River-County.txt --wx out/12/e/12061-indian-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12069-Lake-County.txt         --wx out/12/e/12069-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12085-Martin-County.txt       --wx out/12/e/12085-martin-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12086-Miami-Dade-County.txt   --wx out/12/e/12086-miami-dade-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12087-Monroe-County.txt       --wx out/12/e/12087-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12089-Nassau-County.txt       --wx out/12/e/12089-nassau-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12093-Okeechobee-County.txt   --wx out/12/e/12093-okeechobee-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12095-Orange-County.txt       --wx out/12/e/12095-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12097-Osceola-County.txt      --wx out/12/e/12097-osceola-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12099-Palm-Beach-County.txt   --wx out/12/e/12099-palm-beach-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12107-Putnam-County.txt       --wx out/12/e/12107-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12109-St.-Johns-County.txt    --wx out/12/e/12109-st.-johns-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12111-St.-Lucie-County.txt    --wx out/12/e/12111-st.-lucie-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12117-Seminole-County.txt     --wx out/12/e/12117-seminole-county.osm.bz2 \
    --bp completeWays=yes file=polys/12/12127-Volusia-County.txt      --wx out/12/e/12127-volusia-county.osm.bz2 \

./skeletron-routes.sh tmp/florida-routes.osm.bz2 out/12 florida
./skeletron-roads.sh tmp/florida-roads.osm.pbf out/12 florida
