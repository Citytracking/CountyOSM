#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/45/n out/45/s

curl -Rs -o tmp/south-carolina.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/south-carolina.osm.pbf

osmosis --rb tmp/south-carolina.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/south-carolina-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/south-carolina-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/south-carolina-routes-B.osm.pbf \
            --tf accept-relations "network=US:SC" --used-way --used-node --wb omitmetadata=true tmp/south-carolina-routes-C.osm.pbf \
            --tf accept-relations "network=US:SC:CR" --used-way --used-node --wb omitmetadata=true tmp/south-carolina-routes-D.osm.pbf \

osmosis \
    --rb tmp/south-carolina-routes-A.osm.pbf \
    --rb tmp/south-carolina-routes-B.osm.pbf \
    --rb tmp/south-carolina-routes-C.osm.pbf \
    --rb tmp/south-carolina-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/south-carolina-routes.osm.bz2

osmosis \
    --rb tmp/south-carolina-roads.osm.pbf \
    --tee outputCount=46 \
    --bp completeWays=yes file=polys/45/45001-Abbeville-County.txt    --wx out/45/n/45001-abbeville-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45007-Anderson-County.txt     --wx out/45/n/45007-anderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45017-Calhoun-County.txt      --wx out/45/n/45017-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45021-Cherokee-County.txt     --wx out/45/n/45021-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45023-Chester-County.txt      --wx out/45/n/45023-chester-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45025-Chesterfield-County.txt --wx out/45/n/45025-chesterfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45031-Darlington-County.txt   --wx out/45/n/45031-darlington-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45033-Dillon-County.txt       --wx out/45/n/45033-dillon-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45037-Edgefield-County.txt    --wx out/45/n/45037-edgefield-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45039-Fairfield-County.txt    --wx out/45/n/45039-fairfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45041-Florence-County.txt     --wx out/45/n/45041-florence-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45045-Greenville-County.txt   --wx out/45/n/45045-greenville-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45047-Greenwood-County.txt    --wx out/45/n/45047-greenwood-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45051-Horry-County.txt        --wx out/45/n/45051-horry-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45055-Kershaw-County.txt      --wx out/45/n/45055-kershaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45057-Lancaster-County.txt    --wx out/45/n/45057-lancaster-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45059-Laurens-County.txt      --wx out/45/n/45059-laurens-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45061-Lee-County.txt          --wx out/45/n/45061-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45063-Lexington-County.txt    --wx out/45/n/45063-lexington-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45067-Marion-County.txt       --wx out/45/n/45067-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45069-Marlboro-County.txt     --wx out/45/n/45069-marlboro-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45065-McCormick-County.txt    --wx out/45/n/45065-mccormick-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45071-Newberry-County.txt     --wx out/45/n/45071-newberry-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45073-Oconee-County.txt       --wx out/45/n/45073-oconee-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45077-Pickens-County.txt      --wx out/45/n/45077-pickens-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45079-Richland-County.txt     --wx out/45/n/45079-richland-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45081-Saluda-County.txt       --wx out/45/n/45081-saluda-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45083-Spartanburg-County.txt  --wx out/45/n/45083-spartanburg-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45085-Sumter-County.txt       --wx out/45/n/45085-sumter-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45087-Union-County.txt        --wx out/45/n/45087-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45091-York-County.txt         --wx out/45/n/45091-york-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45003-Aiken-County.txt        --wx out/45/s/45003-aiken-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45005-Allendale-County.txt    --wx out/45/s/45005-allendale-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45009-Bamberg-County.txt      --wx out/45/s/45009-bamberg-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45011-Barnwell-County.txt     --wx out/45/s/45011-barnwell-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45013-Beaufort-County.txt     --wx out/45/s/45013-beaufort-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45015-Berkeley-County.txt     --wx out/45/s/45015-berkeley-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45019-Charleston-County.txt   --wx out/45/s/45019-charleston-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45027-Clarendon-County.txt    --wx out/45/s/45027-clarendon-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45029-Colleton-County.txt     --wx out/45/s/45029-colleton-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45035-Dorchester-County.txt   --wx out/45/s/45035-dorchester-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45043-Georgetown-County.txt   --wx out/45/s/45043-georgetown-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45049-Hampton-County.txt      --wx out/45/s/45049-hampton-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45053-Jasper-County.txt       --wx out/45/s/45053-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45075-Orangeburg-County.txt   --wx out/45/s/45075-orangeburg-county.osm.bz2 \
    --bp completeWays=yes file=polys/45/45089-Williamsburg-County.txt --wx out/45/s/45089-williamsburg-county.osm.bz2 \

touch -r tmp/south-carolina.osm.pbf out/45/*/*.osm.???

./skeletron-roads.sh tmp/south-carolina-roads.osm.pbf out/45 south-carolina
./skeletron-routes.sh tmp/south-carolina-routes.osm.bz2 out/45 south-carolina

touch -r tmp/south-carolina.osm.pbf out/45/*.pgsql
