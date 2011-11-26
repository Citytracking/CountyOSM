#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/35/w out/35/c out/35/e

curl -Rs -o tmp/new-mexico.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/new-mexico.osm.pbf

osmosis --rb tmp/new-mexico.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/new-mexico-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/new-mexico-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/new-mexico-routes-B.osm.pbf \
            --tf accept-relations "network=US:NM" --used-way --used-node --wb omitmetadata=true tmp/new-mexico-routes-C.osm.pbf \
            --tf accept-relations "network=US:NM:CR" --used-way --used-node --wb omitmetadata=true tmp/new-mexico-routes-D.osm.pbf \

osmosis \
    --rb tmp/new-mexico-routes-A.osm.pbf \
    --rb tmp/new-mexico-routes-B.osm.pbf \
    --rb tmp/new-mexico-routes-C.osm.pbf \
    --rb tmp/new-mexico-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/new-mexico-routes.osm.bz2

osmosis \
    --rb tmp/new-mexico-roads.osm.pbf \
    --tee outputCount=33 \
    --bp completeWays=yes file=polys/35/35003-Catron-County.txt     --wx out/35/w/35003-catron-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35006-Cibola-County.txt     --wx out/35/w/35006-cibola-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35017-Grant-County.txt      --wx out/35/w/35017-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35023-Hidalgo-County.txt    --wx out/35/w/35023-hidalgo-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35029-Luna-County.txt       --wx out/35/w/35029-luna-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35031-McKinley-County.txt   --wx out/35/w/35031-mckinley-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35045-San-Juan-County.txt   --wx out/35/w/35045-san-juan-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35051-Sierra-County.txt     --wx out/35/w/35051-sierra-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35001-Bernalillo-County.txt --wx out/35/c/35001-bernalillo-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35013-Dona-Ana-County.txt   --wx out/35/c/35013-dona-ana-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35027-Lincoln-County.txt    --wx out/35/c/35027-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35028-Los-Alamos-County.txt --wx out/35/c/35028-los-alamos-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35035-Otero-County.txt      --wx out/35/c/35035-otero-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35039-Rio-Arriba-County.txt --wx out/35/c/35039-rio-arriba-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35043-Sandoval-County.txt   --wx out/35/c/35043-sandoval-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35049-Santa-Fe-County.txt   --wx out/35/c/35049-santa-fe-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35053-Socorro-County.txt    --wx out/35/c/35053-socorro-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35055-Taos-County.txt       --wx out/35/c/35055-taos-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35057-Torrance-County.txt   --wx out/35/c/35057-torrance-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35061-Valencia-County.txt   --wx out/35/c/35061-valencia-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35005-Chaves-County.txt     --wx out/35/e/35005-chaves-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35007-Colfax-County.txt     --wx out/35/e/35007-colfax-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35009-Curry-County.txt      --wx out/35/e/35009-curry-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35011-De-Baca-County.txt    --wx out/35/e/35011-de-baca-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35015-Eddy-County.txt       --wx out/35/e/35015-eddy-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35019-Guadalupe-County.txt  --wx out/35/e/35019-guadalupe-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35021-Harding-County.txt    --wx out/35/e/35021-harding-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35025-Lea-County.txt        --wx out/35/e/35025-lea-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35033-Mora-County.txt       --wx out/35/e/35033-mora-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35037-Quay-County.txt       --wx out/35/e/35037-quay-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35041-Roosevelt-County.txt  --wx out/35/e/35041-roosevelt-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35047-San-Miguel-County.txt --wx out/35/e/35047-san-miguel-county.osm.bz2 \
    --bp completeWays=yes file=polys/35/35059-Union-County.txt      --wx out/35/e/35059-union-county.osm.bz2 \

touch -r tmp/new-mexico.osm.pbf out/35/*.osm.???

./skeletron-roads.sh tmp/new-mexico-roads.osm.pbf out/35 new-mexico
./skeletron-routes.sh tmp/new-mexico-routes.osm.bz2 out/35 new-mexico

touch -r tmp/new-mexico.osm.pbf out/35/*.pgsql
