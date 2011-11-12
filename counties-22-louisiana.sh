#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/22/n out/22/s

curl -s -o tmp/louisiana.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/louisiana.osm.pbf

osmosis --rb tmp/louisiana.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/louisiana-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/louisiana-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/louisiana-routes-B.osm.pbf \
            --tf accept-relations "network=US:LA" --used-way --used-node --wb omitmetadata=true tmp/louisiana-routes-C.osm.pbf \
            --tf accept-relations "network=US:LA:CR" --used-way --used-node --wb omitmetadata=true tmp/louisiana-routes-D.osm.pbf \

osmosis \
    --rb tmp/louisiana-routes-A.osm.pbf \
    --rb tmp/louisiana-routes-B.osm.pbf \
    --rb tmp/louisiana-routes-C.osm.pbf \
    --rb tmp/louisiana-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/louisiana-routes.osm.bz2

osmosis \
    --rb tmp/louisiana-roads.osm.pbf \
    --tee outputCount=64 \
    --bp completeWays=yes file=polys/22/22009-Avoyelles-Parish.txt            --wx out/22/n/22009-avoyelles-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22013-Bienville-Parish.txt            --wx out/22/n/22013-bienville-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22015-Bossier-Parish.txt              --wx out/22/n/22015-bossier-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22017-Caddo-Parish.txt                --wx out/22/n/22017-caddo-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22021-Caldwell-Parish.txt             --wx out/22/n/22021-caldwell-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22025-Catahoula-Parish.txt            --wx out/22/n/22025-catahoula-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22027-Claiborne-Parish.txt            --wx out/22/n/22027-claiborne-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22029-Concordia-Parish.txt            --wx out/22/n/22029-concordia-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22031-De-Soto-Parish.txt              --wx out/22/n/22031-de-soto-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22035-East-Carroll-Parish.txt         --wx out/22/n/22035-east-carroll-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22041-Franklin-Parish.txt             --wx out/22/n/22041-franklin-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22043-Grant-Parish.txt                --wx out/22/n/22043-grant-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22049-Jackson-Parish.txt              --wx out/22/n/22049-jackson-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22059-La-Salle-Parish.txt             --wx out/22/n/22059-la-salle-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22061-Lincoln-Parish.txt              --wx out/22/n/22061-lincoln-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22065-Madison-Parish.txt              --wx out/22/n/22065-madison-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22067-Morehouse-Parish.txt            --wx out/22/n/22067-morehouse-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22069-Natchitoches-Parish.txt         --wx out/22/n/22069-natchitoches-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22073-Ouachita-Parish.txt             --wx out/22/n/22073-ouachita-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22079-Rapides-Parish.txt              --wx out/22/n/22079-rapides-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22081-Red-River-Parish.txt            --wx out/22/n/22081-red-river-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22083-Richland-Parish.txt             --wx out/22/n/22083-richland-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22085-Sabine-Parish.txt               --wx out/22/n/22085-sabine-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22107-Tensas-Parish.txt               --wx out/22/n/22107-tensas-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22111-Union-Parish.txt                --wx out/22/n/22111-union-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22115-Vernon-Parish.txt               --wx out/22/n/22115-vernon-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22119-Webster-Parish.txt              --wx out/22/n/22119-webster-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22123-West-Carroll-Parish.txt         --wx out/22/n/22123-west-carroll-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22127-Winn-Parish.txt                 --wx out/22/n/22127-winn-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22001-Acadia-Parish.txt               --wx out/22/s/22001-acadia-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22003-Allen-Parish.txt                --wx out/22/s/22003-allen-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22005-Ascension-Parish.txt            --wx out/22/s/22005-ascension-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22007-Assumption-Parish.txt           --wx out/22/s/22007-assumption-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22011-Beauregard-Parish.txt           --wx out/22/s/22011-beauregard-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22019-Calcasieu-Parish.txt            --wx out/22/s/22019-calcasieu-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22023-Cameron-Parish.txt              --wx out/22/s/22023-cameron-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22033-East-Baton-Rouge-Parish.txt     --wx out/22/s/22033-east-baton-rouge-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22037-East-Feliciana-Parish.txt       --wx out/22/s/22037-east-feliciana-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22039-Evangeline-Parish.txt           --wx out/22/s/22039-evangeline-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22045-Iberia-Parish.txt               --wx out/22/s/22045-iberia-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22047-Iberville-Parish.txt            --wx out/22/s/22047-iberville-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22051-Jefferson-Parish.txt            --wx out/22/s/22051-jefferson-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22053-Jefferson-Davis-Parish.txt      --wx out/22/s/22053-jefferson-davis-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22055-Lafayette-Parish.txt            --wx out/22/s/22055-lafayette-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22057-Lafourche-Parish.txt            --wx out/22/s/22057-lafourche-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22063-Livingston-Parish.txt           --wx out/22/s/22063-livingston-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22071-Orleans-Parish.txt              --wx out/22/s/22071-orleans-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22075-Plaquemines-Parish.txt          --wx out/22/s/22075-plaquemines-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22077-Pointe-Coupee-Parish.txt        --wx out/22/s/22077-pointe-coupee-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22087-St.-Bernard-Parish.txt          --wx out/22/s/22087-st.-bernard-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22089-St.-Charles-Parish.txt          --wx out/22/s/22089-st.-charles-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22091-St.-Helena-Parish.txt           --wx out/22/s/22091-st.-helena-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22093-St.-James-Parish.txt            --wx out/22/s/22093-st.-james-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22095-St.-John-the-Baptist-Parish.txt --wx out/22/s/22095-st.-john-the-baptist-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22097-St.-Landry-Parish.txt           --wx out/22/s/22097-st.-landry-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22099-St.-Martin-Parish.txt           --wx out/22/s/22099-st.-martin-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22101-St.-Mary-Parish.txt             --wx out/22/s/22101-st.-mary-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22103-St.-Tammany-Parish.txt          --wx out/22/s/22103-st.-tammany-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22105-Tangipahoa-Parish.txt           --wx out/22/s/22105-tangipahoa-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22109-Terrebonne-Parish.txt           --wx out/22/s/22109-terrebonne-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22113-Vermilion-Parish.txt            --wx out/22/s/22113-vermilion-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22117-Washington-Parish.txt           --wx out/22/s/22117-washington-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22121-West-Baton-Rouge-Parish.txt     --wx out/22/s/22121-west-baton-rouge-parish.osm.bz2 \
    --bp completeWays=yes file=polys/22/22125-West-Feliciana-Parish.txt       --wx out/22/s/22125-west-feliciana-parish.osm.bz2 \

./skeletron-routes.sh tmp/louisiana-routes.osm.bz2 out/22 louisiana
./skeletron-roads.sh tmp/louisiana-roads.osm.pbf out/22 louisiana
