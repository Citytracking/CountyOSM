#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/20/n out/20/s

curl -Rs -o tmp/kansas.osm.pbf -L http://download.geofabrik.de/osm/north-america/us/kansas.osm.pbf

osmosis --rb tmp/kansas.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/kansas-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/kansas-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/kansas-routes-B.osm.pbf \
            --tf accept-relations "network=US:KS" --used-way --used-node --wb omitmetadata=true tmp/kansas-routes-C.osm.pbf \
            --tf accept-relations "network=US:KS:CR" --used-way --used-node --wb omitmetadata=true tmp/kansas-routes-D.osm.pbf \

osmosis \
    --rb tmp/kansas-routes-A.osm.pbf \
    --rb tmp/kansas-routes-B.osm.pbf \
    --rb tmp/kansas-routes-C.osm.pbf \
    --rb tmp/kansas-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/kansas-routes.osm.bz2

osmosis \
    --rb tmp/kansas-roads.osm.pbf \
    --tee outputCount=105 \
    --bp completeWays=yes file=polys/20/20005-Atchison-County.txt     --wx out/20/n/20005-atchison-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20013-Brown-County.txt        --wx out/20/n/20013-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20023-Cheyenne-County.txt     --wx out/20/n/20023-cheyenne-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20027-Clay-County.txt         --wx out/20/n/20027-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20029-Cloud-County.txt        --wx out/20/n/20029-cloud-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20039-Decatur-County.txt      --wx out/20/n/20039-decatur-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20041-Dickinson-County.txt    --wx out/20/n/20041-dickinson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20043-Doniphan-County.txt     --wx out/20/n/20043-doniphan-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20045-Douglas-County.txt      --wx out/20/n/20045-douglas-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20051-Ellis-County.txt        --wx out/20/n/20051-ellis-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20053-Ellsworth-County.txt    --wx out/20/n/20053-ellsworth-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20061-Geary-County.txt        --wx out/20/n/20061-geary-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20063-Gove-County.txt         --wx out/20/n/20063-gove-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20065-Graham-County.txt       --wx out/20/n/20065-graham-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20085-Jackson-County.txt      --wx out/20/n/20085-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20087-Jefferson-County.txt    --wx out/20/n/20087-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20089-Jewell-County.txt       --wx out/20/n/20089-jewell-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20091-Johnson-County.txt      --wx out/20/n/20091-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20103-Leavenworth-County.txt  --wx out/20/n/20103-leavenworth-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20105-Lincoln-County.txt      --wx out/20/n/20105-lincoln-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20109-Logan-County.txt        --wx out/20/n/20109-logan-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20117-Marshall-County.txt     --wx out/20/n/20117-marshall-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20123-Mitchell-County.txt     --wx out/20/n/20123-mitchell-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20127-Morris-County.txt       --wx out/20/n/20127-morris-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20131-Nemaha-County.txt       --wx out/20/n/20131-nemaha-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20137-Norton-County.txt       --wx out/20/n/20137-norton-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20141-Osborne-County.txt      --wx out/20/n/20141-osborne-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20143-Ottawa-County.txt       --wx out/20/n/20143-ottawa-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20147-Phillips-County.txt     --wx out/20/n/20147-phillips-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20149-Pottawatomie-County.txt --wx out/20/n/20149-pottawatomie-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20153-Rawlins-County.txt      --wx out/20/n/20153-rawlins-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20157-Republic-County.txt     --wx out/20/n/20157-republic-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20161-Riley-County.txt        --wx out/20/n/20161-riley-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20163-Rooks-County.txt        --wx out/20/n/20163-rooks-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20167-Russell-County.txt      --wx out/20/n/20167-russell-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20169-Saline-County.txt       --wx out/20/n/20169-saline-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20177-Shawnee-County.txt      --wx out/20/n/20177-shawnee-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20179-Sheridan-County.txt     --wx out/20/n/20179-sheridan-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20181-Sherman-County.txt      --wx out/20/n/20181-sherman-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20183-Smith-County.txt        --wx out/20/n/20183-smith-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20193-Thomas-County.txt       --wx out/20/n/20193-thomas-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20195-Trego-County.txt        --wx out/20/n/20195-trego-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20197-Wabaunsee-County.txt    --wx out/20/n/20197-wabaunsee-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20199-Wallace-County.txt      --wx out/20/n/20199-wallace-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20201-Washington-County.txt   --wx out/20/n/20201-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20209-Wyandotte-County.txt    --wx out/20/n/20209-wyandotte-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20001-Allen-County.txt        --wx out/20/s/20001-allen-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20003-Anderson-County.txt     --wx out/20/s/20003-anderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20007-Barber-County.txt       --wx out/20/s/20007-barber-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20009-Barton-County.txt       --wx out/20/s/20009-barton-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20011-Bourbon-County.txt      --wx out/20/s/20011-bourbon-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20015-Butler-County.txt       --wx out/20/s/20015-butler-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20017-Chase-County.txt        --wx out/20/s/20017-chase-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20019-Chautauqua-County.txt   --wx out/20/s/20019-chautauqua-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20021-Cherokee-County.txt     --wx out/20/s/20021-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20025-Clark-County.txt        --wx out/20/s/20025-clark-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20031-Coffey-County.txt       --wx out/20/s/20031-coffey-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20033-Comanche-County.txt     --wx out/20/s/20033-comanche-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20035-Cowley-County.txt       --wx out/20/s/20035-cowley-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20037-Crawford-County.txt     --wx out/20/s/20037-crawford-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20047-Edwards-County.txt      --wx out/20/s/20047-edwards-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20049-Elk-County.txt          --wx out/20/s/20049-elk-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20055-Finney-County.txt       --wx out/20/s/20055-finney-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20057-Ford-County.txt         --wx out/20/s/20057-ford-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20059-Franklin-County.txt     --wx out/20/s/20059-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20067-Grant-County.txt        --wx out/20/s/20067-grant-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20069-Gray-County.txt         --wx out/20/s/20069-gray-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20071-Greeley-County.txt      --wx out/20/s/20071-greeley-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20073-Greenwood-County.txt    --wx out/20/s/20073-greenwood-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20075-Hamilton-County.txt     --wx out/20/s/20075-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20077-Harper-County.txt       --wx out/20/s/20077-harper-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20079-Harvey-County.txt       --wx out/20/s/20079-harvey-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20081-Haskell-County.txt      --wx out/20/s/20081-haskell-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20083-Hodgeman-County.txt     --wx out/20/s/20083-hodgeman-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20093-Kearny-County.txt       --wx out/20/s/20093-kearny-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20095-Kingman-County.txt      --wx out/20/s/20095-kingman-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20097-Kiowa-County.txt        --wx out/20/s/20097-kiowa-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20099-Labette-County.txt      --wx out/20/s/20099-labette-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20101-Lane-County.txt         --wx out/20/s/20101-lane-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20107-Linn-County.txt         --wx out/20/s/20107-linn-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20111-Lyon-County.txt         --wx out/20/s/20111-lyon-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20113-McPherson-County.txt    --wx out/20/s/20113-mcpherson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20115-Marion-County.txt       --wx out/20/s/20115-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20119-Meade-County.txt        --wx out/20/s/20119-meade-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20121-Miami-County.txt        --wx out/20/s/20121-miami-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20125-Montgomery-County.txt   --wx out/20/s/20125-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20129-Morton-County.txt       --wx out/20/s/20129-morton-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20133-Neosho-County.txt       --wx out/20/s/20133-neosho-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20135-Ness-County.txt         --wx out/20/s/20135-ness-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20139-Osage-County.txt        --wx out/20/s/20139-osage-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20145-Pawnee-County.txt       --wx out/20/s/20145-pawnee-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20151-Pratt-County.txt        --wx out/20/s/20151-pratt-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20155-Reno-County.txt         --wx out/20/s/20155-reno-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20159-Rice-County.txt         --wx out/20/s/20159-rice-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20165-Rush-County.txt         --wx out/20/s/20165-rush-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20171-Scott-County.txt        --wx out/20/s/20171-scott-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20173-Sedgwick-County.txt     --wx out/20/s/20173-sedgwick-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20175-Seward-County.txt       --wx out/20/s/20175-seward-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20185-Stafford-County.txt     --wx out/20/s/20185-stafford-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20187-Stanton-County.txt      --wx out/20/s/20187-stanton-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20189-Stevens-County.txt      --wx out/20/s/20189-stevens-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20191-Sumner-County.txt       --wx out/20/s/20191-sumner-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20203-Wichita-County.txt      --wx out/20/s/20203-wichita-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20205-Wilson-County.txt       --wx out/20/s/20205-wilson-county.osm.bz2 \
    --bp completeWays=yes file=polys/20/20207-Woodson-County.txt      --wx out/20/s/20207-woodson-county.osm.bz2 \

touch -r tmp/kansas.osm.pbf out/20/*/*.osm.???

./skeletron-roads.sh tmp/kansas-roads.osm.pbf out/20 kansas KS
./skeletron-routes.sh tmp/kansas-routes.osm.bz2 out/20 kansas KS
