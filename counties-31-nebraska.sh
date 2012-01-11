#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/31/n out/31/s

curl -Rs -o tmp/nebraska.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/nebraska.osm.pbf

osmosis --rb tmp/nebraska.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/nebraska-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/nebraska-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/nebraska-routes-B.osm.pbf \
            --tf accept-relations "network=US:NE" --used-way --used-node --wb omitmetadata=true tmp/nebraska-routes-C.osm.pbf \
            --tf accept-relations "network=US:NE:CR" --used-way --used-node --wb omitmetadata=true tmp/nebraska-routes-D.osm.pbf \

osmosis \
    --rb tmp/nebraska-routes-A.osm.pbf \
    --rb tmp/nebraska-routes-B.osm.pbf \
    --rb tmp/nebraska-routes-C.osm.pbf \
    --rb tmp/nebraska-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/nebraska-routes.osm.bz2

osmosis \
    --rb tmp/nebraska-roads.osm.pbf \
    --tee outputCount=93 \
    --bp completeWays=yes file=polys/31/31003-Antelope-County.txt     --wx out/31/n/31003-antelope-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31009-Blaine-County.txt       --wx out/31/n/31009-blaine-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31013-Box-Butte-County.txt    --wx out/31/n/31013-box-butte-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31015-Boyd-County.txt         --wx out/31/n/31015-boyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31017-Brown-County.txt        --wx out/31/n/31017-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31021-Burt-County.txt         --wx out/31/n/31021-burt-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31027-Cedar-County.txt        --wx out/31/n/31027-cedar-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31031-Cherry-County.txt       --wx out/31/n/31031-cherry-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31039-Cuming-County.txt       --wx out/31/n/31039-cuming-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31043-Dakota-County.txt       --wx out/31/n/31043-dakota-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31045-Dawes-County.txt        --wx out/31/n/31045-dawes-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31051-Dixon-County.txt        --wx out/31/n/31051-dixon-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31071-Garfield-County.txt     --wx out/31/n/31071-garfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31075-Grant-County.txt        --wx out/31/n/31075-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31089-Holt-County.txt         --wx out/31/n/31089-holt-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31091-Hooker-County.txt       --wx out/31/n/31091-hooker-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31103-Keya-Paha-County.txt    --wx out/31/n/31103-keya-paha-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31107-Knox-County.txt         --wx out/31/n/31107-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31115-Loup-County.txt         --wx out/31/n/31115-loup-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31119-Madison-County.txt      --wx out/31/n/31119-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31139-Pierce-County.txt       --wx out/31/n/31139-pierce-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31149-Rock-County.txt         --wx out/31/n/31149-rock-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31161-Sheridan-County.txt     --wx out/31/n/31161-sheridan-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31165-Sioux-County.txt        --wx out/31/n/31165-sioux-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31167-Stanton-County.txt      --wx out/31/n/31167-stanton-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31171-Thomas-County.txt       --wx out/31/n/31171-thomas-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31173-Thurston-County.txt     --wx out/31/n/31173-thurston-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31179-Wayne-County.txt        --wx out/31/n/31179-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31183-Wheeler-County.txt      --wx out/31/n/31183-wheeler-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31001-Adams-County.txt        --wx out/31/s/31001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31005-Arthur-County.txt       --wx out/31/s/31005-arthur-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31007-Banner-County.txt       --wx out/31/s/31007-banner-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31011-Boone-County.txt        --wx out/31/s/31011-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31019-Buffalo-County.txt      --wx out/31/s/31019-buffalo-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31023-Butler-County.txt       --wx out/31/s/31023-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31025-Cass-County.txt         --wx out/31/s/31025-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31029-Chase-County.txt        --wx out/31/s/31029-chase-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31033-Cheyenne-County.txt     --wx out/31/s/31033-cheyenne-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31035-Clay-County.txt         --wx out/31/s/31035-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31037-Colfax-County.txt       --wx out/31/s/31037-colfax-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31041-Custer-County.txt       --wx out/31/s/31041-custer-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31047-Dawson-County.txt       --wx out/31/s/31047-dawson-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31049-Deuel-County.txt        --wx out/31/s/31049-deuel-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31053-Dodge-County.txt        --wx out/31/s/31053-dodge-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31055-Douglas-County.txt      --wx out/31/s/31055-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31057-Dundy-County.txt        --wx out/31/s/31057-dundy-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31059-Fillmore-County.txt     --wx out/31/s/31059-fillmore-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31061-Franklin-County.txt     --wx out/31/s/31061-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31063-Frontier-County.txt     --wx out/31/s/31063-frontier-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31065-Furnas-County.txt       --wx out/31/s/31065-furnas-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31067-Gage-County.txt         --wx out/31/s/31067-gage-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31069-Garden-County.txt       --wx out/31/s/31069-garden-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31073-Gosper-County.txt       --wx out/31/s/31073-gosper-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31077-Greeley-County.txt      --wx out/31/s/31077-greeley-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31079-Hall-County.txt         --wx out/31/s/31079-hall-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31081-Hamilton-County.txt     --wx out/31/s/31081-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31083-Harlan-County.txt       --wx out/31/s/31083-harlan-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31085-Hayes-County.txt        --wx out/31/s/31085-hayes-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31087-Hitchcock-County.txt    --wx out/31/s/31087-hitchcock-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31093-Howard-County.txt       --wx out/31/s/31093-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31095-Jefferson-County.txt    --wx out/31/s/31095-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31097-Johnson-County.txt      --wx out/31/s/31097-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31099-Kearney-County.txt      --wx out/31/s/31099-kearney-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31101-Keith-County.txt        --wx out/31/s/31101-keith-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31105-Kimball-County.txt      --wx out/31/s/31105-kimball-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31109-Lancaster-County.txt    --wx out/31/s/31109-lancaster-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31111-Lincoln-County.txt      --wx out/31/s/31111-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31113-Logan-County.txt        --wx out/31/s/31113-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31117-McPherson-County.txt    --wx out/31/s/31117-mcpherson-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31121-Merrick-County.txt      --wx out/31/s/31121-merrick-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31123-Morrill-County.txt      --wx out/31/s/31123-morrill-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31125-Nance-County.txt        --wx out/31/s/31125-nance-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31127-Nemaha-County.txt       --wx out/31/s/31127-nemaha-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31129-Nuckolls-County.txt     --wx out/31/s/31129-nuckolls-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31131-Otoe-County.txt         --wx out/31/s/31131-otoe-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31133-Pawnee-County.txt       --wx out/31/s/31133-pawnee-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31135-Perkins-County.txt      --wx out/31/s/31135-perkins-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31137-Phelps-County.txt       --wx out/31/s/31137-phelps-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31141-Platte-County.txt       --wx out/31/s/31141-platte-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31143-Polk-County.txt         --wx out/31/s/31143-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31145-Red-Willow-County.txt   --wx out/31/s/31145-red-willow-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31147-Richardson-County.txt   --wx out/31/s/31147-richardson-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31151-Saline-County.txt       --wx out/31/s/31151-saline-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31153-Sarpy-County.txt        --wx out/31/s/31153-sarpy-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31155-Saunders-County.txt     --wx out/31/s/31155-saunders-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31157-Scotts-Bluff-County.txt --wx out/31/s/31157-scotts-bluff-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31159-Seward-County.txt       --wx out/31/s/31159-seward-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31163-Sherman-County.txt      --wx out/31/s/31163-sherman-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31169-Thayer-County.txt       --wx out/31/s/31169-thayer-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31175-Valley-County.txt       --wx out/31/s/31175-valley-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31177-Washington-County.txt   --wx out/31/s/31177-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31181-Webster-County.txt      --wx out/31/s/31181-webster-county.osm.bz2 \
    --bp completeWays=yes file=polys/31/31185-York-County.txt         --wx out/31/s/31185-york-county.osm.bz2 \

touch -r tmp/nebraska.osm.pbf out/31/*/*.osm.???

./skeletron-roads.sh tmp/nebraska-roads.osm.pbf out/31 nebraska NE
./skeletron-routes.sh tmp/nebraska-routes.osm.bz2 out/31 nebraska NE
