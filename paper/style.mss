Map { map-bgcolor: #fff; }

Layer
{
    line-cap: square;
    line-join: round;
}

#lines
{
    line-width: .25;
    line-color: #000;
    line-cap: square;
    line-join: miter;
}

#lines[highway=trunk],
#lines[highway=primary],
#lines[highway=motorway_link]
{
    line-width: .9;
}

#lines[highway=motorway]
{
    line-width: 3;
}

/*
* still smaller
*/

#lines[scale-denominator>400000]
{
    line-width: .063;
}

#lines[highway=trunk][scale-denominator>400000],
#lines[highway=primary][scale-denominator>400000],
#lines[highway=motorway_link][scale-denominator>400000]
{
    line-width: .217;
}

#lines[highway=motorway][scale-denominator>400000]
{
    line-width: .75;
}

/*
* smaller
*/

#lines[scale-denominator>200000]
{
    line-width: .125;
}

#lines[highway=trunk][scale-denominator>200000],
#lines[highway=primary][scale-denominator>200000],
#lines[highway=motorway_link][scale-denominator>200000]
{
    line-width: .43;
}

#lines[highway=motorway][scale-denominator>200000]
{
    line-width: 1.5;
}

/*
* bigger
*/

#lines[scale-denominator<100000]
{
    line-width: .5;
}

#lines[highway=trunk][scale-denominator<100000],
#lines[highway=primary][scale-denominator<100000],
#lines[highway=motorway_link][scale-denominator<100000]
{
    line-width: 1.7;
}

#lines[highway=motorway][scale-denominator<100000]
{
    line-width: 6;
}

/*
* still bigger
*/

#lines[scale-denominator<50000]
{
    line-width: 1;
}

#lines[highway=trunk][scale-denominator<50000],
#lines[highway=primary][scale-denominator<50000],
#lines[highway=motorway_link][scale-denominator<50000]
{
    line-width: 3.5;
}

#lines[highway=motorway][scale-denominator<50000]
{
    line-width: 12;
}
