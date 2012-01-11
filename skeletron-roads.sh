#!/bin/sh -ex

if [ $# -ne 4 ]; then
    echo "Need a file argument, directory argument, prefix, and source id argument.";
    exit 1;
fi

if [ ! -f "$1" ]; then
    echo "$1 needs to be a regular file.";
    exit 1;
fi

if [ ! -d "$2" ]; then
    echo "$2 needs to be a regular directory.";
    exit 1;
fi

INPUT=$1;
OUTDIR=$2;
PREFIX=$3;
SOURCE=$4;

TMPDIR=`tempfile -d tmp -p skel-`;
rm $TMPDIR && mkdir $TMPDIR;

OSM1=$TMPDIR/roads-mtpst.osm.bz2;
OSM2=$TMPDIR/roads-tpst.osm.bz2;
OSM3=$TMPDIR/roads-tps.osm.bz2;
OSM4=$TMPDIR/roads-tp.osm.bz2;

osmosis --rb $INPUT --tf accept-ways "highway=motorway,trunk,primary,secondary,tertiary" --used-node --wx - | bzip2 > $OSM1;
bzcat $OSM1 | osmosis --rx - --tf accept-ways "highway=trunk,primary,secondary,tertiary" --used-node --wx - | bzip2 > $OSM2;
bzcat $OSM2 | osmosis --rx - --tf accept-ways "highway=trunk,primary,secondary" --used-node --wx - | bzip2 > $OSM3;
bzcat $OSM3 | osmosis --rx - --tf accept-ways "highway=trunk,primary" --used-node --wx - | bzip2 > $OSM4;

skeletron-osm-streets.py -z 12 -w 15 --ignore-highway $OSM4 $TMPDIR/roads-z12.json; 
ogr2ogr -t_srs EPSG:900913 $TMPDIR/$PREFIX-roads-z12.shp $TMPDIR/roads-z12.json;
zip -j $OUTDIR/$PREFIX-roads-z12.zip $TMPDIR/$PREFIX-roads-z12.???

skeletron-osm-streets.py -z 13 -w 15 --ignore-highway $OSM3 $TMPDIR/roads-z13.json; 
ogr2ogr -t_srs EPSG:900913 $TMPDIR/$PREFIX-roads-z13.shp $TMPDIR/roads-z13.json;
zip -j $OUTDIR/$PREFIX-roads-z13.zip $TMPDIR/$PREFIX-roads-z13.???

skeletron-osm-streets.py -z 14 -w 15 --ignore-highway $OSM2 $TMPDIR/roads-z14.json; 
ogr2ogr -t_srs EPSG:900913 $TMPDIR/$PREFIX-roads-z14.shp $TMPDIR/roads-z14.json;
zip -j $OUTDIR/$PREFIX-roads-z14.zip $TMPDIR/$PREFIX-roads-z14.???

skeletron-osm-streets.py -z 15 -w 15 --ignore-highway $OSM1 $TMPDIR/roads-z15.json; 
ogr2ogr -t_srs EPSG:900913 $TMPDIR/$PREFIX-roads-z15.shp $TMPDIR/roads-z15.json;
zip -j $OUTDIR/$PREFIX-roads-z15.zip $TMPDIR/$PREFIX-roads-z15.???

FIPS=`basename $OUTDIR`;

shp2pgsql -dID -s 900913 $TMPDIR/$PREFIX-roads-z12.shp roads$FIPS > $OUTDIR/roads-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-roads-z13.shp roads$FIPS >> $OUTDIR/roads-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-roads-z14.shp roads$FIPS >> $OUTDIR/roads-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-roads-z15.shp roads$FIPS >> $OUTDIR/roads-$FIPS.pgsql;
