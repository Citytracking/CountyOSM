#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/54/n out/54/s

curl -s -o tmp/west-virginia.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/west-virginia.osm.pbf

osmosis --rb tmp/west-virginia.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/west-virginia-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/west-virginia-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/west-virginia-routes-B.osm.pbf \
            --tf accept-relations "network=US:WV" --used-way --used-node --wb omitmetadata=true tmp/west-virginia-routes-C.osm.pbf \
            --tf accept-relations "network=US:WV:CR" --used-way --used-node --wb omitmetadata=true tmp/west-virginia-routes-D.osm.pbf \

osmosis \
    --rb tmp/west-virginia-routes-A.osm.pbf \
    --rb tmp/west-virginia-routes-B.osm.pbf \
    --rb tmp/west-virginia-routes-C.osm.pbf \
    --rb tmp/west-virginia-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/west-virginia-routes.osm.bz2

osmosis \
    --rb tmp/west-virginia-roads.osm.pbf \
    --tee outputCount=55 \
    --bp completeWays=yes file=polys/54/54001-Barbour-County.txt    --wx out/54/n/54001-barbour-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54003-Berkeley-County.txt   --wx out/54/n/54003-berkeley-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54009-Brooke-County.txt     --wx out/54/n/54009-brooke-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54017-Doddridge-County.txt  --wx out/54/n/54017-doddridge-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54023-Grant-County.txt      --wx out/54/n/54023-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54027-Hampshire-County.txt  --wx out/54/n/54027-hampshire-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54029-Hancock-County.txt    --wx out/54/n/54029-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54031-Hardy-County.txt      --wx out/54/n/54031-hardy-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54033-Harrison-County.txt   --wx out/54/n/54033-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54037-Jefferson-County.txt  --wx out/54/n/54037-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54049-Marion-County.txt     --wx out/54/n/54049-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54051-Marshall-County.txt   --wx out/54/n/54051-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54057-Mineral-County.txt    --wx out/54/n/54057-mineral-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54061-Monongalia-County.txt --wx out/54/n/54061-monongalia-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54065-Morgan-County.txt     --wx out/54/n/54065-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54069-Ohio-County.txt       --wx out/54/n/54069-ohio-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54073-Pleasants-County.txt  --wx out/54/n/54073-pleasants-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54077-Preston-County.txt    --wx out/54/n/54077-preston-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54085-Ritchie-County.txt    --wx out/54/n/54085-ritchie-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54091-Taylor-County.txt     --wx out/54/n/54091-taylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54093-Tucker-County.txt     --wx out/54/n/54093-tucker-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54095-Tyler-County.txt      --wx out/54/n/54095-tyler-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54103-Wetzel-County.txt     --wx out/54/n/54103-wetzel-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54105-Wirt-County.txt       --wx out/54/n/54105-wirt-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54107-Wood-County.txt       --wx out/54/n/54107-wood-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54005-Boone-County.txt      --wx out/54/s/54005-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54007-Braxton-County.txt    --wx out/54/s/54007-braxton-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54011-Cabell-County.txt     --wx out/54/s/54011-cabell-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54013-Calhoun-County.txt    --wx out/54/s/54013-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54015-Clay-County.txt       --wx out/54/s/54015-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54019-Fayette-County.txt    --wx out/54/s/54019-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54021-Gilmer-County.txt     --wx out/54/s/54021-gilmer-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54025-Greenbrier-County.txt --wx out/54/s/54025-greenbrier-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54035-Jackson-County.txt    --wx out/54/s/54035-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54039-Kanawha-County.txt    --wx out/54/s/54039-kanawha-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54041-Lewis-County.txt      --wx out/54/s/54041-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54043-Lincoln-County.txt    --wx out/54/s/54043-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54045-Logan-County.txt      --wx out/54/s/54045-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54047-McDowell-County.txt   --wx out/54/s/54047-mcdowell-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54053-Mason-County.txt      --wx out/54/s/54053-mason-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54055-Mercer-County.txt     --wx out/54/s/54055-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54059-Mingo-County.txt      --wx out/54/s/54059-mingo-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54063-Monroe-County.txt     --wx out/54/s/54063-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54067-Nicholas-County.txt   --wx out/54/s/54067-nicholas-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54071-Pendleton-County.txt  --wx out/54/s/54071-pendleton-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54075-Pocahontas-County.txt --wx out/54/s/54075-pocahontas-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54079-Putnam-County.txt     --wx out/54/s/54079-putnam-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54081-Raleigh-County.txt    --wx out/54/s/54081-raleigh-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54083-Randolph-County.txt   --wx out/54/s/54083-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54087-Roane-County.txt      --wx out/54/s/54087-roane-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54089-Summers-County.txt    --wx out/54/s/54089-summers-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54097-Upshur-County.txt     --wx out/54/s/54097-upshur-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54099-Wayne-County.txt      --wx out/54/s/54099-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54101-Webster-County.txt    --wx out/54/s/54101-webster-county.osm.bz2 \
    --bp completeWays=yes file=polys/54/54109-Wyoming-County.txt    --wx out/54/s/54109-wyoming-county.osm.bz2 \

./skeletron-roads.sh tmp/west-virginia-roads.osm.pbf out/54 west-virginia
./skeletron-routes.sh tmp/west-virginia-routes.osm.bz2 out/54 west-virginia
