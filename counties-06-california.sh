#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/06

curl -s -o tmp/california.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/california.osm.pbf

osmosis --rb tmp/california.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/california-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/california-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/california-routes-B.osm.pbf \
            --tf accept-relations "network=US:CA" --used-way --used-node --wb omitmetadata=true tmp/california-routes-C.osm.pbf \
            --tf accept-relations "network=US:CA:CR" --used-way --used-node --wb omitmetadata=true tmp/california-routes-D.osm.pbf \

osmosis \
    --rb tmp/california-routes-A.osm.pbf \
    --rb tmp/california-routes-B.osm.pbf \
    --rb tmp/california-routes-C.osm.pbf \
    --rb tmp/california-routes-D.osm.pbf \
    --merge --merge --merge \
    --tee outputCount=7 \
    --bp completeWays=yes file=polys/06001-Alameda-County.txt       --wx out/06/06001-alameda-routes.osm.bz2 \
    --bp completeWays=yes file=polys/06013-Contra-Costa-County.txt  --wx out/06/06013-contra-costa-routes.osm.bz2 \
    --bp completeWays=yes file=polys/06041-Marin-County.txt         --wx out/06/06041-marin-routes.osm.bz2 \
    --bp completeWays=yes file=polys/06075-San-Francisco-County.txt --wx out/06/06075-san-francisco-routes.osm.bz2 \
    --bp completeWays=yes file=polys/06081-San-Mateo-County.txt     --wx out/06/06081-san-mateo-routes.osm.bz2 \
    --bp completeWays=yes file=polys/06085-Santa-Clara-County.txt   --wx out/06/06085-santa-clara-routes.osm.bz2 \
    --bp completeWays=yes file=polys/06087-Santa-Cruz-County.txt    --wx out/06/06087-santa-cruz-routes.osm.bz2 \

osmosis \
    --rb tmp/california-roads.osm.pbf \
    --tee outputCount=7 \
    --bp completeWays=yes file=polys/06001-Alameda-County.txt       --wx out/06/06001-alameda-roads.osm.bz2 \
    --bp completeWays=yes file=polys/06013-Contra-Costa-County.txt  --wx out/06/06013-contra-costa-roads.osm.bz2 \
    --bp completeWays=yes file=polys/06041-Marin-County.txt         --wx out/06/06041-marin-roads.osm.bz2 \
    --bp completeWays=yes file=polys/06075-San-Francisco-County.txt --wx out/06/06075-san-francisco-roads.osm.bz2 \
    --bp completeWays=yes file=polys/06081-San-Mateo-County.txt     --wx out/06/06081-san-mateo-roads.osm.bz2 \
    --bp completeWays=yes file=polys/06085-Santa-Clara-County.txt   --wx out/06/06085-santa-clara-roads.osm.bz2 \
    --bp completeWays=yes file=polys/06087-Santa-Cruz-County.txt    --wx out/06/06087-santa-cruz-roads.osm.bz2 \

