#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/47

curl -Rs -o tmp/tennessee.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/tennessee.osm.pbf

osmosis --rb tmp/tennessee.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/tennessee-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/tennessee-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/tennessee-routes-B.osm.pbf \
            --tf accept-relations "network=US:TN" --used-way --used-node --wb omitmetadata=true tmp/tennessee-routes-C.osm.pbf \
            --tf accept-relations "network=US:TN:CR" --used-way --used-node --wb omitmetadata=true tmp/tennessee-routes-D.osm.pbf \

osmosis \
    --rb tmp/tennessee-routes-A.osm.pbf \
    --rb tmp/tennessee-routes-B.osm.pbf \
    --rb tmp/tennessee-routes-C.osm.pbf \
    --rb tmp/tennessee-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/tennessee-routes.osm.bz2

osmosis \
    --rb tmp/tennessee-roads.osm.pbf \
    --tee outputCount=95 \
    --bp completeWays=yes file=polys/47/47001-Anderson-County.txt   --wx out/47/47001-anderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47003-Bedford-County.txt    --wx out/47/47003-bedford-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47005-Benton-County.txt     --wx out/47/47005-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47007-Bledsoe-County.txt    --wx out/47/47007-bledsoe-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47009-Blount-County.txt     --wx out/47/47009-blount-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47011-Bradley-County.txt    --wx out/47/47011-bradley-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47013-Campbell-County.txt   --wx out/47/47013-campbell-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47015-Cannon-County.txt     --wx out/47/47015-cannon-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47017-Carroll-County.txt    --wx out/47/47017-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47019-Carter-County.txt     --wx out/47/47019-carter-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47021-Cheatham-County.txt   --wx out/47/47021-cheatham-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47023-Chester-County.txt    --wx out/47/47023-chester-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47025-Claiborne-County.txt  --wx out/47/47025-claiborne-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47027-Clay-County.txt       --wx out/47/47027-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47029-Cocke-County.txt      --wx out/47/47029-cocke-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47031-Coffee-County.txt     --wx out/47/47031-coffee-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47033-Crockett-County.txt   --wx out/47/47033-crockett-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47035-Cumberland-County.txt --wx out/47/47035-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47037-Davidson-County.txt   --wx out/47/47037-davidson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47039-Decatur-County.txt    --wx out/47/47039-decatur-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47041-DeKalb-County.txt     --wx out/47/47041-dekalb-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47043-Dickson-County.txt    --wx out/47/47043-dickson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47045-Dyer-County.txt       --wx out/47/47045-dyer-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47047-Fayette-County.txt    --wx out/47/47047-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47049-Fentress-County.txt   --wx out/47/47049-fentress-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47051-Franklin-County.txt   --wx out/47/47051-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47053-Gibson-County.txt     --wx out/47/47053-gibson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47055-Giles-County.txt      --wx out/47/47055-giles-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47057-Grainger-County.txt   --wx out/47/47057-grainger-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47059-Greene-County.txt     --wx out/47/47059-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47061-Grundy-County.txt     --wx out/47/47061-grundy-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47063-Hamblen-County.txt    --wx out/47/47063-hamblen-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47065-Hamilton-County.txt   --wx out/47/47065-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47067-Hancock-County.txt    --wx out/47/47067-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47069-Hardeman-County.txt   --wx out/47/47069-hardeman-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47071-Hardin-County.txt     --wx out/47/47071-hardin-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47073-Hawkins-County.txt    --wx out/47/47073-hawkins-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47075-Haywood-County.txt    --wx out/47/47075-haywood-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47077-Henderson-County.txt  --wx out/47/47077-henderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47079-Henry-County.txt      --wx out/47/47079-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47081-Hickman-County.txt    --wx out/47/47081-hickman-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47083-Houston-County.txt    --wx out/47/47083-houston-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47085-Humphreys-County.txt  --wx out/47/47085-humphreys-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47087-Jackson-County.txt    --wx out/47/47087-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47089-Jefferson-County.txt  --wx out/47/47089-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47091-Johnson-County.txt    --wx out/47/47091-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47093-Knox-County.txt       --wx out/47/47093-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47095-Lake-County.txt       --wx out/47/47095-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47097-Lauderdale-County.txt --wx out/47/47097-lauderdale-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47099-Lawrence-County.txt   --wx out/47/47099-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47101-Lewis-County.txt      --wx out/47/47101-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47103-Lincoln-County.txt    --wx out/47/47103-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47105-Loudon-County.txt     --wx out/47/47105-loudon-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47107-McMinn-County.txt     --wx out/47/47107-mcminn-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47109-McNairy-County.txt    --wx out/47/47109-mcnairy-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47111-Macon-County.txt      --wx out/47/47111-macon-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47113-Madison-County.txt    --wx out/47/47113-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47115-Marion-County.txt     --wx out/47/47115-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47117-Marshall-County.txt   --wx out/47/47117-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47119-Maury-County.txt      --wx out/47/47119-maury-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47121-Meigs-County.txt      --wx out/47/47121-meigs-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47123-Monroe-County.txt     --wx out/47/47123-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47125-Montgomery-County.txt --wx out/47/47125-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47127-Moore-County.txt      --wx out/47/47127-moore-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47129-Morgan-County.txt     --wx out/47/47129-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47131-Obion-County.txt      --wx out/47/47131-obion-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47133-Overton-County.txt    --wx out/47/47133-overton-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47135-Perry-County.txt      --wx out/47/47135-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47137-Pickett-County.txt    --wx out/47/47137-pickett-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47139-Polk-County.txt       --wx out/47/47139-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47141-Putnam-County.txt     --wx out/47/47141-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47143-Rhea-County.txt       --wx out/47/47143-rhea-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47145-Roane-County.txt      --wx out/47/47145-roane-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47147-Robertson-County.txt  --wx out/47/47147-robertson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47149-Rutherford-County.txt --wx out/47/47149-rutherford-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47151-Scott-County.txt      --wx out/47/47151-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47153-Sequatchie-County.txt --wx out/47/47153-sequatchie-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47155-Sevier-County.txt     --wx out/47/47155-sevier-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47157-Shelby-County.txt     --wx out/47/47157-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47159-Smith-County.txt      --wx out/47/47159-smith-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47161-Stewart-County.txt    --wx out/47/47161-stewart-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47163-Sullivan-County.txt   --wx out/47/47163-sullivan-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47165-Sumner-County.txt     --wx out/47/47165-sumner-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47167-Tipton-County.txt     --wx out/47/47167-tipton-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47169-Trousdale-County.txt  --wx out/47/47169-trousdale-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47171-Unicoi-County.txt     --wx out/47/47171-unicoi-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47173-Union-County.txt      --wx out/47/47173-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47175-Van-Buren-County.txt  --wx out/47/47175-van-buren-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47177-Warren-County.txt     --wx out/47/47177-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47179-Washington-County.txt --wx out/47/47179-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47181-Wayne-County.txt      --wx out/47/47181-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47183-Weakley-County.txt    --wx out/47/47183-weakley-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47185-White-County.txt      --wx out/47/47185-white-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47187-Williamson-County.txt --wx out/47/47187-williamson-county.osm.bz2 \
    --bp completeWays=yes file=polys/47/47189-Wilson-County.txt     --wx out/47/47189-wilson-county.osm.bz2 \

touch -r tmp/tennessee.osm.pbf out/47/*.osm.???

./skeletron-roads.sh tmp/tennessee-roads.osm.pbf out/47 tennessee
./skeletron-routes.sh tmp/tennessee-routes.osm.bz2 out/47 tennessee
