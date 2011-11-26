#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/46/n out/46/s

curl -Rs -o tmp/south-dakota.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/south-dakota.osm.pbf

osmosis --rb tmp/south-dakota.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/south-dakota-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/south-dakota-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/south-dakota-routes-B.osm.pbf \
            --tf accept-relations "network=US:SD" --used-way --used-node --wb omitmetadata=true tmp/south-dakota-routes-C.osm.pbf \
            --tf accept-relations "network=US:SD:CR" --used-way --used-node --wb omitmetadata=true tmp/south-dakota-routes-D.osm.pbf \

osmosis \
    --rb tmp/south-dakota-routes-A.osm.pbf \
    --rb tmp/south-dakota-routes-B.osm.pbf \
    --rb tmp/south-dakota-routes-C.osm.pbf \
    --rb tmp/south-dakota-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/south-dakota-routes.osm.bz2

osmosis \
    --rb tmp/south-dakota-roads.osm.pbf \
    --tee outputCount=66 \
    --bp completeWays=yes file=polys/46/46005-Beadle-County.txt      --wx out/46/n/46005-beadle-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46011-Brookings-County.txt   --wx out/46/n/46011-brookings-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46013-Brown-County.txt       --wx out/46/n/46013-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46019-Butte-County.txt       --wx out/46/n/46019-butte-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46021-Campbell-County.txt    --wx out/46/n/46021-campbell-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46025-Clark-County.txt       --wx out/46/n/46025-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46029-Codington-County.txt   --wx out/46/n/46029-codington-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46031-Corson-County.txt      --wx out/46/n/46031-corson-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46037-Day-County.txt         --wx out/46/n/46037-day-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46039-Deuel-County.txt       --wx out/46/n/46039-deuel-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46041-Dewey-County.txt       --wx out/46/n/46041-dewey-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46045-Edmunds-County.txt     --wx out/46/n/46045-edmunds-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46049-Faulk-County.txt       --wx out/46/n/46049-faulk-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46051-Grant-County.txt       --wx out/46/n/46051-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46057-Hamlin-County.txt      --wx out/46/n/46057-hamlin-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46059-Hand-County.txt        --wx out/46/n/46059-hand-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46063-Harding-County.txt     --wx out/46/n/46063-harding-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46069-Hyde-County.txt        --wx out/46/n/46069-hyde-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46077-Kingsbury-County.txt   --wx out/46/n/46077-kingsbury-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46081-Lawrence-County.txt    --wx out/46/n/46081-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46089-McPherson-County.txt   --wx out/46/n/46089-mcpherson-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46091-Marshall-County.txt    --wx out/46/n/46091-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46093-Meade-County.txt       --wx out/46/n/46093-meade-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46105-Perkins-County.txt     --wx out/46/n/46105-perkins-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46107-Potter-County.txt      --wx out/46/n/46107-potter-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46109-Roberts-County.txt     --wx out/46/n/46109-roberts-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46115-Spink-County.txt       --wx out/46/n/46115-spink-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46119-Sully-County.txt       --wx out/46/n/46119-sully-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46129-Walworth-County.txt    --wx out/46/n/46129-walworth-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46137-Ziebach-County.txt     --wx out/46/n/46137-ziebach-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46003-Aurora-County.txt      --wx out/46/s/46003-aurora-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46007-Bennett-County.txt     --wx out/46/s/46007-bennett-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46009-Bon-Homme-County.txt   --wx out/46/s/46009-bon-homme-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46015-Brule-County.txt       --wx out/46/s/46015-brule-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46017-Buffalo-County.txt     --wx out/46/s/46017-buffalo-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46023-Charles-Mix-County.txt --wx out/46/s/46023-charles-mix-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46027-Clay-County.txt        --wx out/46/s/46027-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46033-Custer-County.txt      --wx out/46/s/46033-custer-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46035-Davison-County.txt     --wx out/46/s/46035-davison-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46043-Douglas-County.txt     --wx out/46/s/46043-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46047-Fall-River-County.txt  --wx out/46/s/46047-fall-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46053-Gregory-County.txt     --wx out/46/s/46053-gregory-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46055-Haakon-County.txt      --wx out/46/s/46055-haakon-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46061-Hanson-County.txt      --wx out/46/s/46061-hanson-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46065-Hughes-County.txt      --wx out/46/s/46065-hughes-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46067-Hutchinson-County.txt  --wx out/46/s/46067-hutchinson-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46071-Jackson-County.txt     --wx out/46/s/46071-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46073-Jerauld-County.txt     --wx out/46/s/46073-jerauld-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46075-Jones-County.txt       --wx out/46/s/46075-jones-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46079-Lake-County.txt        --wx out/46/s/46079-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46083-Lincoln-County.txt     --wx out/46/s/46083-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46085-Lyman-County.txt       --wx out/46/s/46085-lyman-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46087-McCook-County.txt      --wx out/46/s/46087-mccook-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46095-Mellette-County.txt    --wx out/46/s/46095-mellette-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46097-Miner-County.txt       --wx out/46/s/46097-miner-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46099-Minnehaha-County.txt   --wx out/46/s/46099-minnehaha-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46101-Moody-County.txt       --wx out/46/s/46101-moody-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46103-Pennington-County.txt  --wx out/46/s/46103-pennington-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46111-Sanborn-County.txt     --wx out/46/s/46111-sanborn-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46113-Shannon-County.txt     --wx out/46/s/46113-shannon-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46117-Stanley-County.txt     --wx out/46/s/46117-stanley-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46121-Todd-County.txt        --wx out/46/s/46121-todd-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46123-Tripp-County.txt       --wx out/46/s/46123-tripp-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46125-Turner-County.txt      --wx out/46/s/46125-turner-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46127-Union-County.txt       --wx out/46/s/46127-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/46/46135-Yankton-County.txt     --wx out/46/s/46135-yankton-county.osm.bz2 \

touch -r tmp/south-dakota.osm.pbf out/46/*.osm.???

./skeletron-roads.sh tmp/south-dakota-roads.osm.pbf out/46 south-dakota
./skeletron-routes.sh tmp/south-dakota-routes.osm.bz2 out/46 south-dakota

touch -r tmp/south-dakota.osm.pbf out/46/*.pgsql
