#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/34

curl -s -o tmp/new-jersey.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/new-jersey.osm.pbf

osmosis --rb tmp/new-jersey.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/new-jersey-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/new-jersey-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/new-jersey-routes-B.osm.pbf \
            --tf accept-relations "network=US:NJ" --used-way --used-node --wb omitmetadata=true tmp/new-jersey-routes-C.osm.pbf \
            --tf accept-relations "network=US:NJ:CR" --used-way --used-node --wb omitmetadata=true tmp/new-jersey-routes-D.osm.pbf \

osmosis \
    --rb tmp/new-jersey-routes-A.osm.pbf \
    --rb tmp/new-jersey-routes-B.osm.pbf \
    --rb tmp/new-jersey-routes-C.osm.pbf \
    --rb tmp/new-jersey-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/new-jersey-routes.osm.bz2

osmosis \
    --rb tmp/new-jersey-roads.osm.pbf \
    --tee outputCount=21 \
    --bp completeWays=yes file=polys/34/34001-Atlantic-County.txt   --wx out/34/34001-atlantic-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34003-Bergen-County.txt     --wx out/34/34003-bergen-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34005-Burlington-County.txt --wx out/34/34005-burlington-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34007-Camden-County.txt     --wx out/34/34007-camden-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34009-Cape-May-County.txt   --wx out/34/34009-cape-may-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34011-Cumberland-County.txt --wx out/34/34011-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34013-Essex-County.txt      --wx out/34/34013-essex-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34015-Gloucester-County.txt --wx out/34/34015-gloucester-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34017-Hudson-County.txt     --wx out/34/34017-hudson-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34019-Hunterdon-County.txt  --wx out/34/34019-hunterdon-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34021-Mercer-County.txt     --wx out/34/34021-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34023-Middlesex-County.txt  --wx out/34/34023-middlesex-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34025-Monmouth-County.txt   --wx out/34/34025-monmouth-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34027-Morris-County.txt     --wx out/34/34027-morris-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34029-Ocean-County.txt      --wx out/34/34029-ocean-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34031-Passaic-County.txt    --wx out/34/34031-passaic-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34033-Salem-County.txt      --wx out/34/34033-salem-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34035-Somerset-County.txt   --wx out/34/34035-somerset-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34037-Sussex-County.txt     --wx out/34/34037-sussex-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34039-Union-County.txt      --wx out/34/34039-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/34/34041-Warren-County.txt     --wx out/34/34041-warren-county.osm.bz2 \

./skeletron-roads.sh tmp/new-jersey-roads.osm.pbf out/34 new-jersey
./skeletron-routes.sh tmp/new-jersey-routes.osm.bz2 out/34 new-jersey
