#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/21/n out/21/s

curl -Rs -o tmp/kentucky.osm.pbf -L http://download.geofabrik.de/north-america/us/kentucky-latest.osm.pbf

osmosis --rb tmp/kentucky.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/kentucky-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/kentucky-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/kentucky-routes-B.osm.pbf \
            --tf accept-relations "network=US:KY" --used-way --used-node --wb omitmetadata=true tmp/kentucky-routes-C.osm.pbf \
            --tf accept-relations "network=US:KY:CR" --used-way --used-node --wb omitmetadata=true tmp/kentucky-routes-D.osm.pbf \

osmosis \
    --rb tmp/kentucky-routes-A.osm.pbf \
    --rb tmp/kentucky-routes-B.osm.pbf \
    --rb tmp/kentucky-routes-C.osm.pbf \
    --rb tmp/kentucky-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/kentucky-routes.osm.bz2

osmosis \
    --rb tmp/kentucky-roads.osm.pbf \
    --tee outputCount=120 \
    --bp completeWays=yes file=polys/21/21005-Anderson-County.txt     --wx out/21/n/21005-anderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21011-Bath-County.txt         --wx out/21/n/21011-bath-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21015-Boone-County.txt        --wx out/21/n/21015-boone-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21017-Bourbon-County.txt      --wx out/21/n/21017-bourbon-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21019-Boyd-County.txt         --wx out/21/n/21019-boyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21023-Bracken-County.txt      --wx out/21/n/21023-bracken-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21029-Bullitt-County.txt      --wx out/21/n/21029-bullitt-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21037-Campbell-County.txt     --wx out/21/n/21037-campbell-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21041-Carroll-County.txt      --wx out/21/n/21041-carroll-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21043-Carter-County.txt       --wx out/21/n/21043-carter-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21049-Clark-County.txt        --wx out/21/n/21049-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21063-Elliott-County.txt      --wx out/21/n/21063-elliott-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21067-Fayette-County.txt      --wx out/21/n/21067-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21069-Fleming-County.txt      --wx out/21/n/21069-fleming-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21073-Franklin-County.txt     --wx out/21/n/21073-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21077-Gallatin-County.txt     --wx out/21/n/21077-gallatin-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21081-Grant-County.txt        --wx out/21/n/21081-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21089-Greenup-County.txt      --wx out/21/n/21089-greenup-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21097-Harrison-County.txt     --wx out/21/n/21097-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21103-Henry-County.txt        --wx out/21/n/21103-henry-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21111-Jefferson-County.txt    --wx out/21/n/21111-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21113-Jessamine-County.txt    --wx out/21/n/21113-jessamine-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21117-Kenton-County.txt       --wx out/21/n/21117-kenton-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21127-Lawrence-County.txt     --wx out/21/n/21127-lawrence-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21135-Lewis-County.txt        --wx out/21/n/21135-lewis-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21161-Mason-County.txt        --wx out/21/n/21161-mason-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21165-Menifee-County.txt      --wx out/21/n/21165-menifee-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21173-Montgomery-County.txt   --wx out/21/n/21173-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21175-Morgan-County.txt       --wx out/21/n/21175-morgan-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21181-Nicholas-County.txt     --wx out/21/n/21181-nicholas-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21185-Oldham-County.txt       --wx out/21/n/21185-oldham-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21187-Owen-County.txt         --wx out/21/n/21187-owen-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21191-Pendleton-County.txt    --wx out/21/n/21191-pendleton-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21201-Robertson-County.txt    --wx out/21/n/21201-robertson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21205-Rowan-County.txt        --wx out/21/n/21205-rowan-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21209-Scott-County.txt        --wx out/21/n/21209-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21211-Shelby-County.txt       --wx out/21/n/21211-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21215-Spencer-County.txt      --wx out/21/n/21215-spencer-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21223-Trimble-County.txt      --wx out/21/n/21223-trimble-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21239-Woodford-County.txt     --wx out/21/n/21239-woodford-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21001-Adair-County.txt        --wx out/21/s/21001-adair-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21003-Allen-County.txt        --wx out/21/s/21003-allen-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21007-Ballard-County.txt      --wx out/21/s/21007-ballard-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21009-Barren-County.txt       --wx out/21/s/21009-barren-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21013-Bell-County.txt         --wx out/21/s/21013-bell-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21021-Boyle-County.txt        --wx out/21/s/21021-boyle-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21025-Breathitt-County.txt    --wx out/21/s/21025-breathitt-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21027-Breckinridge-County.txt --wx out/21/s/21027-breckinridge-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21031-Butler-County.txt       --wx out/21/s/21031-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21033-Caldwell-County.txt     --wx out/21/s/21033-caldwell-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21035-Calloway-County.txt     --wx out/21/s/21035-calloway-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21039-Carlisle-County.txt     --wx out/21/s/21039-carlisle-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21045-Casey-County.txt        --wx out/21/s/21045-casey-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21047-Christian-County.txt    --wx out/21/s/21047-christian-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21051-Clay-County.txt         --wx out/21/s/21051-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21053-Clinton-County.txt      --wx out/21/s/21053-clinton-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21055-Crittenden-County.txt   --wx out/21/s/21055-crittenden-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21057-Cumberland-County.txt   --wx out/21/s/21057-cumberland-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21059-Daviess-County.txt      --wx out/21/s/21059-daviess-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21061-Edmonson-County.txt     --wx out/21/s/21061-edmonson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21065-Estill-County.txt       --wx out/21/s/21065-estill-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21071-Floyd-County.txt        --wx out/21/s/21071-floyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21075-Fulton-County.txt       --wx out/21/s/21075-fulton-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21079-Garrard-County.txt      --wx out/21/s/21079-garrard-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21083-Graves-County.txt       --wx out/21/s/21083-graves-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21085-Grayson-County.txt      --wx out/21/s/21085-grayson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21087-Green-County.txt        --wx out/21/s/21087-green-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21091-Hancock-County.txt      --wx out/21/s/21091-hancock-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21093-Hardin-County.txt       --wx out/21/s/21093-hardin-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21095-Harlan-County.txt       --wx out/21/s/21095-harlan-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21099-Hart-County.txt         --wx out/21/s/21099-hart-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21101-Henderson-County.txt    --wx out/21/s/21101-henderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21105-Hickman-County.txt      --wx out/21/s/21105-hickman-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21107-Hopkins-County.txt      --wx out/21/s/21107-hopkins-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21109-Jackson-County.txt      --wx out/21/s/21109-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21115-Johnson-County.txt      --wx out/21/s/21115-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21119-Knott-County.txt        --wx out/21/s/21119-knott-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21121-Knox-County.txt         --wx out/21/s/21121-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21123-Larue-County.txt        --wx out/21/s/21123-larue-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21125-Laurel-County.txt       --wx out/21/s/21125-laurel-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21129-Lee-County.txt          --wx out/21/s/21129-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21131-Leslie-County.txt       --wx out/21/s/21131-leslie-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21133-Letcher-County.txt      --wx out/21/s/21133-letcher-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21137-Lincoln-County.txt      --wx out/21/s/21137-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21139-Livingston-County.txt   --wx out/21/s/21139-livingston-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21141-Logan-County.txt        --wx out/21/s/21141-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21143-Lyon-County.txt         --wx out/21/s/21143-lyon-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21145-McCracken-County.txt    --wx out/21/s/21145-mccracken-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21147-McCreary-County.txt     --wx out/21/s/21147-mccreary-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21149-McLean-County.txt       --wx out/21/s/21149-mclean-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21151-Madison-County.txt      --wx out/21/s/21151-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21153-Magoffin-County.txt     --wx out/21/s/21153-magoffin-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21155-Marion-County.txt       --wx out/21/s/21155-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21157-Marshall-County.txt     --wx out/21/s/21157-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21159-Martin-County.txt       --wx out/21/s/21159-martin-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21163-Meade-County.txt        --wx out/21/s/21163-meade-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21167-Mercer-County.txt       --wx out/21/s/21167-mercer-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21169-Metcalfe-County.txt     --wx out/21/s/21169-metcalfe-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21171-Monroe-County.txt       --wx out/21/s/21171-monroe-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21177-Muhlenberg-County.txt   --wx out/21/s/21177-muhlenberg-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21179-Nelson-County.txt       --wx out/21/s/21179-nelson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21183-Ohio-County.txt         --wx out/21/s/21183-ohio-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21189-Owsley-County.txt       --wx out/21/s/21189-owsley-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21193-Perry-County.txt        --wx out/21/s/21193-perry-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21195-Pike-County.txt         --wx out/21/s/21195-pike-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21197-Powell-County.txt       --wx out/21/s/21197-powell-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21199-Pulaski-County.txt      --wx out/21/s/21199-pulaski-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21203-Rockcastle-County.txt   --wx out/21/s/21203-rockcastle-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21207-Russell-County.txt      --wx out/21/s/21207-russell-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21213-Simpson-County.txt      --wx out/21/s/21213-simpson-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21217-Taylor-County.txt       --wx out/21/s/21217-taylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21219-Todd-County.txt         --wx out/21/s/21219-todd-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21221-Trigg-County.txt        --wx out/21/s/21221-trigg-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21225-Union-County.txt        --wx out/21/s/21225-union-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21227-Warren-County.txt       --wx out/21/s/21227-warren-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21229-Washington-County.txt   --wx out/21/s/21229-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21231-Wayne-County.txt        --wx out/21/s/21231-wayne-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21233-Webster-County.txt      --wx out/21/s/21233-webster-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21235-Whitley-County.txt      --wx out/21/s/21235-whitley-county.osm.bz2 \
    --bp completeWays=yes file=polys/21/21237-Wolfe-County.txt        --wx out/21/s/21237-wolfe-county.osm.bz2 \

touch -r tmp/kentucky.osm.pbf out/21/*/*.osm.???

./skeletron-roads.sh tmp/kentucky-roads.osm.pbf out/21 kentucky KY
./skeletron-routes.sh tmp/kentucky-routes.osm.bz2 out/21 kentucky KY
