#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/40/n out/40/s

curl -Rs -o tmp/oklahoma.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/oklahoma.osm.pbf

osmosis --rb tmp/oklahoma.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/oklahoma-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/oklahoma-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/oklahoma-routes-B.osm.pbf \
            --tf accept-relations "network=US:OK" --used-way --used-node --wb omitmetadata=true tmp/oklahoma-routes-C.osm.pbf \
            --tf accept-relations "network=US:OK:CR" --used-way --used-node --wb omitmetadata=true tmp/oklahoma-routes-D.osm.pbf \

osmosis \
    --rb tmp/oklahoma-routes-A.osm.pbf \
    --rb tmp/oklahoma-routes-B.osm.pbf \
    --rb tmp/oklahoma-routes-C.osm.pbf \
    --rb tmp/oklahoma-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/oklahoma-routes.osm.bz2

osmosis \
    --rb tmp/oklahoma-roads.osm.pbf \
    --tee outputCount=77 \
    --bp completeWays=yes file=polys/40/40001-Adair-County.txt        --wx out/40/n/40001-adair-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40003-Alfalfa-County.txt      --wx out/40/n/40003-alfalfa-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40007-Beaver-County.txt       --wx out/40/n/40007-beaver-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40011-Blaine-County.txt       --wx out/40/n/40011-blaine-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40017-Canadian-County.txt     --wx out/40/n/40017-canadian-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40021-Cherokee-County.txt     --wx out/40/n/40021-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40025-Cimarron-County.txt     --wx out/40/n/40025-cimarron-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40035-Craig-County.txt        --wx out/40/n/40035-craig-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40037-Creek-County.txt        --wx out/40/n/40037-creek-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40039-Custer-County.txt       --wx out/40/n/40039-custer-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40041-Delaware-County.txt     --wx out/40/n/40041-delaware-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40043-Dewey-County.txt        --wx out/40/n/40043-dewey-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40045-Ellis-County.txt        --wx out/40/n/40045-ellis-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40047-Garfield-County.txt     --wx out/40/n/40047-garfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40053-Grant-County.txt        --wx out/40/n/40053-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40059-Harper-County.txt       --wx out/40/n/40059-harper-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40071-Kay-County.txt          --wx out/40/n/40071-kay-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40073-Kingfisher-County.txt   --wx out/40/n/40073-kingfisher-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40081-Lincoln-County.txt      --wx out/40/n/40081-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40083-Logan-County.txt        --wx out/40/n/40083-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40093-Major-County.txt        --wx out/40/n/40093-major-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40097-Mayes-County.txt        --wx out/40/n/40097-mayes-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40101-Muskogee-County.txt     --wx out/40/n/40101-muskogee-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40103-Noble-County.txt        --wx out/40/n/40103-noble-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40105-Nowata-County.txt       --wx out/40/n/40105-nowata-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40107-Okfuskee-County.txt     --wx out/40/n/40107-okfuskee-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40109-Oklahoma-County.txt     --wx out/40/n/40109-oklahoma-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40111-Okmulgee-County.txt     --wx out/40/n/40111-okmulgee-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40113-Osage-County.txt        --wx out/40/n/40113-osage-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40115-Ottawa-County.txt       --wx out/40/n/40115-ottawa-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40117-Pawnee-County.txt       --wx out/40/n/40117-pawnee-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40119-Payne-County.txt        --wx out/40/n/40119-payne-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40129-Roger-Mills-County.txt  --wx out/40/n/40129-roger-mills-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40131-Rogers-County.txt       --wx out/40/n/40131-rogers-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40135-Sequoyah-County.txt     --wx out/40/n/40135-sequoyah-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40139-Texas-County.txt        --wx out/40/n/40139-texas-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40143-Tulsa-County.txt        --wx out/40/n/40143-tulsa-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40145-Wagoner-County.txt      --wx out/40/n/40145-wagoner-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40147-Washington-County.txt   --wx out/40/n/40147-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40151-Woods-County.txt        --wx out/40/n/40151-woods-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40153-Woodward-County.txt     --wx out/40/n/40153-woodward-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40005-Atoka-County.txt        --wx out/40/s/40005-atoka-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40009-Beckham-County.txt      --wx out/40/s/40009-beckham-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40013-Bryan-County.txt        --wx out/40/s/40013-bryan-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40015-Caddo-County.txt        --wx out/40/s/40015-caddo-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40019-Carter-County.txt       --wx out/40/s/40019-carter-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40023-Choctaw-County.txt      --wx out/40/s/40023-choctaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40027-Cleveland-County.txt    --wx out/40/s/40027-cleveland-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40029-Coal-County.txt         --wx out/40/s/40029-coal-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40031-Comanche-County.txt     --wx out/40/s/40031-comanche-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40033-Cotton-County.txt       --wx out/40/s/40033-cotton-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40049-Garvin-County.txt       --wx out/40/s/40049-garvin-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40051-Grady-County.txt        --wx out/40/s/40051-grady-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40055-Greer-County.txt        --wx out/40/s/40055-greer-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40057-Harmon-County.txt       --wx out/40/s/40057-harmon-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40061-Haskell-County.txt      --wx out/40/s/40061-haskell-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40063-Hughes-County.txt       --wx out/40/s/40063-hughes-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40065-Jackson-County.txt      --wx out/40/s/40065-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40067-Jefferson-County.txt    --wx out/40/s/40067-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40069-Johnston-County.txt     --wx out/40/s/40069-johnston-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40075-Kiowa-County.txt        --wx out/40/s/40075-kiowa-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40077-Latimer-County.txt      --wx out/40/s/40077-latimer-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40079-Le-Flore-County.txt     --wx out/40/s/40079-le-flore-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40085-Love-County.txt         --wx out/40/s/40085-love-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40087-McClain-County.txt      --wx out/40/s/40087-mcclain-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40089-McCurtain-County.txt    --wx out/40/s/40089-mccurtain-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40095-Marshall-County.txt     --wx out/40/s/40095-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40091-McIntosh-County.txt     --wx out/40/s/40091-mcintosh-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40099-Murray-County.txt       --wx out/40/s/40099-murray-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40121-Pittsburg-County.txt    --wx out/40/s/40121-pittsburg-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40123-Pontotoc-County.txt     --wx out/40/s/40123-pontotoc-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40125-Pottawatomie-County.txt --wx out/40/s/40125-pottawatomie-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40127-Pushmataha-County.txt   --wx out/40/s/40127-pushmataha-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40133-Seminole-County.txt     --wx out/40/s/40133-seminole-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40137-Stephens-County.txt     --wx out/40/s/40137-stephens-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40141-Tillman-County.txt      --wx out/40/s/40141-tillman-county.osm.bz2 \
    --bp completeWays=yes file=polys/40/40149-Washita-County.txt      --wx out/40/s/40149-washita-county.osm.bz2 \

touch -r tmp/oklahoma.osm.pbf out/40/*/*.osm.???

./skeletron-roads.sh tmp/oklahoma-roads.osm.pbf out/40 oklahoma
./skeletron-routes.sh tmp/oklahoma-routes.osm.bz2 out/40 oklahoma

touch -r tmp/oklahoma.osm.pbf out/40/*.pgsql
