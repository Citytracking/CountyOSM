#counties[GEOID10="06001"]
{
    line-width: 3;
}

#counties[GEOID10!="06001"]
{
    polygon-fill: #fff;
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
