#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/28/w out/28/e

curl -Rs -o tmp/mississippi.osm.pbf -L http://download.geofabrik.de/north-america/us/mississippi-latest.osm.pbf

osmosis --rb tmp/mississippi.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/mississippi-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/mississippi-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/mississippi-routes-B.osm.pbf \
            --tf accept-relations "network=US:MS" --used-way --used-node --wb omitmetadata=true tmp/mississippi-routes-C.osm.pbf \
            --tf accept-relations "network=US:MS:CR" --used-way --used-node --wb omitmetadata=true tmp/mississippi-routes-D.osm.pbf \

osmosis \
    --rb tmp/mississippi-routes-A.osm.pbf \
    --rb tmp/mississippi-routes-B.osm.pbf \
    --rb tmp/mississippi-routes-C.osm.pbf \
    --rb tmp/mississippi-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/mississippi-routes.osm.bz2

osmosis \
    --rb tmp/mississippi-roads.osm.pbf \
    --tee outputCount=82 \
    --bp completeWays=yes file=polys/28/28001-Adams-County.txt           --wx out/28/w/28001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28005-Amite-County.txt           --wx out/28/w/28005-amite-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28011-Bolivar-County.txt         --wx out/28/w/28011-bolivar-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28015-Carroll-County.txt         --wx out/28/w/28015-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28021-Claiborne-County.txt       --wx out/28/w/28021-claiborne-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28027-Coahoma-County.txt         --wx out/28/w/28027-coahoma-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28029-Copiah-County.txt          --wx out/28/w/28029-copiah-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28033-DeSoto-County.txt          --wx out/28/w/28033-desoto-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28037-Franklin-County.txt        --wx out/28/w/28037-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28043-Grenada-County.txt         --wx out/28/w/28043-grenada-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28049-Hinds-County.txt           --wx out/28/w/28049-hinds-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28051-Holmes-County.txt          --wx out/28/w/28051-holmes-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28053-Humphreys-County.txt       --wx out/28/w/28053-humphreys-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28055-Issaquena-County.txt       --wx out/28/w/28055-issaquena-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28063-Jefferson-County.txt       --wx out/28/w/28063-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28065-Jefferson-Davis-County.txt --wx out/28/w/28065-jefferson-davis-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28077-Lawrence-County.txt        --wx out/28/w/28077-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28083-Leflore-County.txt         --wx out/28/w/28083-leflore-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28085-Lincoln-County.txt         --wx out/28/w/28085-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28089-Madison-County.txt         --wx out/28/w/28089-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28091-Marion-County.txt          --wx out/28/w/28091-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28097-Montgomery-County.txt      --wx out/28/w/28097-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28107-Panola-County.txt          --wx out/28/w/28107-panola-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28113-Pike-County.txt            --wx out/28/w/28113-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28119-Quitman-County.txt         --wx out/28/w/28119-quitman-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28121-Rankin-County.txt          --wx out/28/w/28121-rankin-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28125-Sharkey-County.txt         --wx out/28/w/28125-sharkey-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28127-Simpson-County.txt         --wx out/28/w/28127-simpson-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28133-Sunflower-County.txt       --wx out/28/w/28133-sunflower-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28135-Tallahatchie-County.txt    --wx out/28/w/28135-tallahatchie-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28137-Tate-County.txt            --wx out/28/w/28137-tate-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28143-Tunica-County.txt          --wx out/28/w/28143-tunica-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28147-Walthall-County.txt        --wx out/28/w/28147-walthall-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28149-Warren-County.txt          --wx out/28/w/28149-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28151-Washington-County.txt      --wx out/28/w/28151-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28157-Wilkinson-County.txt       --wx out/28/w/28157-wilkinson-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28161-Yalobusha-County.txt       --wx out/28/w/28161-yalobusha-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28163-Yazoo-County.txt           --wx out/28/w/28163-yazoo-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28003-Alcorn-County.txt          --wx out/28/e/28003-alcorn-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28007-Attala-County.txt          --wx out/28/e/28007-attala-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28009-Benton-County.txt          --wx out/28/e/28009-benton-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28013-Calhoun-County.txt         --wx out/28/e/28013-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28017-Chickasaw-County.txt       --wx out/28/e/28017-chickasaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28019-Choctaw-County.txt         --wx out/28/e/28019-choctaw-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28023-Clarke-County.txt          --wx out/28/e/28023-clarke-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28025-Clay-County.txt            --wx out/28/e/28025-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28031-Covington-County.txt       --wx out/28/e/28031-covington-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28035-Forrest-County.txt         --wx out/28/e/28035-forrest-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28039-George-County.txt          --wx out/28/e/28039-george-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28041-Greene-County.txt          --wx out/28/e/28041-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28045-Hancock-County.txt         --wx out/28/e/28045-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28047-Harrison-County.txt        --wx out/28/e/28047-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28057-Itawamba-County.txt        --wx out/28/e/28057-itawamba-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28059-Jackson-County.txt         --wx out/28/e/28059-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28061-Jasper-County.txt          --wx out/28/e/28061-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28067-Jones-County.txt           --wx out/28/e/28067-jones-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28069-Kemper-County.txt          --wx out/28/e/28069-kemper-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28071-Lafayette-County.txt       --wx out/28/e/28071-lafayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28073-Lamar-County.txt           --wx out/28/e/28073-lamar-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28075-Lauderdale-County.txt      --wx out/28/e/28075-lauderdale-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28079-Leake-County.txt           --wx out/28/e/28079-leake-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28081-Lee-County.txt             --wx out/28/e/28081-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28087-Lowndes-County.txt         --wx out/28/e/28087-lowndes-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28093-Marshall-County.txt        --wx out/28/e/28093-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28095-Monroe-County.txt          --wx out/28/e/28095-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28099-Neshoba-County.txt         --wx out/28/e/28099-neshoba-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28101-Newton-County.txt          --wx out/28/e/28101-newton-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28103-Noxubee-County.txt         --wx out/28/e/28103-noxubee-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28105-Oktibbeha-County.txt       --wx out/28/e/28105-oktibbeha-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28109-Pearl-River-County.txt     --wx out/28/e/28109-pearl-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28111-Perry-County.txt           --wx out/28/e/28111-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28115-Pontotoc-County.txt        --wx out/28/e/28115-pontotoc-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28117-Prentiss-County.txt        --wx out/28/e/28117-prentiss-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28123-Scott-County.txt           --wx out/28/e/28123-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28129-Smith-County.txt           --wx out/28/e/28129-smith-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28131-Stone-County.txt           --wx out/28/e/28131-stone-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28139-Tippah-County.txt          --wx out/28/e/28139-tippah-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28141-Tishomingo-County.txt      --wx out/28/e/28141-tishomingo-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28145-Union-County.txt           --wx out/28/e/28145-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28153-Wayne-County.txt           --wx out/28/e/28153-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28155-Webster-County.txt         --wx out/28/e/28155-webster-county.osm.bz2 \
    --bp completeWays=yes file=polys/28/28159-Winston-County.txt         --wx out/28/e/28159-winston-county.osm.bz2 \

touch -r tmp/mississippi.osm.pbf out/28/*/*.osm.???

./skeletron-roads.sh tmp/mississippi-roads.osm.pbf out/28 mississippi MS
./skeletron-routes.sh tmp/mississippi-routes.osm.bz2 out/28 mississippi MS
