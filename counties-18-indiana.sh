#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/18/w out/18/e

curl -s -o tmp/indiana.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/indiana.osm.pbf

osmosis --rb tmp/indiana.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/indiana-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/indiana-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/indiana-routes-B.osm.pbf \
            --tf accept-relations "network=US:IN" --used-way --used-node --wb omitmetadata=true tmp/indiana-routes-C.osm.pbf \
            --tf accept-relations "network=US:IN:CR" --used-way --used-node --wb omitmetadata=true tmp/indiana-routes-D.osm.pbf \

osmosis \
    --rb tmp/indiana-routes-A.osm.pbf \
    --rb tmp/indiana-routes-B.osm.pbf \
    --rb tmp/indiana-routes-C.osm.pbf \
    --rb tmp/indiana-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/indiana-routes.osm.bz2

osmosis \
    --rb tmp/indiana-roads.osm.pbf \
    --tee outputCount=92 \
    --bp completeWays=yes file=polys/18/18007-Benton-County.txt      --wx out/18/w/18007-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18011-Boone-County.txt       --wx out/18/w/18011-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18015-Carroll-County.txt     --wx out/18/w/18015-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18021-Clay-County.txt        --wx out/18/w/18021-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18023-Clinton-County.txt     --wx out/18/w/18023-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18025-Crawford-County.txt    --wx out/18/w/18025-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18027-Daviess-County.txt     --wx out/18/w/18027-daviess-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18037-Dubois-County.txt      --wx out/18/w/18037-dubois-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18045-Fountain-County.txt    --wx out/18/w/18045-fountain-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18051-Gibson-County.txt      --wx out/18/w/18051-gibson-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18055-Greene-County.txt      --wx out/18/w/18055-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18063-Hendricks-County.txt   --wx out/18/w/18063-hendricks-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18071-Jackson-County.txt     --wx out/18/w/18071-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18083-Knox-County.txt        --wx out/18/w/18083-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18091-LaPorte-County.txt     --wx out/18/w/18091-laporte-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18089-Lake-County.txt        --wx out/18/w/18089-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18093-Lawrence-County.txt    --wx out/18/w/18093-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18101-Martin-County.txt      --wx out/18/w/18101-martin-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18105-Monroe-County.txt      --wx out/18/w/18105-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18107-Montgomery-County.txt  --wx out/18/w/18107-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18109-Morgan-County.txt      --wx out/18/w/18109-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18111-Newton-County.txt      --wx out/18/w/18111-newton-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18117-Orange-County.txt      --wx out/18/w/18117-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18119-Owen-County.txt        --wx out/18/w/18119-owen-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18121-Parke-County.txt       --wx out/18/w/18121-parke-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18123-Perry-County.txt       --wx out/18/w/18123-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18125-Pike-County.txt        --wx out/18/w/18125-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18127-Porter-County.txt      --wx out/18/w/18127-porter-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18129-Posey-County.txt       --wx out/18/w/18129-posey-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18131-Pulaski-County.txt     --wx out/18/w/18131-pulaski-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18133-Putnam-County.txt      --wx out/18/w/18133-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18147-Spencer-County.txt     --wx out/18/w/18147-spencer-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18149-Starke-County.txt      --wx out/18/w/18149-starke-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18153-Sullivan-County.txt    --wx out/18/w/18153-sullivan-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18157-Tippecanoe-County.txt  --wx out/18/w/18157-tippecanoe-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18163-Vanderburgh-County.txt --wx out/18/w/18163-vanderburgh-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18165-Vermillion-County.txt  --wx out/18/w/18165-vermillion-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18167-Vigo-County.txt        --wx out/18/w/18167-vigo-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18171-Warren-County.txt      --wx out/18/w/18171-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18173-Warrick-County.txt     --wx out/18/w/18173-warrick-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18181-White-County.txt       --wx out/18/w/18181-white-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18001-Adams-County.txt       --wx out/18/e/18001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18003-Allen-County.txt       --wx out/18/e/18003-allen-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18005-Bartholomew-County.txt --wx out/18/e/18005-bartholomew-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18009-Blackford-County.txt   --wx out/18/e/18009-blackford-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18013-Brown-County.txt       --wx out/18/e/18013-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18017-Cass-County.txt        --wx out/18/e/18017-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18019-Clark-County.txt       --wx out/18/e/18019-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18029-Dearborn-County.txt    --wx out/18/e/18029-dearborn-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18031-Decatur-County.txt     --wx out/18/e/18031-decatur-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18033-DeKalb-County.txt      --wx out/18/e/18033-dekalb-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18035-Delaware-County.txt    --wx out/18/e/18035-delaware-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18039-Elkhart-County.txt     --wx out/18/e/18039-elkhart-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18041-Fayette-County.txt     --wx out/18/e/18041-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18043-Floyd-County.txt       --wx out/18/e/18043-floyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18047-Franklin-County.txt    --wx out/18/e/18047-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18049-Fulton-County.txt      --wx out/18/e/18049-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18053-Grant-County.txt       --wx out/18/e/18053-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18057-Hamilton-County.txt    --wx out/18/e/18057-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18059-Hancock-County.txt     --wx out/18/e/18059-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18061-Harrison-County.txt    --wx out/18/e/18061-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18065-Henry-County.txt       --wx out/18/e/18065-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18067-Howard-County.txt      --wx out/18/e/18067-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18069-Huntington-County.txt  --wx out/18/e/18069-huntington-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18073-Jasper-County.txt      --wx out/18/e/18073-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18075-Jay-County.txt         --wx out/18/e/18075-jay-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18077-Jefferson-County.txt   --wx out/18/e/18077-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18079-Jennings-County.txt    --wx out/18/e/18079-jennings-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18081-Johnson-County.txt     --wx out/18/e/18081-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18085-Kosciusko-County.txt   --wx out/18/e/18085-kosciusko-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18087-LaGrange-County.txt    --wx out/18/e/18087-lagrange-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18095-Madison-County.txt     --wx out/18/e/18095-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18097-Marion-County.txt      --wx out/18/e/18097-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18099-Marshall-County.txt    --wx out/18/e/18099-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18103-Miami-County.txt       --wx out/18/e/18103-miami-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18113-Noble-County.txt       --wx out/18/e/18113-noble-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18115-Ohio-County.txt        --wx out/18/e/18115-ohio-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18135-Randolph-County.txt    --wx out/18/e/18135-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18137-Ripley-County.txt      --wx out/18/e/18137-ripley-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18139-Rush-County.txt        --wx out/18/e/18139-rush-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18141-St.-Joseph-County.txt  --wx out/18/e/18141-st.-joseph-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18143-Scott-County.txt       --wx out/18/e/18143-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18145-Shelby-County.txt      --wx out/18/e/18145-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18151-Steuben-County.txt     --wx out/18/e/18151-steuben-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18155-Switzerland-County.txt --wx out/18/e/18155-switzerland-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18159-Tipton-County.txt      --wx out/18/e/18159-tipton-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18161-Union-County.txt       --wx out/18/e/18161-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18169-Wabash-County.txt      --wx out/18/e/18169-wabash-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18175-Washington-County.txt  --wx out/18/e/18175-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18177-Wayne-County.txt       --wx out/18/e/18177-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18179-Wells-County.txt       --wx out/18/e/18179-wells-county.osm.bz2 \
    --bp completeWays=yes file=polys/18/18183-Whitley-County.txt     --wx out/18/e/18183-whitley-county.osm.bz2 \

./skeletron-roads.sh tmp/indiana-roads.osm.pbf out/18 indiana
./skeletron-routes.sh tmp/indiana-routes.osm.bz2 out/18 indiana
