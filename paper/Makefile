out.png: style.xml
	nik2img.py -e 1835324 605543 1916490 660850 -d 2000 1350 -v style.xml $@
	optipng -zc 9 -zm 8 -zs 3 -f 0 -q $@

out-tiger.png: style-tiger.xml
	nik2img.py -e 1835324 605543 1916490 660850 -d 2000 1350 -v style-tiger.xml $@
	optipng -zc 9 -zm 8 -zs 3 -f 0 -q $@

out-tiger-tx.png: style-tiger-tx.xml
	nik2img.py -e 899658 3037222 985395 3110853 -d 1800 1450 -v style-tiger-tx.xml $@
	optipng -zc 9 -zm 8 -zs 3 -f 0 -q $@

out-recent.png: style-recent.xml
	nik2img.py -e 1835324 605543 1916490 660850 -d 2000 1350 -v style-recent.xml $@
	optipng -zc 9 -zm 8 -zs 3 -f 0 -q $@

out-recent-tx.png: style-recent-tx.xml
	nik2img.py -e 899658 3037222 985395 3110853 -d 1800 1450 -v style-recent-tx.xml $@
	optipng -zc 9 -zm 8 -zs 3 -f 0 -q $@



style.xml: style.mml alameda_ca_roads-state.shp
	cascadenik-compile.py style.mml $@

style-tiger.xml: style-tiger.mml style-tiger.mss county-alameda-ca.mss alameda_ca_roads-state.shp
	cascadenik-compile.py style-tiger.mml $@

style-tiger-tx.xml: style-tiger-tx.mml style-tiger.mss county-travis-tx.mss travis_tx_roads-state.shp
	cascadenik-compile.py style-tiger-tx.mml $@

style-recent.xml: style-recent.mml style-recent.mss county-alameda-ca.mss alameda_ca_roads-state.shp
	cascadenik-compile.py style-recent.mml $@

style-recent-tx.xml: style-recent-tx.mml style-recent.mss county-travis-tx.mss travis_tx_roads-state.shp
	cascadenik-compile.py style-recent-tx.mml $@



alameda_ca_roads-state.shp: alameda_ca_roads-merc.shp
	rm -f alameda_ca_roads-state.shp alameda_ca_roads-state.dbf alameda_ca_roads-state.prj alameda_ca_roads-state.shx
	ogr2ogr -t_srs EPSG:2768 $@ alameda_ca_roads-merc.shp

travis_tx_roads-state.shp: travis_tx_roads-merc.shp
	rm -f travis_tx_roads-state.shp travis_tx_roads-state.dbf travis_tx_roads-state.prj travis_tx_roads-state.shx
	ogr2ogr -t_srs EPSG:2846 $@ travis_tx_roads-merc.shp



# "is_tiger" below based on https://github.com/MapQuest/TIGER-Edited-map/blob/master/inc/layer-tiger.xml.inc#L49

alameda_ca_roads-merc.shp:
	pgsql2shp -f $@ -u osm -r county_papers -k "SELECT osm_id, highway, name, oneway, bridge, tunnel, osm_user, osm_uid, osm_timestamp AS osm_time, (CASE WHEN osm_uid = '7168' AND osm_timestamp::timestamp > '2007-08-03'::timestamp AND osm_timestamp::timestamp < '2008-05-04'::timestamp THEN 'yes' WHEN osm_uid = '15169' AND osm_timestamp::timestamp > '2007-10-29'::timestamp AND osm_timestamp::timestamp < '2007-12-12'::timestamp THEN 'yes' WHEN osm_uid = '20587' AND osm_timestamp::timestamp > '2010-03-21'::timestamp AND osm_timestamp::timestamp < '2010-04-08'::timestamp AND osm_version::int < 3 THEN 'yes' ELSE 'no' end) AS is_tiger, EXTRACT(days FROM NOW() - osm_timestamp::timestamp)::int AS days_ago, way FROM alameda_ca_line WHERE highway IN ('motorway', 'motorway_link', 'trunk', 'trunk_link', 'primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'road', 'unclassified', 'service')"

travis_tx_roads-merc.shp:
	pgsql2shp -f $@ -u osm -r county_papers -k "SELECT osm_id, highway, name, oneway, bridge, tunnel, osm_user, osm_uid, osm_timestamp AS osm_time, (CASE WHEN osm_uid = '7168' AND osm_timestamp::timestamp > '2007-08-03'::timestamp AND osm_timestamp::timestamp < '2008-05-04'::timestamp THEN 'yes' WHEN osm_uid = '15169' AND osm_timestamp::timestamp > '2007-10-29'::timestamp AND osm_timestamp::timestamp < '2007-12-12'::timestamp THEN 'yes' WHEN osm_uid = '20587' AND osm_timestamp::timestamp > '2010-03-21'::timestamp AND osm_timestamp::timestamp < '2010-04-08'::timestamp AND osm_version::int < 3 THEN 'yes' ELSE 'no' end) AS is_tiger, EXTRACT(days FROM NOW() - osm_timestamp::timestamp)::int AS days_ago, way FROM travis_tx_line WHERE highway IN ('motorway', 'motorway_link', 'trunk', 'trunk_link', 'primary', 'primary_link', 'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 'residential', 'road', 'unclassified', 'service')"

#
# shapefiles come via:
# osm2pgsql -xmucK -S paper.style -U osm -d county_papers -p travis_tx 48453-travis-county.osm.bz2
#