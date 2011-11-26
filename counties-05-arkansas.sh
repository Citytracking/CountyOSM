#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/05/n out/05/s

curl -Rs -o tmp/arkansas.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/arkansas.osm.pbf

osmosis --rb tmp/arkansas.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/arkansas-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/arkansas-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/arkansas-routes-B.osm.pbf \
            --tf accept-relations "network=US:AR" --used-way --used-node --wb omitmetadata=true tmp/arkansas-routes-C.osm.pbf \
            --tf accept-relations "network=US:AR:CR" --used-way --used-node --wb omitmetadata=true tmp/arkansas-routes-D.osm.pbf \

osmosis \
    --rb tmp/arkansas-routes-A.osm.pbf \
    --rb tmp/arkansas-routes-B.osm.pbf \
    --rb tmp/arkansas-routes-C.osm.pbf \
    --rb tmp/arkansas-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/arkansas-routes.osm.bz2

osmosis \
    --rb tmp/arkansas-roads.osm.pbf \
    --tee outputCount=75 \
    --bp completeWays=yes file=polys/05/05005-Baxter-County.txt       --wx out/05/n/05005-baxter-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05007-Benton-County.txt       --wx out/05/n/05007-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05009-Boone-County.txt        --wx out/05/n/05009-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05015-Carroll-County.txt      --wx out/05/n/05015-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05021-Clay-County.txt         --wx out/05/n/05021-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05023-Cleburne-County.txt     --wx out/05/n/05023-cleburne-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05029-Conway-County.txt       --wx out/05/n/05029-conway-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05031-Craighead-County.txt    --wx out/05/n/05031-craighead-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05033-Crawford-County.txt     --wx out/05/n/05033-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05035-Crittenden-County.txt   --wx out/05/n/05035-crittenden-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05037-Cross-County.txt        --wx out/05/n/05037-cross-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05045-Faulkner-County.txt     --wx out/05/n/05045-faulkner-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05047-Franklin-County.txt     --wx out/05/n/05047-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05049-Fulton-County.txt       --wx out/05/n/05049-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05055-Greene-County.txt       --wx out/05/n/05055-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05063-Independence-County.txt --wx out/05/n/05063-independence-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05065-Izard-County.txt        --wx out/05/n/05065-izard-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05067-Jackson-County.txt      --wx out/05/n/05067-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05071-Johnson-County.txt      --wx out/05/n/05071-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05075-Lawrence-County.txt     --wx out/05/n/05075-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05083-Logan-County.txt        --wx out/05/n/05083-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05087-Madison-County.txt      --wx out/05/n/05087-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05089-Marion-County.txt       --wx out/05/n/05089-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05093-Mississippi-County.txt  --wx out/05/n/05093-mississippi-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05101-Newton-County.txt       --wx out/05/n/05101-newton-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05105-Perry-County.txt        --wx out/05/n/05105-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05111-Poinsett-County.txt     --wx out/05/n/05111-poinsett-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05115-Pope-County.txt         --wx out/05/n/05115-pope-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05119-Pulaski-County.txt      --wx out/05/n/05119-pulaski-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05121-Randolph-County.txt     --wx out/05/n/05121-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05123-St.-Francis-County.txt  --wx out/05/n/05123-st.-francis-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05127-Scott-County.txt        --wx out/05/n/05127-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05129-Searcy-County.txt       --wx out/05/n/05129-searcy-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05131-Sebastian-County.txt    --wx out/05/n/05131-sebastian-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05135-Sharp-County.txt        --wx out/05/n/05135-sharp-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05137-Stone-County.txt        --wx out/05/n/05137-stone-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05141-Van-Buren-County.txt    --wx out/05/n/05141-van-buren-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05143-Washington-County.txt   --wx out/05/n/05143-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05145-White-County.txt        --wx out/05/n/05145-white-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05147-Woodruff-County.txt     --wx out/05/n/05147-woodruff-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05149-Yell-County.txt         --wx out/05/n/05149-yell-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05001-Arkansas-County.txt     --wx out/05/s/05001-arkansas-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05003-Ashley-County.txt       --wx out/05/s/05003-ashley-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05011-Bradley-County.txt      --wx out/05/s/05011-bradley-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05013-Calhoun-County.txt      --wx out/05/s/05013-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05017-Chicot-County.txt       --wx out/05/s/05017-chicot-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05019-Clark-County.txt        --wx out/05/s/05019-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05025-Cleveland-County.txt    --wx out/05/s/05025-cleveland-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05027-Columbia-County.txt     --wx out/05/s/05027-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05039-Dallas-County.txt       --wx out/05/s/05039-dallas-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05041-Desha-County.txt        --wx out/05/s/05041-desha-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05043-Drew-County.txt         --wx out/05/s/05043-drew-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05051-Garland-County.txt      --wx out/05/s/05051-garland-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05053-Grant-County.txt        --wx out/05/s/05053-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05057-Hempstead-County.txt    --wx out/05/s/05057-hempstead-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05059-Hot-Spring-County.txt   --wx out/05/s/05059-hot-spring-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05061-Howard-County.txt       --wx out/05/s/05061-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05069-Jefferson-County.txt    --wx out/05/s/05069-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05073-Lafayette-County.txt    --wx out/05/s/05073-lafayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05077-Lee-County.txt          --wx out/05/s/05077-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05079-Lincoln-County.txt      --wx out/05/s/05079-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05081-Little-River-County.txt --wx out/05/s/05081-little-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05085-Lonoke-County.txt       --wx out/05/s/05085-lonoke-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05091-Miller-County.txt       --wx out/05/s/05091-miller-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05095-Monroe-County.txt       --wx out/05/s/05095-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05097-Montgomery-County.txt   --wx out/05/s/05097-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05099-Nevada-County.txt       --wx out/05/s/05099-nevada-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05103-Ouachita-County.txt     --wx out/05/s/05103-ouachita-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05107-Phillips-County.txt     --wx out/05/s/05107-phillips-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05109-Pike-County.txt         --wx out/05/s/05109-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05113-Polk-County.txt         --wx out/05/s/05113-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05117-Prairie-County.txt      --wx out/05/s/05117-prairie-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05125-Saline-County.txt       --wx out/05/s/05125-saline-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05133-Sevier-County.txt       --wx out/05/s/05133-sevier-county.osm.bz2 \
    --bp completeWays=yes file=polys/05/05139-Union-County.txt        --wx out/05/s/05139-union-county.osm.bz2 \

touch -r tmp/arkansas.osm.pbf out/05/*.osm.???

./skeletron-roads.sh tmp/arkansas-roads.osm.pbf out/05 arkansas
./skeletron-routes.sh tmp/arkansas-routes.osm.bz2 out/05 arkansas

touch -r tmp/arkansas.osm.pbf out/05/*.pgsql
