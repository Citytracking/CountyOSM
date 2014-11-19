#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/51/n out/51/s

curl -Rs -o tmp/virginia.osm.pbf -L http://download.geofabrik.de/north-america/us/virginia-latest.osm.pbf

osmosis --rb tmp/virginia.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/virginia-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/virginia-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/virginia-routes-B.osm.pbf \
            --tf accept-relations "network=US:VA" --used-way --used-node --wb omitmetadata=true tmp/virginia-routes-C.osm.pbf \
            --tf accept-relations "network=US:VA:CR" --used-way --used-node --wb omitmetadata=true tmp/virginia-routes-D.osm.pbf \

osmosis \
    --rb tmp/virginia-routes-A.osm.pbf \
    --rb tmp/virginia-routes-B.osm.pbf \
    --rb tmp/virginia-routes-C.osm.pbf \
    --rb tmp/virginia-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/virginia-routes.osm.bz2

osmosis \
    --rb tmp/virginia-roads.osm.pbf \
    --tee outputCount=134 \
    --bp completeWays=yes file=polys/51/51013-Arlington-County.txt      --wx out/51/n/51013-arlington-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51015-Augusta-County.txt        --wx out/51/n/51015-augusta-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51017-Bath-County.txt           --wx out/51/n/51017-bath-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51033-Caroline-County.txt       --wx out/51/n/51033-caroline-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51043-Clarke-County.txt         --wx out/51/n/51043-clarke-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51047-Culpeper-County.txt       --wx out/51/n/51047-culpeper-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51059-Fairfax-County.txt        --wx out/51/n/51059-fairfax-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51061-Fauquier-County.txt       --wx out/51/n/51061-fauquier-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51069-Frederick-County.txt      --wx out/51/n/51069-frederick-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51079-Greene-County.txt         --wx out/51/n/51079-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51091-Highland-County.txt       --wx out/51/n/51091-highland-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51099-King-George-County.txt    --wx out/51/n/51099-king-george-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51107-Loudoun-County.txt        --wx out/51/n/51107-loudoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51113-Madison-County.txt        --wx out/51/n/51113-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51137-Orange-County.txt         --wx out/51/n/51137-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51139-Page-County.txt           --wx out/51/n/51139-page-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51153-Prince-William-County.txt --wx out/51/n/51153-prince-william-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51157-Rappahannock-County.txt   --wx out/51/n/51157-rappahannock-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51165-Rockingham-County.txt     --wx out/51/n/51165-rockingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51171-Shenandoah-County.txt     --wx out/51/n/51171-shenandoah-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51177-Spotsylvania-County.txt   --wx out/51/n/51177-spotsylvania-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51179-Stafford-County.txt       --wx out/51/n/51179-stafford-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51187-Warren-County.txt         --wx out/51/n/51187-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51193-Westmoreland-County.txt   --wx out/51/n/51193-westmoreland-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51510-Alexandria-city.txt       --wx out/51/n/51510-alexandria-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51600-Fairfax-city.txt          --wx out/51/n/51600-fairfax-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51610-Falls-Church-city.txt     --wx out/51/n/51610-falls-church-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51630-Fredericksburg-city.txt   --wx out/51/n/51630-fredericksburg-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51660-Harrisonburg-city.txt     --wx out/51/n/51660-harrisonburg-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51683-Manassas-city.txt         --wx out/51/n/51683-manassas-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51685-Manassas-Park-city.txt    --wx out/51/n/51685-manassas-park-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51790-Staunton-city.txt         --wx out/51/n/51790-staunton-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51820-Waynesboro-city.txt       --wx out/51/n/51820-waynesboro-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51840-Winchester-city.txt       --wx out/51/n/51840-winchester-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51001-Accomack-County.txt       --wx out/51/s/51001-accomack-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51003-Albemarle-County.txt      --wx out/51/s/51003-albemarle-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51005-Alleghany-County.txt      --wx out/51/s/51005-alleghany-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51007-Amelia-County.txt         --wx out/51/s/51007-amelia-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51009-Amherst-County.txt        --wx out/51/s/51009-amherst-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51011-Appomattox-County.txt     --wx out/51/s/51011-appomattox-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51019-Bedford-County.txt        --wx out/51/s/51019-bedford-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51021-Bland-County.txt          --wx out/51/s/51021-bland-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51023-Botetourt-County.txt      --wx out/51/s/51023-botetourt-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51025-Brunswick-County.txt      --wx out/51/s/51025-brunswick-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51027-Buchanan-County.txt       --wx out/51/s/51027-buchanan-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51029-Buckingham-County.txt     --wx out/51/s/51029-buckingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51031-Campbell-County.txt       --wx out/51/s/51031-campbell-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51035-Carroll-County.txt        --wx out/51/s/51035-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51036-Charles-City-County.txt   --wx out/51/s/51036-charles-city-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51037-Charlotte-County.txt      --wx out/51/s/51037-charlotte-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51041-Chesterfield-County.txt   --wx out/51/s/51041-chesterfield-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51045-Craig-County.txt          --wx out/51/s/51045-craig-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51049-Cumberland-County.txt     --wx out/51/s/51049-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51051-Dickenson-County.txt      --wx out/51/s/51051-dickenson-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51053-Dinwiddie-County.txt      --wx out/51/s/51053-dinwiddie-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51057-Essex-County.txt          --wx out/51/s/51057-essex-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51063-Floyd-County.txt          --wx out/51/s/51063-floyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51065-Fluvanna-County.txt       --wx out/51/s/51065-fluvanna-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51067-Franklin-County.txt       --wx out/51/s/51067-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51071-Giles-County.txt          --wx out/51/s/51071-giles-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51073-Gloucester-County.txt     --wx out/51/s/51073-gloucester-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51075-Goochland-County.txt      --wx out/51/s/51075-goochland-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51077-Grayson-County.txt        --wx out/51/s/51077-grayson-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51081-Greensville-County.txt    --wx out/51/s/51081-greensville-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51083-Halifax-County.txt        --wx out/51/s/51083-halifax-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51085-Hanover-County.txt        --wx out/51/s/51085-hanover-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51087-Henrico-County.txt        --wx out/51/s/51087-henrico-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51089-Henry-County.txt          --wx out/51/s/51089-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51093-Isle-of-Wight-County.txt  --wx out/51/s/51093-isle-of-wight-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51095-James-City-County.txt     --wx out/51/s/51095-james-city-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51097-King-and-Queen-County.txt --wx out/51/s/51097-king-and-queen-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51101-King-William-County.txt   --wx out/51/s/51101-king-william-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51103-Lancaster-County.txt      --wx out/51/s/51103-lancaster-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51105-Lee-County.txt            --wx out/51/s/51105-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51109-Louisa-County.txt         --wx out/51/s/51109-louisa-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51111-Lunenburg-County.txt      --wx out/51/s/51111-lunenburg-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51115-Mathews-County.txt        --wx out/51/s/51115-mathews-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51117-Mecklenburg-County.txt    --wx out/51/s/51117-mecklenburg-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51119-Middlesex-County.txt      --wx out/51/s/51119-middlesex-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51121-Montgomery-County.txt     --wx out/51/s/51121-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51125-Nelson-County.txt         --wx out/51/s/51125-nelson-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51127-New-Kent-County.txt       --wx out/51/s/51127-new-kent-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51131-Northampton-County.txt    --wx out/51/s/51131-northampton-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51133-Northumberland-County.txt --wx out/51/s/51133-northumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51135-Nottoway-County.txt       --wx out/51/s/51135-nottoway-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51141-Patrick-County.txt        --wx out/51/s/51141-patrick-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51143-Pittsylvania-County.txt   --wx out/51/s/51143-pittsylvania-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51145-Powhatan-County.txt       --wx out/51/s/51145-powhatan-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51147-Prince-Edward-County.txt  --wx out/51/s/51147-prince-edward-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51149-Prince-George-County.txt  --wx out/51/s/51149-prince-george-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51155-Pulaski-County.txt        --wx out/51/s/51155-pulaski-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51159-Richmond-County.txt       --wx out/51/s/51159-richmond-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51161-Roanoke-County.txt        --wx out/51/s/51161-roanoke-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51163-Rockbridge-County.txt     --wx out/51/s/51163-rockbridge-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51167-Russell-County.txt        --wx out/51/s/51167-russell-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51169-Scott-County.txt          --wx out/51/s/51169-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51173-Smyth-County.txt          --wx out/51/s/51173-smyth-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51175-Southampton-County.txt    --wx out/51/s/51175-southampton-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51181-Surry-County.txt          --wx out/51/s/51181-surry-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51183-Sussex-County.txt         --wx out/51/s/51183-sussex-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51185-Tazewell-County.txt       --wx out/51/s/51185-tazewell-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51191-Washington-County.txt     --wx out/51/s/51191-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51195-Wise-County.txt           --wx out/51/s/51195-wise-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51197-Wythe-County.txt          --wx out/51/s/51197-wythe-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51199-York-County.txt           --wx out/51/s/51199-york-county.osm.bz2 \
    --bp completeWays=yes file=polys/51/51515-Bedford-city.txt          --wx out/51/s/51515-bedford-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51520-Bristol-city.txt          --wx out/51/s/51520-bristol-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51530-Buena-Vista-city.txt      --wx out/51/s/51530-buena-vista-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51540-Charlottesville-city.txt  --wx out/51/s/51540-charlottesville-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51550-Chesapeake-city.txt       --wx out/51/s/51550-chesapeake-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51570-Colonial-Heights-city.txt --wx out/51/s/51570-colonial-heights-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51580-Covington-city.txt        --wx out/51/s/51580-covington-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51590-Danville-city.txt         --wx out/51/s/51590-danville-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51595-Emporia-city.txt          --wx out/51/s/51595-emporia-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51620-Franklin-city.txt         --wx out/51/s/51620-franklin-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51640-Galax-city.txt            --wx out/51/s/51640-galax-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51650-Hampton-city.txt          --wx out/51/s/51650-hampton-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51670-Hopewell-city.txt         --wx out/51/s/51670-hopewell-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51678-Lexington-city.txt        --wx out/51/s/51678-lexington-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51680-Lynchburg-city.txt        --wx out/51/s/51680-lynchburg-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51690-Martinsville-city.txt     --wx out/51/s/51690-martinsville-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51700-Newport-News-city.txt     --wx out/51/s/51700-newport-news-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51710-Norfolk-city.txt          --wx out/51/s/51710-norfolk-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51720-Norton-city.txt           --wx out/51/s/51720-norton-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51730-Petersburg-city.txt       --wx out/51/s/51730-petersburg-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51735-Poquoson-city.txt         --wx out/51/s/51735-poquoson-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51740-Portsmouth-city.txt       --wx out/51/s/51740-portsmouth-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51750-Radford-city.txt          --wx out/51/s/51750-radford-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51760-Richmond-city.txt         --wx out/51/s/51760-richmond-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51770-Roanoke-city.txt          --wx out/51/s/51770-roanoke-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51775-Salem-city.txt            --wx out/51/s/51775-salem-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51800-Suffolk-city.txt          --wx out/51/s/51800-suffolk-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51810-Virginia-Beach-city.txt   --wx out/51/s/51810-virginia-beach-city.osm.bz2 \
    --bp completeWays=yes file=polys/51/51830-Williamsburg-city.txt     --wx out/51/s/51830-williamsburg-city.osm.bz2 \

touch -r tmp/virginia.osm.pbf out/51/*/*.osm.???

./skeletron-roads.sh tmp/virginia-roads.osm.pbf out/51 virginia VA
./skeletron-routes.sh tmp/virginia-routes.osm.bz2 out/51 virginia VA
