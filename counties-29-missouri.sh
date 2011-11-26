#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/29/w out/29/c out/29/e

curl -Rs -o tmp/missouri.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/missouri.osm.pbf

osmosis --rb tmp/missouri.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/missouri-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/missouri-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/missouri-routes-B.osm.pbf \
            --tf accept-relations "network=US:MO" --used-way --used-node --wb omitmetadata=true tmp/missouri-routes-C.osm.pbf \
            --tf accept-relations "network=US:MO:CR" --used-way --used-node --wb omitmetadata=true tmp/missouri-routes-D.osm.pbf \

osmosis \
    --rb tmp/missouri-routes-A.osm.pbf \
    --rb tmp/missouri-routes-B.osm.pbf \
    --rb tmp/missouri-routes-C.osm.pbf \
    --rb tmp/missouri-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/missouri-routes.osm.bz2

osmosis \
    --rb tmp/missouri-roads.osm.pbf \
    --tee outputCount=115 \
    --bp completeWays=yes file=polys/29/29003-Andrew-County.txt         --wx out/29/w/29003-andrew-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29005-Atchison-County.txt       --wx out/29/w/29005-atchison-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29009-Barry-County.txt          --wx out/29/w/29009-barry-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29011-Barton-County.txt         --wx out/29/w/29011-barton-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29013-Bates-County.txt          --wx out/29/w/29013-bates-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29021-Buchanan-County.txt       --wx out/29/w/29021-buchanan-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29025-Caldwell-County.txt       --wx out/29/w/29025-caldwell-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29037-Cass-County.txt           --wx out/29/w/29037-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29039-Cedar-County.txt          --wx out/29/w/29039-cedar-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29047-Clay-County.txt           --wx out/29/w/29047-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29049-Clinton-County.txt        --wx out/29/w/29049-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29057-Dade-County.txt           --wx out/29/w/29057-dade-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29061-Daviess-County.txt        --wx out/29/w/29061-daviess-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29063-DeKalb-County.txt         --wx out/29/w/29063-dekalb-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29075-Gentry-County.txt         --wx out/29/w/29075-gentry-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29081-Harrison-County.txt       --wx out/29/w/29081-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29083-Henry-County.txt          --wx out/29/w/29083-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29087-Holt-County.txt           --wx out/29/w/29087-holt-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29097-Jasper-County.txt         --wx out/29/w/29097-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29095-Jackson-County.txt        --wx out/29/w/29095-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29101-Johnson-County.txt        --wx out/29/w/29101-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29107-Lafayette-County.txt      --wx out/29/w/29107-lafayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29109-Lawrence-County.txt       --wx out/29/w/29109-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29119-McDonald-County.txt       --wx out/29/w/29119-mcdonald-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29145-Newton-County.txt         --wx out/29/w/29145-newton-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29147-Nodaway-County.txt        --wx out/29/w/29147-nodaway-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29165-Platte-County.txt         --wx out/29/w/29165-platte-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29177-Ray-County.txt            --wx out/29/w/29177-ray-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29185-St.-Clair-County.txt      --wx out/29/w/29185-st.-clair-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29217-Vernon-County.txt         --wx out/29/w/29217-vernon-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29227-Worth-County.txt          --wx out/29/w/29227-worth-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29001-Adair-County.txt          --wx out/29/c/29001-adair-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29007-Audrain-County.txt        --wx out/29/c/29007-audrain-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29015-Benton-County.txt         --wx out/29/c/29015-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29019-Boone-County.txt          --wx out/29/c/29019-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29027-Callaway-County.txt       --wx out/29/c/29027-callaway-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29029-Camden-County.txt         --wx out/29/c/29029-camden-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29033-Carroll-County.txt        --wx out/29/c/29033-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29041-Chariton-County.txt       --wx out/29/c/29041-chariton-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29043-Christian-County.txt      --wx out/29/c/29043-christian-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29051-Cole-County.txt           --wx out/29/c/29051-cole-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29053-Cooper-County.txt         --wx out/29/c/29053-cooper-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29059-Dallas-County.txt         --wx out/29/c/29059-dallas-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29067-Douglas-County.txt        --wx out/29/c/29067-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29077-Greene-County.txt         --wx out/29/c/29077-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29079-Grundy-County.txt         --wx out/29/c/29079-grundy-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29085-Hickory-County.txt        --wx out/29/c/29085-hickory-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29089-Howard-County.txt         --wx out/29/c/29089-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29091-Howell-County.txt         --wx out/29/c/29091-howell-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29103-Knox-County.txt           --wx out/29/c/29103-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29105-Laclede-County.txt        --wx out/29/c/29105-laclede-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29115-Linn-County.txt           --wx out/29/c/29115-linn-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29117-Livingston-County.txt     --wx out/29/c/29117-livingston-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29121-Macon-County.txt          --wx out/29/c/29121-macon-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29125-Maries-County.txt         --wx out/29/c/29125-maries-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29129-Mercer-County.txt         --wx out/29/c/29129-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29131-Miller-County.txt         --wx out/29/c/29131-miller-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29135-Moniteau-County.txt       --wx out/29/c/29135-moniteau-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29137-Monroe-County.txt         --wx out/29/c/29137-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29141-Morgan-County.txt         --wx out/29/c/29141-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29151-Osage-County.txt          --wx out/29/c/29151-osage-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29153-Ozark-County.txt          --wx out/29/c/29153-ozark-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29157-Perry-County.txt          --wx out/29/c/29157-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29159-Pettis-County.txt         --wx out/29/c/29159-pettis-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29161-Phelps-County.txt         --wx out/29/c/29161-phelps-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29167-Polk-County.txt           --wx out/29/c/29167-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29169-Pulaski-County.txt        --wx out/29/c/29169-pulaski-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29171-Putnam-County.txt         --wx out/29/c/29171-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29175-Randolph-County.txt       --wx out/29/c/29175-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29195-Saline-County.txt         --wx out/29/c/29195-saline-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29197-Schuyler-County.txt       --wx out/29/c/29197-schuyler-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29199-Scotland-County.txt       --wx out/29/c/29199-scotland-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29205-Shelby-County.txt         --wx out/29/c/29205-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29209-Stone-County.txt          --wx out/29/c/29209-stone-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29211-Sullivan-County.txt       --wx out/29/c/29211-sullivan-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29213-Taney-County.txt          --wx out/29/c/29213-taney-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29215-Texas-County.txt          --wx out/29/c/29215-texas-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29225-Webster-County.txt        --wx out/29/c/29225-webster-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29229-Wright-County.txt         --wx out/29/c/29229-wright-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29017-Bollinger-County.txt      --wx out/29/e/29017-bollinger-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29023-Butler-County.txt         --wx out/29/e/29023-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29031-Cape-Girardeau-County.txt --wx out/29/e/29031-cape-girardeau-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29035-Carter-County.txt         --wx out/29/e/29035-carter-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29045-Clark-County.txt          --wx out/29/e/29045-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29055-Crawford-County.txt       --wx out/29/e/29055-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29065-Dent-County.txt           --wx out/29/e/29065-dent-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29069-Dunklin-County.txt        --wx out/29/e/29069-dunklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29071-Franklin-County.txt       --wx out/29/e/29071-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29073-Gasconade-County.txt      --wx out/29/e/29073-gasconade-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29093-Iron-County.txt           --wx out/29/e/29093-iron-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29099-Jefferson-County.txt      --wx out/29/e/29099-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29111-Lewis-County.txt          --wx out/29/e/29111-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29113-Lincoln-County.txt        --wx out/29/e/29113-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29123-Madison-County.txt        --wx out/29/e/29123-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29127-Marion-County.txt         --wx out/29/e/29127-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29133-Mississippi-County.txt    --wx out/29/e/29133-mississippi-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29139-Montgomery-County.txt     --wx out/29/e/29139-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29143-New-Madrid-County.txt     --wx out/29/e/29143-new-madrid-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29149-Oregon-County.txt         --wx out/29/e/29149-oregon-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29155-Pemiscot-County.txt       --wx out/29/e/29155-pemiscot-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29163-Pike-County.txt           --wx out/29/e/29163-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29173-Ralls-County.txt          --wx out/29/e/29173-ralls-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29179-Reynolds-County.txt       --wx out/29/e/29179-reynolds-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29181-Ripley-County.txt         --wx out/29/e/29181-ripley-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29183-St.-Charles-County.txt    --wx out/29/e/29183-st.-charles-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29186-Ste.-Genevieve-County.txt --wx out/29/e/29186-ste.-genevieve-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29187-St.-Francois-County.txt   --wx out/29/e/29187-st.-francois-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29189-St.-Louis-County.txt      --wx out/29/e/29189-st.-louis-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29201-Scott-County.txt          --wx out/29/e/29201-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29203-Shannon-County.txt        --wx out/29/e/29203-shannon-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29510-St.-Louis-city.txt        --wx out/29/e/29510-st.-louis-city.osm.bz2 \
    --bp completeWays=yes file=polys/29/29207-Stoddard-County.txt       --wx out/29/e/29207-stoddard-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29219-Warren-County.txt         --wx out/29/e/29219-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29221-Washington-County.txt     --wx out/29/e/29221-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/29/29223-Wayne-County.txt          --wx out/29/e/29223-wayne-county.osm.bz2 \

touch -r tmp/missouri.osm.pbf out/29/*.osm.???

./skeletron-roads.sh tmp/missouri-roads.osm.pbf out/29 missouri
./skeletron-routes.sh tmp/missouri-routes.osm.bz2 out/29 missouri

touch -r tmp/missouri.osm.pbf out/29/*.pgsql
