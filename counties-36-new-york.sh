#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/36/w out/36/c out/36/e out/36/li

curl -Rs -o tmp/new-york.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/new-york.osm.pbf

osmosis --rb tmp/new-york.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/new-york-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-B.osm.pbf \
            --tf accept-relations "network=US:NY" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-C.osm.pbf \
            --tf accept-relations "network=US:NY:CR" --used-way --used-node --wb omitmetadata=true tmp/new-york-routes-D.osm.pbf \

osmosis \
    --rb tmp/new-york-routes-A.osm.pbf \
    --rb tmp/new-york-routes-B.osm.pbf \
    --rb tmp/new-york-routes-C.osm.pbf \
    --rb tmp/new-york-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/new-york-routes.osm.bz2

osmosis \
    --rb tmp/new-york-roads.osm.pbf \
    --tee outputCount=62 \
    --bp completeWays=yes file=polys/36/36003-Allegany-County.txt     --wx out/36/w/36003-allegany-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36009-Cattaraugus-County.txt  --wx out/36/w/36009-cattaraugus-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36013-Chautauqua-County.txt   --wx out/36/w/36013-chautauqua-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36029-Erie-County.txt         --wx out/36/w/36029-erie-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36037-Genesee-County.txt      --wx out/36/w/36037-genesee-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36051-Livingston-County.txt   --wx out/36/w/36051-livingston-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36055-Monroe-County.txt       --wx out/36/w/36055-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36063-Niagara-County.txt      --wx out/36/w/36063-niagara-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36073-Orleans-County.txt      --wx out/36/w/36073-orleans-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36121-Wyoming-County.txt      --wx out/36/w/36121-wyoming-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36007-Broome-County.txt       --wx out/36/c/36007-broome-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36011-Cayuga-County.txt       --wx out/36/c/36011-cayuga-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36015-Chemung-County.txt      --wx out/36/c/36015-chemung-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36017-Chenango-County.txt     --wx out/36/c/36017-chenango-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36023-Cortland-County.txt     --wx out/36/c/36023-cortland-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36045-Jefferson-County.txt    --wx out/36/c/36045-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36049-Lewis-County.txt        --wx out/36/c/36049-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36053-Madison-County.txt      --wx out/36/c/36053-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36065-Oneida-County.txt       --wx out/36/c/36065-oneida-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36067-Onondaga-County.txt     --wx out/36/c/36067-onondaga-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36069-Ontario-County.txt      --wx out/36/c/36069-ontario-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36075-Oswego-County.txt       --wx out/36/c/36075-oswego-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36097-Schuyler-County.txt     --wx out/36/c/36097-schuyler-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36099-Seneca-County.txt       --wx out/36/c/36099-seneca-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36101-Steuben-County.txt      --wx out/36/c/36101-steuben-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36107-Tioga-County.txt        --wx out/36/c/36107-tioga-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36109-Tompkins-County.txt     --wx out/36/c/36109-tompkins-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36117-Wayne-County.txt        --wx out/36/c/36117-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36123-Yates-County.txt        --wx out/36/c/36123-yates-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36001-Albany-County.txt       --wx out/36/e/36001-albany-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36019-Clinton-County.txt      --wx out/36/e/36019-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36021-Columbia-County.txt     --wx out/36/e/36021-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36025-Delaware-County.txt     --wx out/36/e/36025-delaware-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36027-Dutchess-County.txt     --wx out/36/e/36027-dutchess-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36031-Essex-County.txt        --wx out/36/e/36031-essex-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36033-Franklin-County.txt     --wx out/36/e/36033-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36035-Fulton-County.txt       --wx out/36/e/36035-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36039-Greene-County.txt       --wx out/36/e/36039-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36041-Hamilton-County.txt     --wx out/36/e/36041-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36043-Herkimer-County.txt     --wx out/36/e/36043-herkimer-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36057-Montgomery-County.txt   --wx out/36/e/36057-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36071-Orange-County.txt       --wx out/36/e/36071-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36077-Otsego-County.txt       --wx out/36/e/36077-otsego-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36079-Putnam-County.txt       --wx out/36/e/36079-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36083-Rensselaer-County.txt   --wx out/36/e/36083-rensselaer-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36087-Rockland-County.txt     --wx out/36/e/36087-rockland-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36089-St.-Lawrence-County.txt --wx out/36/e/36089-st.-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36091-Saratoga-County.txt     --wx out/36/e/36091-saratoga-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36093-Schenectady-County.txt  --wx out/36/e/36093-schenectady-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36095-Schoharie-County.txt    --wx out/36/e/36095-schoharie-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36105-Sullivan-County.txt     --wx out/36/e/36105-sullivan-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36111-Ulster-County.txt       --wx out/36/e/36111-ulster-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36113-Warren-County.txt       --wx out/36/e/36113-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36115-Washington-County.txt   --wx out/36/e/36115-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36119-Westchester-County.txt  --wx out/36/e/36119-westchester-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36005-Bronx-County.txt        --wx out/36/li/36005-bronx-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36047-Kings-County.txt        --wx out/36/li/36047-kings-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36059-Nassau-County.txt       --wx out/36/li/36059-nassau-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36061-New-York-County.txt     --wx out/36/li/36061-new-york-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36081-Queens-County.txt       --wx out/36/li/36081-queens-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36085-Richmond-County.txt     --wx out/36/li/36085-richmond-county.osm.bz2 \
    --bp completeWays=yes file=polys/36/36103-Suffolk-County.txt      --wx out/36/li/36103-suffolk-county.osm.bz2 \

touch -r tmp/new-york.osm.pbf out/36/*/*.osm.???

./skeletron-roads.sh tmp/new-york-roads.osm.pbf out/36 new-york NY
./skeletron-routes.sh tmp/new-york-routes.osm.bz2 out/36 new-york NY
