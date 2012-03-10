Map { map-bgcolor: #fff; }

Layer
{
    line-cap: square;
    line-join: round;
}

#counties
{
    line-color: #ccc;
    line-opacity: 1;
}

#lines
{
    line-width: .5;
    line-color: #000;
    line-opacity: .5;
    line-cap: square;
    line-join: miter;
}

#lines[is_tiger=yes]
{
    line-width: 3;
    line-opacity: 1;
}

/*
* smaller
*/

#lines[scale-denominator>200000]
{
    line-width: .25;
}

#lines[is_tiger=yes][scale-denominator>200000] { line-width: 1.5; }

/*
* bigger
*/

#lines[scale-denominator<100000]
{
    line-width: 1;
}

#lines[is_tiger=yes][scale-denominator<100000] { line-width: 6; }

/*
* still bigger
*/

#lines[scale-denominator<50000]
{
    line-width: 2;
}

#lines[is_tiger=yes][scale-denominator<50000] { line-width: 12; }
