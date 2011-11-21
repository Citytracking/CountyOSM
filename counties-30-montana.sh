#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/30/n out/30/c out/30/s

curl -s -o tmp/montana.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/montana.osm.pbf

osmosis --rb tmp/montana.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/montana-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/montana-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/montana-routes-B.osm.pbf \
            --tf accept-relations "network=US:UT" --used-way --used-node --wb omitmetadata=true tmp/montana-routes-C.osm.pbf \
            --tf accept-relations "network=US:UT:CR" --used-way --used-node --wb omitmetadata=true tmp/montana-routes-D.osm.pbf \

osmosis \
    --rb tmp/montana-routes-A.osm.pbf \
    --rb tmp/montana-routes-B.osm.pbf \
    --rb tmp/montana-routes-C.osm.pbf \
    --rb tmp/montana-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/montana-routes.osm.bz2

osmosis \
    --rb tmp/montana-roads.osm.pbf \
    --tee outputCount=56 \
    --bp completeWays=yes file=polys/30/30005-Blaine-County.txt          --wx out/30/n/30005-blaine-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30015-Chouteau-County.txt        --wx out/30/n/30015-chouteau-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30019-Daniels-County.txt         --wx out/30/n/30019-daniels-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30029-Flathead-County.txt        --wx out/30/n/30029-flathead-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30035-Glacier-County.txt         --wx out/30/n/30035-glacier-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30041-Hill-County.txt            --wx out/30/n/30041-hill-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30051-Liberty-County.txt         --wx out/30/n/30051-liberty-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30053-Lincoln-County.txt         --wx out/30/n/30053-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30071-Phillips-County.txt        --wx out/30/n/30071-phillips-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30073-Pondera-County.txt         --wx out/30/n/30073-pondera-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30085-Roosevelt-County.txt       --wx out/30/n/30085-roosevelt-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30091-Sheridan-County.txt        --wx out/30/n/30091-sheridan-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30099-Teton-County.txt           --wx out/30/n/30099-teton-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30101-Toole-County.txt           --wx out/30/n/30101-toole-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30105-Valley-County.txt          --wx out/30/n/30105-valley-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30013-Cascade-County.txt         --wx out/30/c/30013-cascade-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30021-Dawson-County.txt          --wx out/30/c/30021-dawson-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30027-Fergus-County.txt          --wx out/30/c/30027-fergus-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30033-Garfield-County.txt        --wx out/30/c/30033-garfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30045-Judith-Basin-County.txt    --wx out/30/c/30045-judith-basin-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30047-Lake-County.txt            --wx out/30/c/30047-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30049-Lewis-and-Clark-County.txt --wx out/30/c/30049-lewis-and-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30055-McCone-County.txt          --wx out/30/c/30055-mccone-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30059-Meagher-County.txt         --wx out/30/c/30059-meagher-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30061-Mineral-County.txt         --wx out/30/c/30061-mineral-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30063-Missoula-County.txt        --wx out/30/c/30063-missoula-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30069-Petroleum-County.txt       --wx out/30/c/30069-petroleum-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30077-Powell-County.txt          --wx out/30/c/30077-powell-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30079-Prairie-County.txt         --wx out/30/c/30079-prairie-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30083-Richland-County.txt        --wx out/30/c/30083-richland-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30089-Sanders-County.txt         --wx out/30/c/30089-sanders-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30109-Wibaux-County.txt          --wx out/30/c/30109-wibaux-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30001-Beaverhead-County.txt      --wx out/30/s/30001-beaverhead-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30003-Big-Horn-County.txt        --wx out/30/s/30003-big-horn-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30007-Broadwater-County.txt      --wx out/30/s/30007-broadwater-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30009-Carbon-County.txt          --wx out/30/s/30009-carbon-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30011-Carter-County.txt          --wx out/30/s/30011-carter-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30017-Custer-County.txt          --wx out/30/s/30017-custer-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30023-Deer-Lodge-County.txt      --wx out/30/s/30023-deer-lodge-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30025-Fallon-County.txt          --wx out/30/s/30025-fallon-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30031-Gallatin-County.txt        --wx out/30/s/30031-gallatin-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30037-Golden-Valley-County.txt   --wx out/30/s/30037-golden-valley-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30039-Granite-County.txt         --wx out/30/s/30039-granite-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30043-Jefferson-County.txt       --wx out/30/s/30043-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30057-Madison-County.txt         --wx out/30/s/30057-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30065-Musselshell-County.txt     --wx out/30/s/30065-musselshell-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30067-Park-County.txt            --wx out/30/s/30067-park-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30075-Powder-River-County.txt    --wx out/30/s/30075-powder-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30081-Ravalli-County.txt         --wx out/30/s/30081-ravalli-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30087-Rosebud-County.txt         --wx out/30/s/30087-rosebud-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30093-Silver-Bow-County.txt      --wx out/30/s/30093-silver-bow-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30095-Stillwater-County.txt      --wx out/30/s/30095-stillwater-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30097-Sweet-Grass-County.txt     --wx out/30/s/30097-sweet-grass-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30103-Treasure-County.txt        --wx out/30/s/30103-treasure-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30107-Wheatland-County.txt       --wx out/30/s/30107-wheatland-county.osm.bz2 \
    --bp completeWays=yes file=polys/30/30111-Yellowstone-County.txt     --wx out/30/s/30111-yellowstone-county.osm.bz2 \

./skeletron-roads.sh tmp/montana-roads.osm.pbf out/30 montana
./skeletron-routes.sh tmp/montana-routes.osm.bz2 out/30 montana
