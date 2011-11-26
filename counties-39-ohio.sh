#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/39/n out/39/s

curl -Rs -o tmp/ohio.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/ohio.osm.pbf

osmosis --rb tmp/ohio.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/ohio-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/ohio-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/ohio-routes-B.osm.pbf \
            --tf accept-relations "network=US:OH" --used-way --used-node --wb omitmetadata=true tmp/ohio-routes-C.osm.pbf \
            --tf accept-relations "network=US:OH:CR" --used-way --used-node --wb omitmetadata=true tmp/ohio-routes-D.osm.pbf \

osmosis \
    --rb tmp/ohio-routes-A.osm.pbf \
    --rb tmp/ohio-routes-B.osm.pbf \
    --rb tmp/ohio-routes-C.osm.pbf \
    --rb tmp/ohio-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/ohio-routes.osm.bz2

osmosis \
    --rb tmp/ohio-roads.osm.pbf \
    --tee outputCount=88 \
    --bp completeWays=yes file=polys/39/39003-Allen-County.txt      --wx out/39/n/39003-allen-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39005-Ashland-County.txt    --wx out/39/n/39005-ashland-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39007-Ashtabula-County.txt  --wx out/39/n/39007-ashtabula-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39011-Auglaize-County.txt   --wx out/39/n/39011-auglaize-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39019-Carroll-County.txt    --wx out/39/n/39019-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39029-Columbiana-County.txt --wx out/39/n/39029-columbiana-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39031-Coshocton-County.txt  --wx out/39/n/39031-coshocton-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39033-Crawford-County.txt   --wx out/39/n/39033-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39035-Cuyahoga-County.txt   --wx out/39/n/39035-cuyahoga-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39039-Defiance-County.txt   --wx out/39/n/39039-defiance-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39041-Delaware-County.txt   --wx out/39/n/39041-delaware-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39043-Erie-County.txt       --wx out/39/n/39043-erie-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39051-Fulton-County.txt     --wx out/39/n/39051-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39055-Geauga-County.txt     --wx out/39/n/39055-geauga-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39063-Hancock-County.txt    --wx out/39/n/39063-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39065-Hardin-County.txt     --wx out/39/n/39065-hardin-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39067-Harrison-County.txt   --wx out/39/n/39067-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39069-Henry-County.txt      --wx out/39/n/39069-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39075-Holmes-County.txt     --wx out/39/n/39075-holmes-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39077-Huron-County.txt      --wx out/39/n/39077-huron-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39081-Jefferson-County.txt  --wx out/39/n/39081-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39083-Knox-County.txt       --wx out/39/n/39083-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39085-Lake-County.txt       --wx out/39/n/39085-lake-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39091-Logan-County.txt      --wx out/39/n/39091-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39093-Lorain-County.txt     --wx out/39/n/39093-lorain-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39095-Lucas-County.txt      --wx out/39/n/39095-lucas-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39099-Mahoning-County.txt   --wx out/39/n/39099-mahoning-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39101-Marion-County.txt     --wx out/39/n/39101-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39103-Medina-County.txt     --wx out/39/n/39103-medina-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39107-Mercer-County.txt     --wx out/39/n/39107-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39117-Morrow-County.txt     --wx out/39/n/39117-morrow-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39123-Ottawa-County.txt     --wx out/39/n/39123-ottawa-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39125-Paulding-County.txt   --wx out/39/n/39125-paulding-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39133-Portage-County.txt    --wx out/39/n/39133-portage-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39137-Putnam-County.txt     --wx out/39/n/39137-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39139-Richland-County.txt   --wx out/39/n/39139-richland-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39143-Sandusky-County.txt   --wx out/39/n/39143-sandusky-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39147-Seneca-County.txt     --wx out/39/n/39147-seneca-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39149-Shelby-County.txt     --wx out/39/n/39149-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39151-Stark-County.txt      --wx out/39/n/39151-stark-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39153-Summit-County.txt     --wx out/39/n/39153-summit-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39155-Trumbull-County.txt   --wx out/39/n/39155-trumbull-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39157-Tuscarawas-County.txt --wx out/39/n/39157-tuscarawas-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39159-Union-County.txt      --wx out/39/n/39159-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39161-Van-Wert-County.txt   --wx out/39/n/39161-van-wert-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39169-Wayne-County.txt      --wx out/39/n/39169-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39171-Williams-County.txt   --wx out/39/n/39171-williams-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39173-Wood-County.txt       --wx out/39/n/39173-wood-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39175-Wyandot-County.txt    --wx out/39/n/39175-wyandot-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39001-Adams-County.txt      --wx out/39/s/39001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39009-Athens-County.txt     --wx out/39/s/39009-athens-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39013-Belmont-County.txt    --wx out/39/s/39013-belmont-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39015-Brown-County.txt      --wx out/39/s/39015-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39017-Butler-County.txt     --wx out/39/s/39017-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39021-Champaign-County.txt  --wx out/39/s/39021-champaign-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39023-Clark-County.txt      --wx out/39/s/39023-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39025-Clermont-County.txt   --wx out/39/s/39025-clermont-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39027-Clinton-County.txt    --wx out/39/s/39027-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39037-Darke-County.txt      --wx out/39/s/39037-darke-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39045-Fairfield-County.txt  --wx out/39/s/39045-fairfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39047-Fayette-County.txt    --wx out/39/s/39047-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39049-Franklin-County.txt   --wx out/39/s/39049-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39053-Gallia-County.txt     --wx out/39/s/39053-gallia-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39057-Greene-County.txt     --wx out/39/s/39057-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39059-Guernsey-County.txt   --wx out/39/s/39059-guernsey-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39061-Hamilton-County.txt   --wx out/39/s/39061-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39071-Highland-County.txt   --wx out/39/s/39071-highland-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39073-Hocking-County.txt    --wx out/39/s/39073-hocking-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39079-Jackson-County.txt    --wx out/39/s/39079-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39087-Lawrence-County.txt   --wx out/39/s/39087-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39089-Licking-County.txt    --wx out/39/s/39089-licking-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39097-Madison-County.txt    --wx out/39/s/39097-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39105-Meigs-County.txt      --wx out/39/s/39105-meigs-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39109-Miami-County.txt      --wx out/39/s/39109-miami-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39111-Monroe-County.txt     --wx out/39/s/39111-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39113-Montgomery-County.txt --wx out/39/s/39113-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39115-Morgan-County.txt     --wx out/39/s/39115-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39119-Muskingum-County.txt  --wx out/39/s/39119-muskingum-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39121-Noble-County.txt      --wx out/39/s/39121-noble-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39127-Perry-County.txt      --wx out/39/s/39127-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39129-Pickaway-County.txt   --wx out/39/s/39129-pickaway-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39131-Pike-County.txt       --wx out/39/s/39131-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39135-Preble-County.txt     --wx out/39/s/39135-preble-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39141-Ross-County.txt       --wx out/39/s/39141-ross-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39145-Scioto-County.txt     --wx out/39/s/39145-scioto-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39163-Vinton-County.txt     --wx out/39/s/39163-vinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39165-Warren-County.txt     --wx out/39/s/39165-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/39/39167-Washington-County.txt --wx out/39/s/39167-washington-county.osm.bz2 \

touch -r tmp/ohio.osm.pbf out/39/*/*.osm.???

./skeletron-roads.sh tmp/ohio-roads.osm.pbf out/39 ohio
./skeletron-routes.sh tmp/ohio-routes.osm.bz2 out/39 ohio

touch -r tmp/ohio.osm.pbf out/39/*.pgsql
