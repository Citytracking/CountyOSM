#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/19/n out/19/s

curl -Rs -o tmp/iowa.osm.pbf -L http://download.geofabrik.de/north-america/us/iowa-latest.osm.pbf

osmosis --rb tmp/iowa.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/iowa-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/iowa-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/iowa-routes-B.osm.pbf \
            --tf accept-relations "network=US:IA" --used-way --used-node --wb omitmetadata=true tmp/iowa-routes-C.osm.pbf \
            --tf accept-relations "network=US:IA:CR" --used-way --used-node --wb omitmetadata=true tmp/iowa-routes-D.osm.pbf \

osmosis \
    --rb tmp/iowa-routes-A.osm.pbf \
    --rb tmp/iowa-routes-B.osm.pbf \
    --rb tmp/iowa-routes-C.osm.pbf \
    --rb tmp/iowa-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/iowa-routes.osm.bz2

osmosis \
    --rb tmp/iowa-roads.osm.pbf \
    --tee outputCount=99 \
    --bp completeWays=yes file=polys/19/19005-Allamakee-County.txt     --wx out/19/n/19005-allamakee-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19011-Benton-County.txt        --wx out/19/n/19011-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19013-Black-Hawk-County.txt    --wx out/19/n/19013-black-hawk-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19015-Boone-County.txt         --wx out/19/n/19015-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19017-Bremer-County.txt        --wx out/19/n/19017-bremer-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19019-Buchanan-County.txt      --wx out/19/n/19019-buchanan-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19021-Buena-Vista-County.txt   --wx out/19/n/19021-buena-vista-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19023-Butler-County.txt        --wx out/19/n/19023-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19025-Calhoun-County.txt       --wx out/19/n/19025-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19027-Carroll-County.txt       --wx out/19/n/19027-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19033-Cerro-Gordo-County.txt   --wx out/19/n/19033-cerro-gordo-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19035-Cherokee-County.txt      --wx out/19/n/19035-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19037-Chickasaw-County.txt     --wx out/19/n/19037-chickasaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19041-Clay-County.txt          --wx out/19/n/19041-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19043-Clayton-County.txt       --wx out/19/n/19043-clayton-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19047-Crawford-County.txt      --wx out/19/n/19047-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19055-Delaware-County.txt      --wx out/19/n/19055-delaware-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19059-Dickinson-County.txt     --wx out/19/n/19059-dickinson-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19061-Dubuque-County.txt       --wx out/19/n/19061-dubuque-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19063-Emmet-County.txt         --wx out/19/n/19063-emmet-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19065-Fayette-County.txt       --wx out/19/n/19065-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19067-Floyd-County.txt         --wx out/19/n/19067-floyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19069-Franklin-County.txt      --wx out/19/n/19069-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19073-Greene-County.txt        --wx out/19/n/19073-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19075-Grundy-County.txt        --wx out/19/n/19075-grundy-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19079-Hamilton-County.txt      --wx out/19/n/19079-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19081-Hancock-County.txt       --wx out/19/n/19081-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19083-Hardin-County.txt        --wx out/19/n/19083-hardin-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19089-Howard-County.txt        --wx out/19/n/19089-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19091-Humboldt-County.txt      --wx out/19/n/19091-humboldt-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19093-Ida-County.txt           --wx out/19/n/19093-ida-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19097-Jackson-County.txt       --wx out/19/n/19097-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19105-Jones-County.txt         --wx out/19/n/19105-jones-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19109-Kossuth-County.txt       --wx out/19/n/19109-kossuth-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19113-Linn-County.txt          --wx out/19/n/19113-linn-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19119-Lyon-County.txt          --wx out/19/n/19119-lyon-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19127-Marshall-County.txt      --wx out/19/n/19127-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19131-Mitchell-County.txt      --wx out/19/n/19131-mitchell-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19133-Monona-County.txt        --wx out/19/n/19133-monona-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19141-OBrien-County.txt        --wx out/19/n/19141-obrien-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19143-Osceola-County.txt       --wx out/19/n/19143-osceola-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19147-Palo-Alto-County.txt     --wx out/19/n/19147-palo-alto-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19149-Plymouth-County.txt      --wx out/19/n/19149-plymouth-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19151-Pocahontas-County.txt    --wx out/19/n/19151-pocahontas-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19161-Sac-County.txt           --wx out/19/n/19161-sac-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19167-Sioux-County.txt         --wx out/19/n/19167-sioux-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19169-Story-County.txt         --wx out/19/n/19169-story-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19171-Tama-County.txt          --wx out/19/n/19171-tama-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19187-Webster-County.txt       --wx out/19/n/19187-webster-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19189-Winnebago-County.txt     --wx out/19/n/19189-winnebago-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19191-Winneshiek-County.txt    --wx out/19/n/19191-winneshiek-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19193-Woodbury-County.txt      --wx out/19/n/19193-woodbury-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19195-Worth-County.txt         --wx out/19/n/19195-worth-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19197-Wright-County.txt        --wx out/19/n/19197-wright-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19001-Adair-County.txt         --wx out/19/s/19001-adair-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19003-Adams-County.txt         --wx out/19/s/19003-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19007-Appanoose-County.txt     --wx out/19/s/19007-appanoose-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19009-Audubon-County.txt       --wx out/19/s/19009-audubon-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19029-Cass-County.txt          --wx out/19/s/19029-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19031-Cedar-County.txt         --wx out/19/s/19031-cedar-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19039-Clarke-County.txt        --wx out/19/s/19039-clarke-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19045-Clinton-County.txt       --wx out/19/s/19045-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19049-Dallas-County.txt        --wx out/19/s/19049-dallas-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19051-Davis-County.txt         --wx out/19/s/19051-davis-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19053-Decatur-County.txt       --wx out/19/s/19053-decatur-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19057-Des-Moines-County.txt    --wx out/19/s/19057-des-moines-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19071-Fremont-County.txt       --wx out/19/s/19071-fremont-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19077-Guthrie-County.txt       --wx out/19/s/19077-guthrie-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19085-Harrison-County.txt      --wx out/19/s/19085-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19087-Henry-County.txt         --wx out/19/s/19087-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19095-Iowa-County.txt          --wx out/19/s/19095-iowa-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19099-Jasper-County.txt        --wx out/19/s/19099-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19101-Jefferson-County.txt     --wx out/19/s/19101-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19103-Johnson-County.txt       --wx out/19/s/19103-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19107-Keokuk-County.txt        --wx out/19/s/19107-keokuk-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19111-Lee-County.txt           --wx out/19/s/19111-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19115-Louisa-County.txt        --wx out/19/s/19115-louisa-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19117-Lucas-County.txt         --wx out/19/s/19117-lucas-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19121-Madison-County.txt       --wx out/19/s/19121-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19123-Mahaska-County.txt       --wx out/19/s/19123-mahaska-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19125-Marion-County.txt        --wx out/19/s/19125-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19129-Mills-County.txt         --wx out/19/s/19129-mills-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19135-Monroe-County.txt        --wx out/19/s/19135-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19137-Montgomery-County.txt    --wx out/19/s/19137-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19139-Muscatine-County.txt     --wx out/19/s/19139-muscatine-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19145-Page-County.txt          --wx out/19/s/19145-page-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19153-Polk-County.txt          --wx out/19/s/19153-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19155-Pottawattamie-County.txt --wx out/19/s/19155-pottawattamie-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19157-Poweshiek-County.txt     --wx out/19/s/19157-poweshiek-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19159-Ringgold-County.txt      --wx out/19/s/19159-ringgold-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19163-Scott-County.txt         --wx out/19/s/19163-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19165-Shelby-County.txt        --wx out/19/s/19165-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19173-Taylor-County.txt        --wx out/19/s/19173-taylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19175-Union-County.txt         --wx out/19/s/19175-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19177-Van-Buren-County.txt     --wx out/19/s/19177-van-buren-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19179-Wapello-County.txt       --wx out/19/s/19179-wapello-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19181-Warren-County.txt        --wx out/19/s/19181-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19183-Washington-County.txt    --wx out/19/s/19183-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/19/19185-Wayne-County.txt         --wx out/19/s/19185-wayne-county.osm.bz2 \

touch -r tmp/iowa.osm.pbf out/19/*/*.osm.???

./skeletron-roads.sh tmp/iowa-roads.osm.pbf out/19 iowa IA
./skeletron-routes.sh tmp/iowa-routes.osm.bz2 out/19 iowa IA
