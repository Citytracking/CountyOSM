#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/17/w out/17/e

curl -Rs -o tmp/illinois.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/illinois.osm.pbf

osmosis --rb tmp/illinois.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/illinois-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/illinois-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/illinois-routes-B.osm.pbf \
            --tf accept-relations "network=US:IL" --used-way --used-node --wb omitmetadata=true tmp/illinois-routes-C.osm.pbf \
            --tf accept-relations "network=US:IL:CR" --used-way --used-node --wb omitmetadata=true tmp/illinois-routes-D.osm.pbf \

osmosis \
    --rb tmp/illinois-routes-A.osm.pbf \
    --rb tmp/illinois-routes-B.osm.pbf \
    --rb tmp/illinois-routes-C.osm.pbf \
    --rb tmp/illinois-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/illinois-routes.osm.bz2

osmosis \
    --rb tmp/illinois-roads.osm.pbf \
    --tee outputCount=102 \
    --bp completeWays=yes file=polys/17/17001-Adams-County.txt       --wx out/17/w/17001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17003-Alexander-County.txt   --wx out/17/w/17003-alexander-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17005-Bond-County.txt        --wx out/17/w/17005-bond-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17009-Brown-County.txt       --wx out/17/w/17009-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17011-Bureau-County.txt      --wx out/17/w/17011-bureau-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17013-Calhoun-County.txt     --wx out/17/w/17013-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17015-Carroll-County.txt     --wx out/17/w/17015-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17017-Cass-County.txt        --wx out/17/w/17017-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17021-Christian-County.txt   --wx out/17/w/17021-christian-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17027-Clinton-County.txt     --wx out/17/w/17027-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17057-Fulton-County.txt      --wx out/17/w/17057-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17061-Greene-County.txt      --wx out/17/w/17061-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17067-Hancock-County.txt     --wx out/17/w/17067-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17071-Henderson-County.txt   --wx out/17/w/17071-henderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17073-Henry-County.txt       --wx out/17/w/17073-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17077-Jackson-County.txt     --wx out/17/w/17077-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17083-Jersey-County.txt      --wx out/17/w/17083-jersey-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17085-Jo-Daviess-County.txt  --wx out/17/w/17085-jo-daviess-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17095-Knox-County.txt        --wx out/17/w/17095-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17103-Lee-County.txt         --wx out/17/w/17103-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17107-Logan-County.txt       --wx out/17/w/17107-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17117-Macoupin-County.txt    --wx out/17/w/17117-macoupin-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17119-Madison-County.txt     --wx out/17/w/17119-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17123-Marshall-County.txt    --wx out/17/w/17123-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17125-Mason-County.txt       --wx out/17/w/17125-mason-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17109-McDonough-County.txt   --wx out/17/w/17109-mcdonough-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17129-Menard-County.txt      --wx out/17/w/17129-menard-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17131-Mercer-County.txt      --wx out/17/w/17131-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17133-Monroe-County.txt      --wx out/17/w/17133-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17135-Montgomery-County.txt  --wx out/17/w/17135-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17137-Morgan-County.txt      --wx out/17/w/17137-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17141-Ogle-County.txt        --wx out/17/w/17141-ogle-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17143-Peoria-County.txt      --wx out/17/w/17143-peoria-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17145-Perry-County.txt       --wx out/17/w/17145-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17149-Pike-County.txt        --wx out/17/w/17149-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17153-Pulaski-County.txt     --wx out/17/w/17153-pulaski-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17155-Putnam-County.txt      --wx out/17/w/17155-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17157-Randolph-County.txt    --wx out/17/w/17157-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17161-Rock-Island-County.txt --wx out/17/w/17161-rock-island-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17163-St.-Clair-County.txt   --wx out/17/w/17163-st.-clair-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17167-Sangamon-County.txt    --wx out/17/w/17167-sangamon-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17169-Schuyler-County.txt    --wx out/17/w/17169-schuyler-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17171-Scott-County.txt       --wx out/17/w/17171-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17175-Stark-County.txt       --wx out/17/w/17175-stark-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17177-Stephenson-County.txt  --wx out/17/w/17177-stephenson-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17179-Tazewell-County.txt    --wx out/17/w/17179-tazewell-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17181-Union-County.txt       --wx out/17/w/17181-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17187-Warren-County.txt      --wx out/17/w/17187-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17189-Washington-County.txt  --wx out/17/w/17189-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17195-Whiteside-County.txt   --wx out/17/w/17195-whiteside-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17201-Winnebago-County.txt   --wx out/17/w/17201-winnebago-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17203-Woodford-County.txt    --wx out/17/w/17203-woodford-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17007-Boone-County.txt       --wx out/17/e/17007-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17019-Champaign-County.txt   --wx out/17/e/17019-champaign-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17023-Clark-County.txt       --wx out/17/e/17023-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17025-Clay-County.txt        --wx out/17/e/17025-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17029-Coles-County.txt       --wx out/17/e/17029-coles-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17031-Cook-County.txt        --wx out/17/e/17031-cook-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17033-Crawford-County.txt    --wx out/17/e/17033-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17035-Cumberland-County.txt  --wx out/17/e/17035-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17037-DeKalb-County.txt      --wx out/17/e/17037-dekalb-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17039-De-Witt-County.txt     --wx out/17/e/17039-de-witt-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17041-Douglas-County.txt     --wx out/17/e/17041-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17043-DuPage-County.txt      --wx out/17/e/17043-dupage-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17045-Edgar-County.txt       --wx out/17/e/17045-edgar-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17047-Edwards-County.txt     --wx out/17/e/17047-edwards-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17049-Effingham-County.txt   --wx out/17/e/17049-effingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17051-Fayette-County.txt     --wx out/17/e/17051-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17053-Ford-County.txt        --wx out/17/e/17053-ford-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17055-Franklin-County.txt    --wx out/17/e/17055-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17059-Gallatin-County.txt    --wx out/17/e/17059-gallatin-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17063-Grundy-County.txt      --wx out/17/e/17063-grundy-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17065-Hamilton-County.txt    --wx out/17/e/17065-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17069-Hardin-County.txt      --wx out/17/e/17069-hardin-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17075-Iroquois-County.txt    --wx out/17/e/17075-iroquois-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17079-Jasper-County.txt      --wx out/17/e/17079-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17081-Jefferson-County.txt   --wx out/17/e/17081-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17087-Johnson-County.txt     --wx out/17/e/17087-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17089-Kane-County.txt        --wx out/17/e/17089-kane-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17091-Kankakee-County.txt    --wx out/17/e/17091-kankakee-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17093-Kendall-County.txt     --wx out/17/e/17093-kendall-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17097-Lake-County.txt        --wx out/17/e/17097-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17099-LaSalle-County.txt     --wx out/17/e/17099-lasalle-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17101-Lawrence-County.txt    --wx out/17/e/17101-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17105-Livingston-County.txt  --wx out/17/e/17105-livingston-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17111-McHenry-County.txt     --wx out/17/e/17111-mchenry-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17113-McLean-County.txt      --wx out/17/e/17113-mclean-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17115-Macon-County.txt       --wx out/17/e/17115-macon-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17121-Marion-County.txt      --wx out/17/e/17121-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17127-Massac-County.txt      --wx out/17/e/17127-massac-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17139-Moultrie-County.txt    --wx out/17/e/17139-moultrie-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17147-Piatt-County.txt       --wx out/17/e/17147-piatt-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17151-Pope-County.txt        --wx out/17/e/17151-pope-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17159-Richland-County.txt    --wx out/17/e/17159-richland-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17165-Saline-County.txt      --wx out/17/e/17165-saline-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17173-Shelby-County.txt      --wx out/17/e/17173-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17183-Vermilion-County.txt   --wx out/17/e/17183-vermilion-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17185-Wabash-County.txt      --wx out/17/e/17185-wabash-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17191-Wayne-County.txt       --wx out/17/e/17191-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17193-White-County.txt       --wx out/17/e/17193-white-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17197-Will-County.txt        --wx out/17/e/17197-will-county.osm.bz2 \
    --bp completeWays=yes file=polys/17/17199-Williamson-County.txt  --wx out/17/e/17199-williamson-county.osm.bz2 \

touch -r tmp/illinois.osm.pbf out/17/*/*.osm.???

./skeletron-roads.sh tmp/illinois-roads.osm.pbf out/17 illinois IL
./skeletron-routes.sh tmp/illinois-routes.osm.bz2 out/17 illinois IL
