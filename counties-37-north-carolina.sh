#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/37

curl -Rs -o tmp/north-carolina.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/north-carolina.osm.pbf

osmosis --rb tmp/north-carolina.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/north-carolina-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/north-carolina-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/north-carolina-routes-B.osm.pbf \
            --tf accept-relations "network=US:NC" --used-way --used-node --wb omitmetadata=true tmp/north-carolina-routes-C.osm.pbf \
            --tf accept-relations "network=US:NC:CR" --used-way --used-node --wb omitmetadata=true tmp/north-carolina-routes-D.osm.pbf \

osmosis \
    --rb tmp/north-carolina-routes-A.osm.pbf \
    --rb tmp/north-carolina-routes-B.osm.pbf \
    --rb tmp/north-carolina-routes-C.osm.pbf \
    --rb tmp/north-carolina-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/north-carolina-routes.osm.bz2

osmosis \
    --rb tmp/north-carolina-roads.osm.pbf \
    --tee outputCount=100 \
    --bp completeWays=yes file=polys/37/37001-Alamance-County.txt     --wx out/37/37001-alamance-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37003-Alexander-County.txt    --wx out/37/37003-alexander-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37005-Alleghany-County.txt    --wx out/37/37005-alleghany-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37007-Anson-County.txt        --wx out/37/37007-anson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37009-Ashe-County.txt         --wx out/37/37009-ashe-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37011-Avery-County.txt        --wx out/37/37011-avery-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37013-Beaufort-County.txt     --wx out/37/37013-beaufort-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37015-Bertie-County.txt       --wx out/37/37015-bertie-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37017-Bladen-County.txt       --wx out/37/37017-bladen-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37019-Brunswick-County.txt    --wx out/37/37019-brunswick-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37021-Buncombe-County.txt     --wx out/37/37021-buncombe-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37023-Burke-County.txt        --wx out/37/37023-burke-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37025-Cabarrus-County.txt     --wx out/37/37025-cabarrus-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37027-Caldwell-County.txt     --wx out/37/37027-caldwell-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37029-Camden-County.txt       --wx out/37/37029-camden-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37031-Carteret-County.txt     --wx out/37/37031-carteret-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37033-Caswell-County.txt      --wx out/37/37033-caswell-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37035-Catawba-County.txt      --wx out/37/37035-catawba-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37037-Chatham-County.txt      --wx out/37/37037-chatham-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37039-Cherokee-County.txt     --wx out/37/37039-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37041-Chowan-County.txt       --wx out/37/37041-chowan-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37043-Clay-County.txt         --wx out/37/37043-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37045-Cleveland-County.txt    --wx out/37/37045-cleveland-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37047-Columbus-County.txt     --wx out/37/37047-columbus-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37049-Craven-County.txt       --wx out/37/37049-craven-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37051-Cumberland-County.txt   --wx out/37/37051-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37053-Currituck-County.txt    --wx out/37/37053-currituck-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37055-Dare-County.txt         --wx out/37/37055-dare-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37057-Davidson-County.txt     --wx out/37/37057-davidson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37059-Davie-County.txt        --wx out/37/37059-davie-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37061-Duplin-County.txt       --wx out/37/37061-duplin-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37063-Durham-County.txt       --wx out/37/37063-durham-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37065-Edgecombe-County.txt    --wx out/37/37065-edgecombe-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37067-Forsyth-County.txt      --wx out/37/37067-forsyth-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37069-Franklin-County.txt     --wx out/37/37069-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37071-Gaston-County.txt       --wx out/37/37071-gaston-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37073-Gates-County.txt        --wx out/37/37073-gates-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37075-Graham-County.txt       --wx out/37/37075-graham-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37077-Granville-County.txt    --wx out/37/37077-granville-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37079-Greene-County.txt       --wx out/37/37079-greene-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37081-Guilford-County.txt     --wx out/37/37081-guilford-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37083-Halifax-County.txt      --wx out/37/37083-halifax-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37085-Harnett-County.txt      --wx out/37/37085-harnett-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37087-Haywood-County.txt      --wx out/37/37087-haywood-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37089-Henderson-County.txt    --wx out/37/37089-henderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37091-Hertford-County.txt     --wx out/37/37091-hertford-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37093-Hoke-County.txt         --wx out/37/37093-hoke-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37095-Hyde-County.txt         --wx out/37/37095-hyde-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37097-Iredell-County.txt      --wx out/37/37097-iredell-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37099-Jackson-County.txt      --wx out/37/37099-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37101-Johnston-County.txt     --wx out/37/37101-johnston-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37103-Jones-County.txt        --wx out/37/37103-jones-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37105-Lee-County.txt          --wx out/37/37105-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37107-Lenoir-County.txt       --wx out/37/37107-lenoir-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37109-Lincoln-County.txt      --wx out/37/37109-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37111-McDowell-County.txt     --wx out/37/37111-mcdowell-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37113-Macon-County.txt        --wx out/37/37113-macon-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37115-Madison-County.txt      --wx out/37/37115-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37117-Martin-County.txt       --wx out/37/37117-martin-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37119-Mecklenburg-County.txt  --wx out/37/37119-mecklenburg-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37121-Mitchell-County.txt     --wx out/37/37121-mitchell-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37123-Montgomery-County.txt   --wx out/37/37123-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37125-Moore-County.txt        --wx out/37/37125-moore-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37127-Nash-County.txt         --wx out/37/37127-nash-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37129-New-Hanover-County.txt  --wx out/37/37129-new-hanover-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37131-Northampton-County.txt  --wx out/37/37131-northampton-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37133-Onslow-County.txt       --wx out/37/37133-onslow-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37135-Orange-County.txt       --wx out/37/37135-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37137-Pamlico-County.txt      --wx out/37/37137-pamlico-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37139-Pasquotank-County.txt   --wx out/37/37139-pasquotank-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37141-Pender-County.txt       --wx out/37/37141-pender-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37143-Perquimans-County.txt   --wx out/37/37143-perquimans-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37145-Person-County.txt       --wx out/37/37145-person-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37147-Pitt-County.txt         --wx out/37/37147-pitt-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37149-Polk-County.txt         --wx out/37/37149-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37151-Randolph-County.txt     --wx out/37/37151-randolph-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37153-Richmond-County.txt     --wx out/37/37153-richmond-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37155-Robeson-County.txt      --wx out/37/37155-robeson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37157-Rockingham-County.txt   --wx out/37/37157-rockingham-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37159-Rowan-County.txt        --wx out/37/37159-rowan-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37161-Rutherford-County.txt   --wx out/37/37161-rutherford-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37163-Sampson-County.txt      --wx out/37/37163-sampson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37165-Scotland-County.txt     --wx out/37/37165-scotland-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37167-Stanly-County.txt       --wx out/37/37167-stanly-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37169-Stokes-County.txt       --wx out/37/37169-stokes-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37171-Surry-County.txt        --wx out/37/37171-surry-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37173-Swain-County.txt        --wx out/37/37173-swain-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37175-Transylvania-County.txt --wx out/37/37175-transylvania-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37177-Tyrrell-County.txt      --wx out/37/37177-tyrrell-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37179-Union-County.txt        --wx out/37/37179-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37181-Vance-County.txt        --wx out/37/37181-vance-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37183-Wake-County.txt         --wx out/37/37183-wake-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37185-Warren-County.txt       --wx out/37/37185-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37187-Washington-County.txt   --wx out/37/37187-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37189-Watauga-County.txt      --wx out/37/37189-watauga-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37191-Wayne-County.txt        --wx out/37/37191-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37193-Wilkes-County.txt       --wx out/37/37193-wilkes-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37195-Wilson-County.txt       --wx out/37/37195-wilson-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37197-Yadkin-County.txt       --wx out/37/37197-yadkin-county.osm.bz2 \
    --bp completeWays=yes file=polys/37/37199-Yancey-County.txt       --wx out/37/37199-yancey-county.osm.bz2 \

touch -r tmp/north-carolina.osm.pbf out/37/*.osm.???

./skeletron-roads.sh tmp/north-carolina-roads.osm.pbf out/37 north-carolina
./skeletron-routes.sh tmp/north-carolina-routes.osm.bz2 out/37 north-carolina

touch -r tmp/north-carolina.osm.pbf out/37/*.pgsql
