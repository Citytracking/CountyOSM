#counties[GEOID10="06001"]
{
    line-width: 3;
    line-color: #000;
    line-opacity: .2;
}

#counties[GEOID10!="06001"]
{
    polygon-fill: #fff;
    polygon-opacity: .6;
}

/*
* still smaller
*/

#counties[GEOID10="06001"][scale-denominator>200000]
{
    line-width: .75;
}

/*
* smaller
*/

#counties[GEOID10="06001"][scale-denominator>200000]
{
    line-width: 1.5;
}

/*
* bigger
*/

#counties[GEOID10="06001"][scale-denominator<100000]
{
    line-width: 6;
}

/*
* still bigger
*/

#counties[GEOID10="06001"][scale-denominator<50000]
{
    line-width: 12;
}
