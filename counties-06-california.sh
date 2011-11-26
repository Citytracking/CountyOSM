#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/06/i out/06/ii out/06/iii out/06/iv out/06/v out/06/vi

curl -Rs -o tmp/california.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/california.osm.pbf

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
    --wx tmp/california-routes.osm.bz2

osmosis \
    --rb tmp/california-roads.osm.pbf \
    --tee outputCount=58 \
    --bp completeWays=yes file=polys/06/06015-Del-Norte-County.txt         --wx out/06/i/06015-del-norte-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06023-Humboldt-County.txt          --wx out/06/i/06023-humboldt-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06035-Lassen-County.txt            --wx out/06/i/06035-lassen-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06049-Modoc-County.txt             --wx out/06/i/06049-modoc-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06063-Plumas-County.txt            --wx out/06/i/06063-plumas-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06089-Shasta-County.txt            --wx out/06/i/06089-shasta-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06093-Siskiyou-County.txt          --wx out/06/i/06093-siskiyou-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06103-Tehama-County.txt            --wx out/06/i/06103-tehama-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06105-Trinity-County.txt           --wx out/06/i/06105-trinity-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06003-Alpine-County.txt            --wx out/06/ii/06003-alpine-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06005-Amador-County.txt            --wx out/06/ii/06005-amador-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06007-Butte-County.txt             --wx out/06/ii/06007-butte-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06011-Colusa-County.txt            --wx out/06/ii/06011-colusa-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06017-El-Dorado-County.txt         --wx out/06/ii/06017-el-dorado-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06021-Glenn-County.txt             --wx out/06/ii/06021-glenn-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06033-Lake-County.txt              --wx out/06/ii/06033-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06045-Mendocino-County.txt         --wx out/06/ii/06045-mendocino-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06055-Napa-County.txt              --wx out/06/ii/06055-napa-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06057-Nevada-County.txt            --wx out/06/ii/06057-nevada-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06061-Placer-County.txt            --wx out/06/ii/06061-placer-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06067-Sacramento-County.txt        --wx out/06/ii/06067-sacramento-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06091-Sierra-County.txt            --wx out/06/ii/06091-sierra-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06095-Solano-County.txt            --wx out/06/ii/06095-solano-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06097-Sonoma-County.txt            --wx out/06/ii/06097-sonoma-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06101-Sutter-County.txt            --wx out/06/ii/06101-sutter-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06113-Yolo-County.txt              --wx out/06/ii/06113-yolo-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06115-Yuba-County.txt              --wx out/06/ii/06115-yuba-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06001-Alameda-County.txt           --wx out/06/iii/06001-alameda-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06009-Calaveras-County.txt         --wx out/06/iii/06009-calaveras-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06013-Contra-Costa-County.txt      --wx out/06/iii/06013-contra-costa-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06039-Madera-County.txt            --wx out/06/iii/06039-madera-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06041-Marin-County.txt             --wx out/06/iii/06041-marin-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06043-Mariposa-County.txt          --wx out/06/iii/06043-mariposa-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06047-Merced-County.txt            --wx out/06/iii/06047-merced-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06051-Mono-County.txt              --wx out/06/iii/06051-mono-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06075-San-Francisco-County.txt     --wx out/06/iii/06075-san-francisco-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06077-San-Joaquin-County.txt       --wx out/06/iii/06077-san-joaquin-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06081-San-Mateo-County.txt         --wx out/06/iii/06081-san-mateo-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06085-Santa-Clara-County.txt       --wx out/06/iii/06085-santa-clara-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06087-Santa-Cruz-County.txt        --wx out/06/iii/06087-santa-cruz-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06099-Stanislaus-County.txt        --wx out/06/iii/06099-stanislaus-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06109-Tuolumne-County.txt          --wx out/06/iii/06109-tuolumne-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06019-Fresno-County.txt            --wx out/06/iv/06019-fresno-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06027-Inyo-County.txt              --wx out/06/iv/06027-inyo-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06031-Kings-County.txt             --wx out/06/iv/06031-kings-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06053-Monterey-County.txt          --wx out/06/iv/06053-monterey-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06069-San-Benito-County.txt        --wx out/06/iv/06069-san-benito-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06107-Tulare-County.txt            --wx out/06/iv/06107-tulare-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06029-Kern-County.txt              --wx out/06/v/06029-kern-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06037-Los-Angeles-County.txt       --wx out/06/v/06037-los-angeles-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06071-San-Bernardino-County.txt    --wx out/06/v/06071-san-bernardino-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06079-San-Luis-Obispo-County.txt   --wx out/06/v/06079-san-luis-obispo-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06083-Santa-Barbara-County.txt     --wx out/06/v/06083-santa-barbara-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06111-Ventura-County.txt           --wx out/06/v/06111-ventura-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06025-Imperial-County.txt          --wx out/06/vi/06025-imperial-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06059-Orange-County.txt            --wx out/06/vi/06059-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06065-Riverside-County.txt         --wx out/06/vi/06065-riverside-county.osm.bz2 \
    --bp completeWays=yes file=polys/06/06073-San-Diego-County.txt         --wx out/06/vi/06073-san-diego-county.osm.bz2 \

touch -r tmp/california.osm.pbf out/06/*/*.osm.???

./skeletron-roads.sh tmp/california-roads.osm.pbf out/06 california
./skeletron-routes.sh tmp/california-routes.osm.bz2 out/06 california
