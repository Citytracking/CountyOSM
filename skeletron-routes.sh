#!/bin/sh -ex

if [ $# -ne 4 ]; then
    echo "Need a file argument, directory argument, prefix and source id argument.";
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

for Z in 10 11 12 13 14 15; do

    skeletron-osm-route-rels.py -z $Z -w 20 --merge-highways largest $INPUT $TMPDIR/routes-z$Z.json; 
    ogr2ogr -t_srs EPSG:900913 $TMPDIR/$PREFIX-routes-z$Z.shp $TMPDIR/routes-z$Z.json;
    zip -j $OUTDIR/$PREFIX-routes-z$Z.zip $TMPDIR/$PREFIX-routes-z$Z.???

done;

FIPS=`basename $OUTDIR`;

shp2pgsql -dID -s 900913 $TMPDIR/$PREFIX-routes-z10.shp routes$FIPS > $OUTDIR/routes-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-routes-z11.shp routes$FIPS >> $OUTDIR/routes-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-routes-z12.shp routes$FIPS >> $OUTDIR/routes-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-routes-z13.shp routes$FIPS >> $OUTDIR/routes-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-routes-z14.shp routes$FIPS >> $OUTDIR/routes-$FIPS.pgsql;
shp2pgsql -aD -s 900913 $TMPDIR/$PREFIX-routes-z15.shp routes$FIPS >> $OUTDIR/routes-$FIPS.pgsql;
