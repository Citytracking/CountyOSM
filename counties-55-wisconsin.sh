#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/55/n out/55/c out/55/s

curl -Rs -o tmp/wisconsin.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/wisconsin.osm.pbf

osmosis --rb tmp/wisconsin.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/wisconsin-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/wisconsin-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/wisconsin-routes-B.osm.pbf \
            --tf accept-relations "network=US:WI" --used-way --used-node --wb omitmetadata=true tmp/wisconsin-routes-C.osm.pbf \
            --tf accept-relations "network=US:WI:CR" --used-way --used-node --wb omitmetadata=true tmp/wisconsin-routes-D.osm.pbf \

osmosis \
    --rb tmp/wisconsin-routes-A.osm.pbf \
    --rb tmp/wisconsin-routes-B.osm.pbf \
    --rb tmp/wisconsin-routes-C.osm.pbf \
    --rb tmp/wisconsin-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/wisconsin-routes.osm.bz2

osmosis \
    --rb tmp/wisconsin-roads.osm.pbf \
    --tee outputCount=72 \
    --bp completeWays=yes file=polys/55/55003-Ashland-County.txt     --wx out/55/n/55003-ashland-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55007-Bayfield-County.txt    --wx out/55/n/55007-bayfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55013-Burnett-County.txt     --wx out/55/n/55013-burnett-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55031-Douglas-County.txt     --wx out/55/n/55031-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55037-Florence-County.txt    --wx out/55/n/55037-florence-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55041-Forest-County.txt      --wx out/55/n/55041-forest-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55051-Iron-County.txt        --wx out/55/n/55051-iron-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55085-Oneida-County.txt      --wx out/55/n/55085-oneida-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55099-Price-County.txt       --wx out/55/n/55099-price-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55113-Sawyer-County.txt      --wx out/55/n/55113-sawyer-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55125-Vilas-County.txt       --wx out/55/n/55125-vilas-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55129-Washburn-County.txt    --wx out/55/n/55129-washburn-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55005-Barron-County.txt      --wx out/55/c/55005-barron-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55009-Brown-County.txt       --wx out/55/c/55009-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55011-Buffalo-County.txt     --wx out/55/c/55011-buffalo-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55017-Chippewa-County.txt    --wx out/55/c/55017-chippewa-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55019-Clark-County.txt       --wx out/55/c/55019-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55029-Door-County.txt        --wx out/55/c/55029-door-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55033-Dunn-County.txt        --wx out/55/c/55033-dunn-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55035-Eau-Claire-County.txt  --wx out/55/c/55035-eau-claire-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55053-Jackson-County.txt     --wx out/55/c/55053-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55061-Kewaunee-County.txt    --wx out/55/c/55061-kewaunee-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55067-Langlade-County.txt    --wx out/55/c/55067-langlade-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55069-Lincoln-County.txt     --wx out/55/c/55069-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55073-Marathon-County.txt    --wx out/55/c/55073-marathon-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55075-Marinette-County.txt   --wx out/55/c/55075-marinette-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55078-Menominee-County.txt   --wx out/55/c/55078-menominee-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55083-Oconto-County.txt      --wx out/55/c/55083-oconto-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55087-Outagamie-County.txt   --wx out/55/c/55087-outagamie-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55091-Pepin-County.txt       --wx out/55/c/55091-pepin-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55093-Pierce-County.txt      --wx out/55/c/55093-pierce-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55095-Polk-County.txt        --wx out/55/c/55095-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55097-Portage-County.txt     --wx out/55/c/55097-portage-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55107-Rusk-County.txt        --wx out/55/c/55107-rusk-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55109-St.-Croix-County.txt   --wx out/55/c/55109-st.-croix-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55115-Shawano-County.txt     --wx out/55/c/55115-shawano-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55119-Taylor-County.txt      --wx out/55/c/55119-taylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55121-Trempealeau-County.txt --wx out/55/c/55121-trempealeau-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55135-Waupaca-County.txt     --wx out/55/c/55135-waupaca-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55141-Wood-County.txt        --wx out/55/c/55141-wood-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55001-Adams-County.txt       --wx out/55/s/55001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55015-Calumet-County.txt     --wx out/55/s/55015-calumet-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55021-Columbia-County.txt    --wx out/55/s/55021-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55023-Crawford-County.txt    --wx out/55/s/55023-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55025-Dane-County.txt        --wx out/55/s/55025-dane-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55027-Dodge-County.txt       --wx out/55/s/55027-dodge-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55039-Fond-du-Lac-County.txt --wx out/55/s/55039-fond-du-lac-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55043-Grant-County.txt       --wx out/55/s/55043-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55045-Green-County.txt       --wx out/55/s/55045-green-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55047-Green-Lake-County.txt  --wx out/55/s/55047-green-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55049-Iowa-County.txt        --wx out/55/s/55049-iowa-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55055-Jefferson-County.txt   --wx out/55/s/55055-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55057-Juneau-County.txt      --wx out/55/s/55057-juneau-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55059-Kenosha-County.txt     --wx out/55/s/55059-kenosha-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55063-La-Crosse-County.txt   --wx out/55/s/55063-la-crosse-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55065-Lafayette-County.txt   --wx out/55/s/55065-lafayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55071-Manitowoc-County.txt   --wx out/55/s/55071-manitowoc-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55077-Marquette-County.txt   --wx out/55/s/55077-marquette-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55079-Milwaukee-County.txt   --wx out/55/s/55079-milwaukee-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55081-Monroe-County.txt      --wx out/55/s/55081-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55089-Ozaukee-County.txt     --wx out/55/s/55089-ozaukee-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55101-Racine-County.txt      --wx out/55/s/55101-racine-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55103-Richland-County.txt    --wx out/55/s/55103-richland-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55105-Rock-County.txt        --wx out/55/s/55105-rock-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55111-Sauk-County.txt        --wx out/55/s/55111-sauk-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55117-Sheboygan-County.txt   --wx out/55/s/55117-sheboygan-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55123-Vernon-County.txt      --wx out/55/s/55123-vernon-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55127-Walworth-County.txt    --wx out/55/s/55127-walworth-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55131-Washington-County.txt  --wx out/55/s/55131-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55133-Waukesha-County.txt    --wx out/55/s/55133-waukesha-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55137-Waushara-County.txt    --wx out/55/s/55137-waushara-county.osm.bz2 \
    --bp completeWays=yes file=polys/55/55139-Winnebago-County.txt   --wx out/55/s/55139-winnebago-county.osm.bz2 \

touch -r tmp/wisconsin.osm.pbf out/55/*/*.osm.???

./skeletron-roads.sh tmp/wisconsin-roads.osm.pbf out/55 wisconsin WI
./skeletron-routes.sh tmp/wisconsin-routes.osm.bz2 out/55 wisconsin WI
