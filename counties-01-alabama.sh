#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/01/w out/01/e

curl -Rs -o tmp/alabama.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/alabama.osm.pbf

osmosis --rb tmp/alabama.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/alabama-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/alabama-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/alabama-routes-B.osm.pbf \
            --tf accept-relations "network=US:AL" --used-way --used-node --wb omitmetadata=true tmp/alabama-routes-C.osm.pbf \
            --tf accept-relations "network=US:AL:CR" --used-way --used-node --wb omitmetadata=true tmp/alabama-routes-D.osm.pbf \

osmosis \
    --rb tmp/alabama-routes-A.osm.pbf \
    --rb tmp/alabama-routes-B.osm.pbf \
    --rb tmp/alabama-routes-C.osm.pbf \
    --rb tmp/alabama-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/alabama-routes.osm.bz2

osmosis \
    --rb tmp/alabama-roads.osm.pbf \
    --tee outputCount=67 \
    --bp completeWays=yes file=polys/01/01001-Autauga-County.txt    --wx out/01/w/01001-autauga-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01003-Baldwin-County.txt    --wx out/01/w/01003-baldwin-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01007-Bibb-County.txt       --wx out/01/w/01007-bibb-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01009-Blount-County.txt     --wx out/01/w/01009-blount-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01013-Butler-County.txt     --wx out/01/w/01013-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01021-Chilton-County.txt    --wx out/01/w/01021-chilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01023-Choctaw-County.txt    --wx out/01/w/01023-choctaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01025-Clarke-County.txt     --wx out/01/w/01025-clarke-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01033-Colbert-County.txt    --wx out/01/w/01033-colbert-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01035-Conecuh-County.txt    --wx out/01/w/01035-conecuh-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01043-Cullman-County.txt    --wx out/01/w/01043-cullman-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01047-Dallas-County.txt     --wx out/01/w/01047-dallas-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01053-Escambia-County.txt   --wx out/01/w/01053-escambia-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01057-Fayette-County.txt    --wx out/01/w/01057-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01059-Franklin-County.txt   --wx out/01/w/01059-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01063-Greene-County.txt     --wx out/01/w/01063-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01065-Hale-County.txt       --wx out/01/w/01065-hale-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01073-Jefferson-County.txt  --wx out/01/w/01073-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01075-Lamar-County.txt      --wx out/01/w/01075-lamar-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01077-Lauderdale-County.txt --wx out/01/w/01077-lauderdale-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01079-Lawrence-County.txt   --wx out/01/w/01079-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01083-Limestone-County.txt  --wx out/01/w/01083-limestone-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01085-Lowndes-County.txt    --wx out/01/w/01085-lowndes-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01091-Marengo-County.txt    --wx out/01/w/01091-marengo-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01093-Marion-County.txt     --wx out/01/w/01093-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01097-Mobile-County.txt     --wx out/01/w/01097-mobile-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01099-Monroe-County.txt     --wx out/01/w/01099-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01103-Morgan-County.txt     --wx out/01/w/01103-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01105-Perry-County.txt      --wx out/01/w/01105-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01107-Pickens-County.txt    --wx out/01/w/01107-pickens-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01117-Shelby-County.txt     --wx out/01/w/01117-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01119-Sumter-County.txt     --wx out/01/w/01119-sumter-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01125-Tuscaloosa-County.txt --wx out/01/w/01125-tuscaloosa-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01127-Walker-County.txt     --wx out/01/w/01127-walker-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01129-Washington-County.txt --wx out/01/w/01129-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01131-Wilcox-County.txt     --wx out/01/w/01131-wilcox-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01133-Winston-County.txt    --wx out/01/w/01133-winston-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01005-Barbour-County.txt    --wx out/01/e/01005-barbour-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01011-Bullock-County.txt    --wx out/01/e/01011-bullock-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01015-Calhoun-County.txt    --wx out/01/e/01015-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01017-Chambers-County.txt   --wx out/01/e/01017-chambers-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01019-Cherokee-County.txt   --wx out/01/e/01019-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01027-Clay-County.txt       --wx out/01/e/01027-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01029-Cleburne-County.txt   --wx out/01/e/01029-cleburne-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01031-Coffee-County.txt     --wx out/01/e/01031-coffee-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01037-Coosa-County.txt      --wx out/01/e/01037-coosa-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01039-Covington-County.txt  --wx out/01/e/01039-covington-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01041-Crenshaw-County.txt   --wx out/01/e/01041-crenshaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01045-Dale-County.txt       --wx out/01/e/01045-dale-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01049-DeKalb-County.txt     --wx out/01/e/01049-dekalb-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01051-Elmore-County.txt     --wx out/01/e/01051-elmore-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01055-Etowah-County.txt     --wx out/01/e/01055-etowah-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01061-Geneva-County.txt     --wx out/01/e/01061-geneva-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01067-Henry-County.txt      --wx out/01/e/01067-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01069-Houston-County.txt    --wx out/01/e/01069-houston-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01071-Jackson-County.txt    --wx out/01/e/01071-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01081-Lee-County.txt        --wx out/01/e/01081-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01087-Macon-County.txt      --wx out/01/e/01087-macon-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01089-Madison-County.txt    --wx out/01/e/01089-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01095-Marshall-County.txt   --wx out/01/e/01095-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01101-Montgomery-County.txt --wx out/01/e/01101-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01109-Pike-County.txt       --wx out/01/e/01109-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01111-Randolph-County.txt   --wx out/01/e/01111-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01113-Russell-County.txt    --wx out/01/e/01113-russell-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01115-St.-Clair-County.txt  --wx out/01/e/01115-st.-clair-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01121-Talladega-County.txt  --wx out/01/e/01121-talladega-county.osm.bz2 \
    --bp completeWays=yes file=polys/01/01123-Tallapoosa-County.txt --wx out/01/e/01123-tallapoosa-county.osm.bz2 \

touch -r tmp/alabama.osm.pbf out/01/*/*.osm.???

./skeletron-roads.sh tmp/alabama-roads.osm.pbf out/01 alabama
./skeletron-routes.sh tmp/alabama-routes.osm.bz2 out/01 alabama

touch -r tmp/alabama.osm.pbf out/01/*.pgsql
