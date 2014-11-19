#!/bin/sh -ex

mkdir -p tmp
mkdir -p out/48/n out/48/nc out/48/c out/48/sc out/48/s

curl -Rs -o tmp/texas.osm.pbf -L http://download.geofabrik.de/north-america/us/texas-latest.osm.pbf

osmosis --rb tmp/texas.osm.pbf \
    --tf accept-ways "highway=motorway,motorway_link,trunk,trunk_link,primary,primary_link,secondary,secondary_link,tertiary,tertiary_link,residential,unclassified,road,service,minor,footpath,track,footway,steps,pedestrian,path,cycleway" \
    --used-node --tee outputCount=2 \
        --tf reject-relations --wb tmp/texas-roads.osm.pbf \
        --tf accept-relations "network=*" --used-way --used-node \
        --tee outputCount=4 \
            --tf accept-relations "network=US:I" --used-way --used-node --wb omitmetadata=true tmp/texas-routes-A.osm.pbf \
            --tf accept-relations "network=US:US" --used-way --used-node --wb omitmetadata=true tmp/texas-routes-B.osm.pbf \
            --tf accept-relations "network=US:TX" --used-way --used-node --wb omitmetadata=true tmp/texas-routes-C.osm.pbf \
            --tf accept-relations "network=US:TX:CR" --used-way --used-node --wb omitmetadata=true tmp/texas-routes-D.osm.pbf \

osmosis \
    --rb tmp/texas-routes-A.osm.pbf \
    --rb tmp/texas-routes-B.osm.pbf \
    --rb tmp/texas-routes-C.osm.pbf \
    --rb tmp/texas-routes-D.osm.pbf \
    --merge --merge --merge \
    --wx tmp/texas-routes.osm.bz2

osmosis \
    --rb tmp/texas-roads.osm.pbf \
    --tee outputCount=254 \
    --bp completeWays=yes file=polys/48/48011-Armstrong-County.txt     --wx out/48/n/48011-armstrong-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48045-Briscoe-County.txt       --wx out/48/n/48045-briscoe-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48065-Carson-County.txt        --wx out/48/n/48065-carson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48069-Castro-County.txt        --wx out/48/n/48069-castro-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48075-Childress-County.txt     --wx out/48/n/48075-childress-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48087-Collingsworth-County.txt --wx out/48/n/48087-collingsworth-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48111-Dallam-County.txt        --wx out/48/n/48111-dallam-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48117-Deaf-Smith-County.txt    --wx out/48/n/48117-deaf-smith-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48129-Donley-County.txt        --wx out/48/n/48129-donley-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48179-Gray-County.txt          --wx out/48/n/48179-gray-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48191-Hall-County.txt          --wx out/48/n/48191-hall-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48195-Hansford-County.txt      --wx out/48/n/48195-hansford-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48205-Hartley-County.txt       --wx out/48/n/48205-hartley-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48211-Hemphill-County.txt      --wx out/48/n/48211-hemphill-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48233-Hutchinson-County.txt    --wx out/48/n/48233-hutchinson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48295-Lipscomb-County.txt      --wx out/48/n/48295-lipscomb-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48341-Moore-County.txt         --wx out/48/n/48341-moore-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48357-Ochiltree-County.txt     --wx out/48/n/48357-ochiltree-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48359-Oldham-County.txt        --wx out/48/n/48359-oldham-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48369-Parmer-County.txt        --wx out/48/n/48369-parmer-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48375-Potter-County.txt        --wx out/48/n/48375-potter-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48381-Randall-County.txt       --wx out/48/n/48381-randall-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48393-Roberts-County.txt       --wx out/48/n/48393-roberts-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48421-Sherman-County.txt       --wx out/48/n/48421-sherman-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48437-Swisher-County.txt       --wx out/48/n/48437-swisher-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48483-Wheeler-County.txt       --wx out/48/n/48483-wheeler-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48003-Andrews-County.txt       --wx out/48/nc/48003-andrews-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48009-Archer-County.txt        --wx out/48/nc/48009-archer-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48017-Bailey-County.txt        --wx out/48/nc/48017-bailey-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48023-Baylor-County.txt        --wx out/48/nc/48023-baylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48033-Borden-County.txt        --wx out/48/nc/48033-borden-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48037-Bowie-County.txt         --wx out/48/nc/48037-bowie-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48059-Callahan-County.txt      --wx out/48/nc/48059-callahan-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48063-Camp-County.txt          --wx out/48/nc/48063-camp-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48067-Cass-County.txt          --wx out/48/nc/48067-cass-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48077-Clay-County.txt          --wx out/48/nc/48077-clay-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48079-Cochran-County.txt       --wx out/48/nc/48079-cochran-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48085-Collin-County.txt        --wx out/48/nc/48085-collin-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48097-Cooke-County.txt         --wx out/48/nc/48097-cooke-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48101-Cottle-County.txt        --wx out/48/nc/48101-cottle-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48107-Crosby-County.txt        --wx out/48/nc/48107-crosby-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48113-Dallas-County.txt        --wx out/48/nc/48113-dallas-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48115-Dawson-County.txt        --wx out/48/nc/48115-dawson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48119-Delta-County.txt         --wx out/48/nc/48119-delta-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48121-Denton-County.txt        --wx out/48/nc/48121-denton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48125-Dickens-County.txt       --wx out/48/nc/48125-dickens-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48133-Eastland-County.txt      --wx out/48/nc/48133-eastland-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48139-Ellis-County.txt         --wx out/48/nc/48139-ellis-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48143-Erath-County.txt         --wx out/48/nc/48143-erath-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48147-Fannin-County.txt        --wx out/48/nc/48147-fannin-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48151-Fisher-County.txt        --wx out/48/nc/48151-fisher-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48153-Floyd-County.txt         --wx out/48/nc/48153-floyd-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48155-Foard-County.txt         --wx out/48/nc/48155-foard-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48159-Franklin-County.txt      --wx out/48/nc/48159-franklin-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48165-Gaines-County.txt        --wx out/48/nc/48165-gaines-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48169-Garza-County.txt         --wx out/48/nc/48169-garza-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48181-Grayson-County.txt       --wx out/48/nc/48181-grayson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48183-Gregg-County.txt         --wx out/48/nc/48183-gregg-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48189-Hale-County.txt          --wx out/48/nc/48189-hale-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48197-Hardeman-County.txt      --wx out/48/nc/48197-hardeman-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48203-Harrison-County.txt      --wx out/48/nc/48203-harrison-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48207-Haskell-County.txt       --wx out/48/nc/48207-haskell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48213-Henderson-County.txt     --wx out/48/nc/48213-henderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48217-Hill-County.txt          --wx out/48/nc/48217-hill-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48219-Hockley-County.txt       --wx out/48/nc/48219-hockley-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48221-Hood-County.txt          --wx out/48/nc/48221-hood-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48223-Hopkins-County.txt       --wx out/48/nc/48223-hopkins-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48227-Howard-County.txt        --wx out/48/nc/48227-howard-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48231-Hunt-County.txt          --wx out/48/nc/48231-hunt-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48237-Jack-County.txt          --wx out/48/nc/48237-jack-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48251-Johnson-County.txt       --wx out/48/nc/48251-johnson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48253-Jones-County.txt         --wx out/48/nc/48253-jones-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48257-Kaufman-County.txt       --wx out/48/nc/48257-kaufman-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48263-Kent-County.txt          --wx out/48/nc/48263-kent-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48269-King-County.txt          --wx out/48/nc/48269-king-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48275-Knox-County.txt          --wx out/48/nc/48275-knox-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48277-Lamar-County.txt         --wx out/48/nc/48277-lamar-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48279-Lamb-County.txt          --wx out/48/nc/48279-lamb-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48303-Lubbock-County.txt       --wx out/48/nc/48303-lubbock-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48305-Lynn-County.txt          --wx out/48/nc/48305-lynn-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48315-Marion-County.txt        --wx out/48/nc/48315-marion-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48317-Martin-County.txt        --wx out/48/nc/48317-martin-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48335-Mitchell-County.txt      --wx out/48/nc/48335-mitchell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48337-Montague-County.txt      --wx out/48/nc/48337-montague-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48343-Morris-County.txt        --wx out/48/nc/48343-morris-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48345-Motley-County.txt        --wx out/48/nc/48345-motley-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48349-Navarro-County.txt       --wx out/48/nc/48349-navarro-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48353-Nolan-County.txt         --wx out/48/nc/48353-nolan-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48363-Palo-Pinto-County.txt    --wx out/48/nc/48363-palo-pinto-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48365-Panola-County.txt        --wx out/48/nc/48365-panola-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48367-Parker-County.txt        --wx out/48/nc/48367-parker-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48379-Rains-County.txt         --wx out/48/nc/48379-rains-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48387-Red-River-County.txt     --wx out/48/nc/48387-red-river-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48397-Rockwall-County.txt      --wx out/48/nc/48397-rockwall-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48401-Rusk-County.txt          --wx out/48/nc/48401-rusk-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48415-Scurry-County.txt        --wx out/48/nc/48415-scurry-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48417-Shackelford-County.txt   --wx out/48/nc/48417-shackelford-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48423-Smith-County.txt         --wx out/48/nc/48423-smith-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48425-Somervell-County.txt     --wx out/48/nc/48425-somervell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48429-Stephens-County.txt      --wx out/48/nc/48429-stephens-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48433-Stonewall-County.txt     --wx out/48/nc/48433-stonewall-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48439-Tarrant-County.txt       --wx out/48/nc/48439-tarrant-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48441-Taylor-County.txt        --wx out/48/nc/48441-taylor-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48445-Terry-County.txt         --wx out/48/nc/48445-terry-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48447-Throckmorton-County.txt  --wx out/48/nc/48447-throckmorton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48449-Titus-County.txt         --wx out/48/nc/48449-titus-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48459-Upshur-County.txt        --wx out/48/nc/48459-upshur-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48467-Van-Zandt-County.txt     --wx out/48/nc/48467-van-zandt-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48485-Wichita-County.txt       --wx out/48/nc/48485-wichita-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48487-Wilbarger-County.txt     --wx out/48/nc/48487-wilbarger-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48497-Wise-County.txt          --wx out/48/nc/48497-wise-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48499-Wood-County.txt          --wx out/48/nc/48499-wood-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48501-Yoakum-County.txt        --wx out/48/nc/48501-yoakum-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48503-Young-County.txt         --wx out/48/nc/48503-young-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48001-Anderson-County.txt      --wx out/48/c/48001-anderson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48005-Angelina-County.txt      --wx out/48/c/48005-angelina-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48021-Bastrop-County.txt       --wx out/48/c/48021-bastrop-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48027-Bell-County.txt          --wx out/48/c/48027-bell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48031-Blanco-County.txt        --wx out/48/c/48031-blanco-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48035-Bosque-County.txt        --wx out/48/c/48035-bosque-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48041-Brazos-County.txt        --wx out/48/c/48041-brazos-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48049-Brown-County.txt         --wx out/48/c/48049-brown-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48051-Burleson-County.txt      --wx out/48/c/48051-burleson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48053-Burnet-County.txt        --wx out/48/c/48053-burnet-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48073-Cherokee-County.txt      --wx out/48/c/48073-cherokee-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48081-Coke-County.txt          --wx out/48/c/48081-coke-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48083-Coleman-County.txt       --wx out/48/c/48083-coleman-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48093-Comanche-County.txt      --wx out/48/c/48093-comanche-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48095-Concho-County.txt        --wx out/48/c/48095-concho-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48099-Coryell-County.txt       --wx out/48/c/48099-coryell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48103-Crane-County.txt         --wx out/48/c/48103-crane-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48105-Crockett-County.txt      --wx out/48/c/48105-crockett-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48109-Culberson-County.txt     --wx out/48/c/48109-culberson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48135-Ector-County.txt         --wx out/48/c/48135-ector-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48141-El-Paso-County.txt       --wx out/48/c/48141-el-paso-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48145-Falls-County.txt         --wx out/48/c/48145-falls-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48161-Freestone-County.txt     --wx out/48/c/48161-freestone-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48171-Gillespie-County.txt     --wx out/48/c/48171-gillespie-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48173-Glasscock-County.txt     --wx out/48/c/48173-glasscock-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48185-Grimes-County.txt        --wx out/48/c/48185-grimes-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48193-Hamilton-County.txt      --wx out/48/c/48193-hamilton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48199-Hardin-County.txt        --wx out/48/c/48199-hardin-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48225-Houston-County.txt       --wx out/48/c/48225-houston-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48229-Hudspeth-County.txt      --wx out/48/c/48229-hudspeth-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48235-Irion-County.txt         --wx out/48/c/48235-irion-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48241-Jasper-County.txt        --wx out/48/c/48241-jasper-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48243-Jeff-Davis-County.txt    --wx out/48/c/48243-jeff-davis-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48267-Kimble-County.txt        --wx out/48/c/48267-kimble-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48281-Lampasas-County.txt      --wx out/48/c/48281-lampasas-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48287-Lee-County.txt           --wx out/48/c/48287-lee-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48289-Leon-County.txt          --wx out/48/c/48289-leon-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48291-Liberty-County.txt       --wx out/48/c/48291-liberty-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48293-Limestone-County.txt     --wx out/48/c/48293-limestone-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48299-Llano-County.txt         --wx out/48/c/48299-llano-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48301-Loving-County.txt        --wx out/48/c/48301-loving-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48307-McCulloch-County.txt     --wx out/48/c/48307-mcculloch-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48309-McLennan-County.txt      --wx out/48/c/48309-mclennan-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48313-Madison-County.txt       --wx out/48/c/48313-madison-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48319-Mason-County.txt         --wx out/48/c/48319-mason-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48327-Menard-County.txt        --wx out/48/c/48327-menard-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48329-Midland-County.txt       --wx out/48/c/48329-midland-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48331-Milam-County.txt         --wx out/48/c/48331-milam-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48333-Mills-County.txt         --wx out/48/c/48333-mills-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48339-Montgomery-County.txt    --wx out/48/c/48339-montgomery-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48347-Nacogdoches-County.txt   --wx out/48/c/48347-nacogdoches-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48351-Newton-County.txt        --wx out/48/c/48351-newton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48361-Orange-County.txt        --wx out/48/c/48361-orange-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48371-Pecos-County.txt         --wx out/48/c/48371-pecos-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48373-Polk-County.txt          --wx out/48/c/48373-polk-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48383-Reagan-County.txt        --wx out/48/c/48383-reagan-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48389-Reeves-County.txt        --wx out/48/c/48389-reeves-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48395-Robertson-County.txt     --wx out/48/c/48395-robertson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48399-Runnels-County.txt       --wx out/48/c/48399-runnels-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48403-Sabine-County.txt        --wx out/48/c/48403-sabine-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48405-San-Augustine-County.txt --wx out/48/c/48405-san-augustine-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48407-San-Jacinto-County.txt   --wx out/48/c/48407-san-jacinto-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48411-San-Saba-County.txt      --wx out/48/c/48411-san-saba-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48413-Schleicher-County.txt    --wx out/48/c/48413-schleicher-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48419-Shelby-County.txt        --wx out/48/c/48419-shelby-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48431-Sterling-County.txt      --wx out/48/c/48431-sterling-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48435-Sutton-County.txt        --wx out/48/c/48435-sutton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48451-Tom-Green-County.txt     --wx out/48/c/48451-tom-green-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48453-Travis-County.txt        --wx out/48/c/48453-travis-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48455-Trinity-County.txt       --wx out/48/c/48455-trinity-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48457-Tyler-County.txt         --wx out/48/c/48457-tyler-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48461-Upton-County.txt         --wx out/48/c/48461-upton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48471-Walker-County.txt        --wx out/48/c/48471-walker-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48475-Ward-County.txt          --wx out/48/c/48475-ward-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48477-Washington-County.txt    --wx out/48/c/48477-washington-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48491-Williamson-County.txt    --wx out/48/c/48491-williamson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48495-Winkler-County.txt       --wx out/48/c/48495-winkler-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48007-Aransas-County.txt       --wx out/48/sc/48007-aransas-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48013-Atascosa-County.txt      --wx out/48/sc/48013-atascosa-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48015-Austin-County.txt        --wx out/48/sc/48015-austin-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48019-Bandera-County.txt       --wx out/48/sc/48019-bandera-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48025-Bee-County.txt           --wx out/48/sc/48025-bee-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48029-Bexar-County.txt         --wx out/48/sc/48029-bexar-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48039-Brazoria-County.txt      --wx out/48/sc/48039-brazoria-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48043-Brewster-County.txt      --wx out/48/sc/48043-brewster-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48055-Caldwell-County.txt      --wx out/48/sc/48055-caldwell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48057-Calhoun-County.txt       --wx out/48/sc/48057-calhoun-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48071-Chambers-County.txt      --wx out/48/sc/48071-chambers-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48089-Colorado-County.txt      --wx out/48/sc/48089-colorado-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48091-Comal-County.txt         --wx out/48/sc/48091-comal-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48123-DeWitt-County.txt        --wx out/48/sc/48123-dewitt-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48127-Dimmit-County.txt        --wx out/48/sc/48127-dimmit-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48137-Edwards-County.txt       --wx out/48/sc/48137-edwards-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48149-Fayette-County.txt       --wx out/48/sc/48149-fayette-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48157-Fort-Bend-County.txt     --wx out/48/sc/48157-fort-bend-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48163-Frio-County.txt          --wx out/48/sc/48163-frio-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48167-Galveston-County.txt     --wx out/48/sc/48167-galveston-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48175-Goliad-County.txt        --wx out/48/sc/48175-goliad-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48177-Gonzales-County.txt      --wx out/48/sc/48177-gonzales-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48187-Guadalupe-County.txt     --wx out/48/sc/48187-guadalupe-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48201-Harris-County.txt        --wx out/48/sc/48201-harris-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48209-Hays-County.txt          --wx out/48/sc/48209-hays-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48239-Jackson-County.txt       --wx out/48/sc/48239-jackson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48245-Jefferson-County.txt     --wx out/48/sc/48245-jefferson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48255-Karnes-County.txt        --wx out/48/sc/48255-karnes-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48259-Kendall-County.txt       --wx out/48/sc/48259-kendall-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48265-Kerr-County.txt          --wx out/48/sc/48265-kerr-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48271-Kinney-County.txt        --wx out/48/sc/48271-kinney-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48283-La-Salle-County.txt      --wx out/48/sc/48283-la-salle-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48285-Lavaca-County.txt        --wx out/48/sc/48285-lavaca-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48297-Live-Oak-County.txt      --wx out/48/sc/48297-live-oak-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48311-McMullen-County.txt      --wx out/48/sc/48311-mcmullen-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48321-Matagorda-County.txt     --wx out/48/sc/48321-matagorda-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48323-Maverick-County.txt      --wx out/48/sc/48323-maverick-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48325-Medina-County.txt        --wx out/48/sc/48325-medina-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48377-Presidio-County.txt      --wx out/48/sc/48377-presidio-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48385-Real-County.txt          --wx out/48/sc/48385-real-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48391-Refugio-County.txt       --wx out/48/sc/48391-refugio-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48443-Terrell-County.txt       --wx out/48/sc/48443-terrell-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48463-Uvalde-County.txt        --wx out/48/sc/48463-uvalde-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48465-Val-Verde-County.txt     --wx out/48/sc/48465-val-verde-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48469-Victoria-County.txt      --wx out/48/sc/48469-victoria-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48473-Waller-County.txt        --wx out/48/sc/48473-waller-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48481-Wharton-County.txt       --wx out/48/sc/48481-wharton-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48493-Wilson-County.txt        --wx out/48/sc/48493-wilson-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48507-Zavala-County.txt        --wx out/48/sc/48507-zavala-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48047-Brooks-County.txt        --wx out/48/s/48047-brooks-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48061-Cameron-County.txt       --wx out/48/s/48061-cameron-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48131-Duval-County.txt         --wx out/48/s/48131-duval-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48215-Hidalgo-County.txt       --wx out/48/s/48215-hidalgo-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48247-Jim-Hogg-County.txt      --wx out/48/s/48247-jim-hogg-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48249-Jim-Wells-County.txt     --wx out/48/s/48249-jim-wells-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48261-Kenedy-County.txt        --wx out/48/s/48261-kenedy-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48273-Kleberg-County.txt       --wx out/48/s/48273-kleberg-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48355-Nueces-County.txt        --wx out/48/s/48355-nueces-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48409-San-Patricio-County.txt  --wx out/48/s/48409-san-patricio-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48427-Starr-County.txt         --wx out/48/s/48427-starr-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48479-Webb-County.txt          --wx out/48/s/48479-webb-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48489-Willacy-County.txt       --wx out/48/s/48489-willacy-county.osm.bz2 \
    --bp completeWays=yes file=polys/48/48505-Zapata-County.txt        --wx out/48/s/48505-zapata-county.osm.bz2 \

touch -r tmp/texas.osm.pbf out/48/*/*.osm.???

./skeletron-roads.sh tmp/texas-roads.osm.pbf out/48 texas TX
./skeletron-routes.sh tmp/texas-routes.osm.bz2 out/48 texas TX
