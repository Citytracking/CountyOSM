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
    line-opacity: 1;
}

#lines[days_ago<150] { line-width: .7; }
#lines[days_ago<120] { line-width: 1; }
#lines[days_ago<90] { line-width: 1.4; }
#lines[days_ago<60] { line-width: 2; }
#lines[days_ago<30] { line-width: 2.8; }

/*
* smaller
*/

#lines[scale-denominator>200000]
{
    line-width: .25;
}

#lines[days_ago<150][scale-denominator>200000] { line-width: .4; }
#lines[days_ago<120][scale-denominator>200000] { line-width: .5; }
#lines[days_ago<90][scale-denominator>200000] { line-width: .7; }
#lines[days_ago<60][scale-denominator>200000] { line-width: 1; }
#lines[days_ago<30][scale-denominator>200000] { line-width: 1.4; }

/*
* bigger
*/

#lines[scale-denominator<100000]
{
    line-width: 1;
}

#lines[days_ago<150][scale-denominator<100000] { line-width: 1.4; }
#lines[days_ago<120][scale-denominator<100000] { line-width: 2.8; }
#lines[days_ago<90][scale-denominator<100000] { line-width: 4; }
#lines[days_ago<60][scale-denominator<100000] { line-width: 5.7; }
#lines[days_ago<30][scale-denominator<100000] { line-width: 8; }

/*
* still bigger
*/

#lines[scale-denominator<50000]
{
    line-width: 2;
}

#lines[days_ago<150][scale-denominator<50000] { line-width: 2.8; }
#lines[days_ago<120][scale-denominator<50000] { line-width: 4; }
#lines[days_ago<90][scale-denominator<50000] { line-width: 5.7; }
#lines[days_ago<60][scale-denominator<50000] { line-width: 8; }
#lines[days_ago<30][scale-denominator<50000] { line-width: 11.3; }
