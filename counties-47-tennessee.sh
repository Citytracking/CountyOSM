#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/47

curl -s -o tmp/tennessee.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/tennessee.osm.pbf

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
    --bp completeWays=yes file=polys/47/47001-Anderson-County.txt   --wx out/47001-Anderson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47003-Bedford-County.txt    --wx out/47003-Bedford-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47005-Benton-County.txt     --wx out/47005-Benton-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47007-Bledsoe-County.txt    --wx out/47007-Bledsoe-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47009-Blount-County.txt     --wx out/47009-Blount-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47011-Bradley-County.txt    --wx out/47011-Bradley-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47013-Campbell-County.txt   --wx out/47013-Campbell-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47015-Cannon-County.txt     --wx out/47015-Cannon-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47017-Carroll-County.txt    --wx out/47017-Carroll-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47019-Carter-County.txt     --wx out/47019-Carter-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47021-Cheatham-County.txt   --wx out/47021-Cheatham-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47023-Chester-County.txt    --wx out/47023-Chester-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47025-Claiborne-County.txt  --wx out/47025-Claiborne-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47027-Clay-County.txt       --wx out/47027-Clay-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47029-Cocke-County.txt      --wx out/47029-Cocke-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47031-Coffee-County.txt     --wx out/47031-Coffee-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47033-Crockett-County.txt   --wx out/47033-Crockett-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47035-Cumberland-County.txt --wx out/47035-Cumberland-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47037-Davidson-County.txt   --wx out/47037-Davidson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47039-Decatur-County.txt    --wx out/47039-Decatur-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47041-DeKalb-County.txt     --wx out/47041-DeKalb-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47043-Dickson-County.txt    --wx out/47043-Dickson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47045-Dyer-County.txt       --wx out/47045-Dyer-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47047-Fayette-County.txt    --wx out/47047-Fayette-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47049-Fentress-County.txt   --wx out/47049-Fentress-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47051-Franklin-County.txt   --wx out/47051-Franklin-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47053-Gibson-County.txt     --wx out/47053-Gibson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47055-Giles-County.txt      --wx out/47055-Giles-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47057-Grainger-County.txt   --wx out/47057-Grainger-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47059-Greene-County.txt     --wx out/47059-Greene-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47061-Grundy-County.txt     --wx out/47061-Grundy-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47063-Hamblen-County.txt    --wx out/47063-Hamblen-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47065-Hamilton-County.txt   --wx out/47065-Hamilton-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47067-Hancock-County.txt    --wx out/47067-Hancock-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47069-Hardeman-County.txt   --wx out/47069-Hardeman-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47071-Hardin-County.txt     --wx out/47071-Hardin-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47073-Hawkins-County.txt    --wx out/47073-Hawkins-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47075-Haywood-County.txt    --wx out/47075-Haywood-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47077-Henderson-County.txt  --wx out/47077-Henderson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47079-Henry-County.txt      --wx out/47079-Henry-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47081-Hickman-County.txt    --wx out/47081-Hickman-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47083-Houston-County.txt    --wx out/47083-Houston-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47085-Humphreys-County.txt  --wx out/47085-Humphreys-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47087-Jackson-County.txt    --wx out/47087-Jackson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47089-Jefferson-County.txt  --wx out/47089-Jefferson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47091-Johnson-County.txt    --wx out/47091-Johnson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47093-Knox-County.txt       --wx out/47093-Knox-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47095-Lake-County.txt       --wx out/47095-Lake-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47097-Lauderdale-County.txt --wx out/47097-Lauderdale-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47099-Lawrence-County.txt   --wx out/47099-Lawrence-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47101-Lewis-County.txt      --wx out/47101-Lewis-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47103-Lincoln-County.txt    --wx out/47103-Lincoln-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47105-Loudon-County.txt     --wx out/47105-Loudon-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47107-McMinn-County.txt     --wx out/47107-McMinn-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47109-McNairy-County.txt    --wx out/47109-McNairy-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47111-Macon-County.txt      --wx out/47111-Macon-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47113-Madison-County.txt    --wx out/47113-Madison-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47115-Marion-County.txt     --wx out/47115-Marion-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47117-Marshall-County.txt   --wx out/47117-Marshall-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47119-Maury-County.txt      --wx out/47119-Maury-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47121-Meigs-County.txt      --wx out/47121-Meigs-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47123-Monroe-County.txt     --wx out/47123-Monroe-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47125-Montgomery-County.txt --wx out/47125-Montgomery-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47127-Moore-County.txt      --wx out/47127-Moore-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47129-Morgan-County.txt     --wx out/47129-Morgan-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47131-Obion-County.txt      --wx out/47131-Obion-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47133-Overton-County.txt    --wx out/47133-Overton-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47135-Perry-County.txt      --wx out/47135-Perry-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47137-Pickett-County.txt    --wx out/47137-Pickett-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47139-Polk-County.txt       --wx out/47139-Polk-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47141-Putnam-County.txt     --wx out/47141-Putnam-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47143-Rhea-County.txt       --wx out/47143-Rhea-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47145-Roane-County.txt      --wx out/47145-Roane-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47147-Robertson-County.txt  --wx out/47147-Robertson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47149-Rutherford-County.txt --wx out/47149-Rutherford-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47151-Scott-County.txt      --wx out/47151-Scott-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47153-Sequatchie-County.txt --wx out/47153-Sequatchie-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47155-Sevier-County.txt     --wx out/47155-Sevier-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47157-Shelby-County.txt     --wx out/47157-Shelby-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47159-Smith-County.txt      --wx out/47159-Smith-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47161-Stewart-County.txt    --wx out/47161-Stewart-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47163-Sullivan-County.txt   --wx out/47163-Sullivan-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47165-Sumner-County.txt     --wx out/47165-Sumner-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47167-Tipton-County.txt     --wx out/47167-Tipton-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47169-Trousdale-County.txt  --wx out/47169-Trousdale-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47171-Unicoi-County.txt     --wx out/47171-Unicoi-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47173-Union-County.txt      --wx out/47173-Union-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47175-Van-Buren-County.txt  --wx out/47175-Van-Buren-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47177-Warren-County.txt     --wx out/47177-Warren-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47179-Washington-County.txt --wx out/47179-Washington-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47181-Wayne-County.txt      --wx out/47181-Wayne-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47183-Weakley-County.txt    --wx out/47183-Weakley-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47185-White-County.txt      --wx out/47185-White-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47187-Williamson-County.txt --wx out/47187-Williamson-County/.osm.bz2 \
    --bp completeWays=yes file=polys/47/47189-Wilson-County.txt     --wx out/47189-Wilson-County/.osm.bz2 \

./skeletron-roads.sh tmp/tennessee-roads.osm.pbf out/47 tennessee
./skeletron-routes.sh tmp/tennessee-routes.osm.bz2 out/47 tennessee
