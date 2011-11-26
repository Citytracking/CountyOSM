#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/42/n out/42/s

curl -Rs -o tmp/pennsylvania.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/pennsylvania.osm.pbf

osmosis --rb tmp/pennsylvania.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/pennsylvania-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/pennsylvania-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/pennsylvania-routes-B.osm.pbf \
            --tf accept-relations "network=US:PA" --used-way --used-node --wb omitmetadata=true tmp/pennsylvania-routes-C.osm.pbf \
            --tf accept-relations "network=US:PA:CR" --used-way --used-node --wb omitmetadata=true tmp/pennsylvania-routes-D.osm.pbf \

osmosis \
    --rb tmp/pennsylvania-routes-A.osm.pbf \
    --rb tmp/pennsylvania-routes-B.osm.pbf \
    --rb tmp/pennsylvania-routes-C.osm.pbf \
    --rb tmp/pennsylvania-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/pennsylvania-routes.osm.bz2

osmosis \
    --rb tmp/pennsylvania-roads.osm.pbf \
    --tee outputCount=67 \
    --bp completeWays=yes file=polys/42/42015-Bradford-County.txt       --wx out/42/n/42015-bradford-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42023-Cameron-County.txt        --wx out/42/n/42023-cameron-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42025-Carbon-County.txt         --wx out/42/n/42025-carbon-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42027-Centre-County.txt         --wx out/42/n/42027-centre-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42031-Clarion-County.txt        --wx out/42/n/42031-clarion-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42033-Clearfield-County.txt     --wx out/42/n/42033-clearfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42035-Clinton-County.txt        --wx out/42/n/42035-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42037-Columbia-County.txt       --wx out/42/n/42037-columbia-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42039-Crawford-County.txt       --wx out/42/n/42039-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42047-Elk-County.txt            --wx out/42/n/42047-elk-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42049-Erie-County.txt           --wx out/42/n/42049-erie-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42053-Forest-County.txt         --wx out/42/n/42053-forest-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42065-Jefferson-County.txt      --wx out/42/n/42065-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42069-Lackawanna-County.txt     --wx out/42/n/42069-lackawanna-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42079-Luzerne-County.txt        --wx out/42/n/42079-luzerne-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42081-Lycoming-County.txt       --wx out/42/n/42081-lycoming-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42083-McKean-County.txt         --wx out/42/n/42083-mckean-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42085-Mercer-County.txt         --wx out/42/n/42085-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42089-Monroe-County.txt         --wx out/42/n/42089-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42093-Montour-County.txt        --wx out/42/n/42093-montour-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42097-Northumberland-County.txt --wx out/42/n/42097-northumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42103-Pike-County.txt           --wx out/42/n/42103-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42105-Potter-County.txt         --wx out/42/n/42105-potter-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42113-Sullivan-County.txt       --wx out/42/n/42113-sullivan-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42115-Susquehanna-County.txt    --wx out/42/n/42115-susquehanna-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42117-Tioga-County.txt          --wx out/42/n/42117-tioga-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42119-Union-County.txt          --wx out/42/n/42119-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42121-Venango-County.txt        --wx out/42/n/42121-venango-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42123-Warren-County.txt         --wx out/42/n/42123-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42127-Wayne-County.txt          --wx out/42/n/42127-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42131-Wyoming-County.txt        --wx out/42/n/42131-wyoming-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42001-Adams-County.txt          --wx out/42/s/42001-adams-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42003-Allegheny-County.txt      --wx out/42/s/42003-allegheny-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42005-Armstrong-County.txt      --wx out/42/s/42005-armstrong-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42007-Beaver-County.txt         --wx out/42/s/42007-beaver-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42009-Bedford-County.txt        --wx out/42/s/42009-bedford-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42011-Berks-County.txt          --wx out/42/s/42011-berks-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42013-Blair-County.txt          --wx out/42/s/42013-blair-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42017-Bucks-County.txt          --wx out/42/s/42017-bucks-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42019-Butler-County.txt         --wx out/42/s/42019-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42021-Cambria-County.txt        --wx out/42/s/42021-cambria-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42029-Chester-County.txt        --wx out/42/s/42029-chester-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42041-Cumberland-County.txt     --wx out/42/s/42041-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42043-Dauphin-County.txt        --wx out/42/s/42043-dauphin-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42045-Delaware-County.txt       --wx out/42/s/42045-delaware-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42051-Fayette-County.txt        --wx out/42/s/42051-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42055-Franklin-County.txt       --wx out/42/s/42055-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42057-Fulton-County.txt         --wx out/42/s/42057-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42059-Greene-County.txt         --wx out/42/s/42059-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42061-Huntingdon-County.txt     --wx out/42/s/42061-huntingdon-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42063-Indiana-County.txt        --wx out/42/s/42063-indiana-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42067-Juniata-County.txt        --wx out/42/s/42067-juniata-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42071-Lancaster-County.txt      --wx out/42/s/42071-lancaster-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42073-Lawrence-County.txt       --wx out/42/s/42073-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42075-Lebanon-County.txt        --wx out/42/s/42075-lebanon-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42077-Lehigh-County.txt         --wx out/42/s/42077-lehigh-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42087-Mifflin-County.txt        --wx out/42/s/42087-mifflin-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42091-Montgomery-County.txt     --wx out/42/s/42091-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42095-Northampton-County.txt    --wx out/42/s/42095-northampton-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42099-Perry-County.txt          --wx out/42/s/42099-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42101-Philadelphia-County.txt   --wx out/42/s/42101-philadelphia-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42107-Schuylkill-County.txt     --wx out/42/s/42107-schuylkill-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42109-Snyder-County.txt         --wx out/42/s/42109-snyder-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42111-Somerset-County.txt       --wx out/42/s/42111-somerset-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42125-Washington-County.txt     --wx out/42/s/42125-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42129-Westmoreland-County.txt   --wx out/42/s/42129-westmoreland-county.osm.bz2 \
    --bp completeWays=yes file=polys/42/42133-York-County.txt           --wx out/42/s/42133-york-county.osm.bz2 \

touch -r tmp/pennsylvania.osm.pbf out/42/*.osm.???

./skeletron-roads.sh tmp/pennsylvania-roads.osm.pbf out/42 pennsylvania
./skeletron-routes.sh tmp/pennsylvania-routes.osm.bz2 out/42 pennsylvania

touch -r tmp/pennsylvania.osm.pbf out/42/*.pgsql
