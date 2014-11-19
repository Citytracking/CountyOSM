#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/38/n out/38/s

curl -Rs -o tmp/north-dakota.osm.pbf -L http://download.geofabrik.de/north-america/us/north-dakota-latest.osm.pbf

osmosis --rb tmp/north-dakota.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/north-dakota-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/north-dakota-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/north-dakota-routes-B.osm.pbf \
            --tf accept-relations "network=US:ND" --used-way --used-node --wb omitmetadata=true tmp/north-dakota-routes-C.osm.pbf \
            --tf accept-relations "network=US:ND:CR" --used-way --used-node --wb omitmetadata=true tmp/north-dakota-routes-D.osm.pbf \

osmosis \
    --rb tmp/north-dakota-routes-A.osm.pbf \
    --rb tmp/north-dakota-routes-B.osm.pbf \
    --rb tmp/north-dakota-routes-C.osm.pbf \
    --rb tmp/north-dakota-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/north-dakota-routes.osm.bz2

osmosis \
    --rb tmp/north-dakota-roads.osm.pbf \
    --tee outputCount=53 \
    --bp completeWays=yes file=polys/38/38005-Benson-County.txt        --wx out/38/n/38005-benson-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38009-Bottineau-County.txt     --wx out/38/n/38009-bottineau-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38013-Burke-County.txt         --wx out/38/n/38013-burke-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38019-Cavalier-County.txt      --wx out/38/n/38019-cavalier-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38023-Divide-County.txt        --wx out/38/n/38023-divide-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38027-Eddy-County.txt          --wx out/38/n/38027-eddy-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38031-Foster-County.txt        --wx out/38/n/38031-foster-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38035-Grand-Forks-County.txt   --wx out/38/n/38035-grand-forks-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38039-Griggs-County.txt        --wx out/38/n/38039-griggs-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38049-McHenry-County.txt       --wx out/38/n/38049-mchenry-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38053-McKenzie-County.txt      --wx out/38/n/38053-mckenzie-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38055-McLean-County.txt        --wx out/38/n/38055-mclean-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38061-Mountrail-County.txt     --wx out/38/n/38061-mountrail-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38063-Nelson-County.txt        --wx out/38/n/38063-nelson-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38067-Pembina-County.txt       --wx out/38/n/38067-pembina-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38069-Pierce-County.txt        --wx out/38/n/38069-pierce-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38071-Ramsey-County.txt        --wx out/38/n/38071-ramsey-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38075-Renville-County.txt      --wx out/38/n/38075-renville-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38079-Rolette-County.txt       --wx out/38/n/38079-rolette-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38083-Sheridan-County.txt      --wx out/38/n/38083-sheridan-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38091-Steele-County.txt        --wx out/38/n/38091-steele-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38095-Towner-County.txt        --wx out/38/n/38095-towner-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38097-Traill-County.txt        --wx out/38/n/38097-traill-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38099-Walsh-County.txt         --wx out/38/n/38099-walsh-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38101-Ward-County.txt          --wx out/38/n/38101-ward-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38103-Wells-County.txt         --wx out/38/n/38103-wells-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38105-Williams-County.txt      --wx out/38/n/38105-williams-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38001-Adams-County.txt         --wx out/38/s/38001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38003-Barnes-County.txt        --wx out/38/s/38003-barnes-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38007-Billings-County.txt      --wx out/38/s/38007-billings-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38011-Bowman-County.txt        --wx out/38/s/38011-bowman-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38015-Burleigh-County.txt      --wx out/38/s/38015-burleigh-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38017-Cass-County.txt          --wx out/38/s/38017-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38021-Dickey-County.txt        --wx out/38/s/38021-dickey-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38025-Dunn-County.txt          --wx out/38/s/38025-dunn-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38029-Emmons-County.txt        --wx out/38/s/38029-emmons-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38033-Golden-Valley-County.txt --wx out/38/s/38033-golden-valley-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38037-Grant-County.txt         --wx out/38/s/38037-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38041-Hettinger-County.txt     --wx out/38/s/38041-hettinger-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38043-Kidder-County.txt        --wx out/38/s/38043-kidder-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38045-LaMoure-County.txt       --wx out/38/s/38045-lamoure-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38047-Logan-County.txt         --wx out/38/s/38047-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38051-McIntosh-County.txt      --wx out/38/s/38051-mcintosh-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38057-Mercer-County.txt        --wx out/38/s/38057-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38059-Morton-County.txt        --wx out/38/s/38059-morton-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38065-Oliver-County.txt        --wx out/38/s/38065-oliver-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38073-Ransom-County.txt        --wx out/38/s/38073-ransom-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38077-Richland-County.txt      --wx out/38/s/38077-richland-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38081-Sargent-County.txt       --wx out/38/s/38081-sargent-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38085-Sioux-County.txt         --wx out/38/s/38085-sioux-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38087-Slope-County.txt         --wx out/38/s/38087-slope-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38089-Stark-County.txt         --wx out/38/s/38089-stark-county.osm.bz2 \
    --bp completeWays=yes file=polys/38/38093-Stutsman-County.txt      --wx out/38/s/38093-stutsman-county.osm.bz2 \

touch -r tmp/north-dakota.osm.pbf out/38/*/*.osm.???

./skeletron-roads.sh tmp/north-dakota-roads.osm.pbf out/38 north-dakota ND
./skeletron-routes.sh tmp/north-dakota-routes.osm.bz2 out/38 north-dakota ND
