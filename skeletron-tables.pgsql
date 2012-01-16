SELECT DropGeometryColumn('','skeletron_roads','the_geom');
DROP TABLE IF EXISTS "skeletron_roads";

SELECT DropGeometryColumn('','skeletron_routes','the_geom');
DROP TABLE "skeletron_routes";

BEGIN;

CREATE TABLE "skeletron_roads"
(
    gid         SERIAL PRIMARY KEY,
    source      VARCHAR(16),

    zoomlevel   INT,
    pixelwidth  NUMERIC,

    name        VARCHAR(128)
);

CREATE TABLE "skeletron_routes"
(
    gid         SERIAL PRIMARY KEY,
    source      VARCHAR(16),

    zoomlevel   INT,
    pixelwidth  NUMERIC,

    network     VARCHAR(80),
    ref         VARCHAR(80),
    modifier    VARCHAR(80),
    highway     VARCHAR(80)
);

SELECT AddGeometryColumn('','skeletron_roads','the_geom','900913','MULTILINESTRING',2);
SELECT AddGeometryColumn('','skeletron_routes','the_geom','900913','MULTILINESTRING',2);

CREATE INDEX "skeletron_roads_the_geom_gist" ON "skeletron_roads" using gist ("the_geom" gist_geometry_ops);
CREATE INDEX "skeletron_routes_the_geom_gist" ON "skeletron_routes" using gist ("the_geom" gist_geometry_ops);



INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'AL', zoomlevel, pixelwidth, name, the_geom FROM roads01;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'AL', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes01;

DROP TABLE roads01;
DROP TABLE routes01;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'AZ', zoomlevel, pixelwidth, name, the_geom FROM roads04;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'AZ', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes04;

DROP TABLE roads04;
DROP TABLE routes04;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'AR', zoomlevel, pixelwidth, name, the_geom FROM roads05;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'AR', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes05;

DROP TABLE roads05;
DROP TABLE routes05;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'CA', zoomlevel, pixelwidth, name, the_geom FROM roads06;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'CA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes06;

DROP TABLE roads06;
DROP TABLE routes06;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'CO', zoomlevel, pixelwidth, name, the_geom FROM roads08;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'CO', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes08;

DROP TABLE roads08;
DROP TABLE routes08;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'CT', zoomlevel, pixelwidth, name, the_geom FROM roads09;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'CT', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes09;

DROP TABLE roads09;
DROP TABLE routes09;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'DE', zoomlevel, pixelwidth, name, the_geom FROM roads10;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'DE', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes10;

DROP TABLE roads10;
DROP TABLE routes10;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'DC', zoomlevel, pixelwidth, name, the_geom FROM roads11;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'DC', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes11;

DROP TABLE roads11;
DROP TABLE routes11;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'FL', zoomlevel, pixelwidth, name, the_geom FROM roads12;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'FL', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes12;

DROP TABLE roads12;
DROP TABLE routes12;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'GA', zoomlevel, pixelwidth, name, the_geom FROM roads13;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'GA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes13;

DROP TABLE roads13;
DROP TABLE routes13;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'ID', zoomlevel, pixelwidth, name, the_geom FROM roads16;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'ID', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes16;

DROP TABLE roads16;
DROP TABLE routes16;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'IL', zoomlevel, pixelwidth, name, the_geom FROM roads17;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'IL', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes17;

DROP TABLE roads17;
DROP TABLE routes17;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'IN', zoomlevel, pixelwidth, name, the_geom FROM roads18;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'IN', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes18;

DROP TABLE roads18;
DROP TABLE routes18;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'IA', zoomlevel, pixelwidth, name, the_geom FROM roads19;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'IA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes19;

DROP TABLE roads19;
DROP TABLE routes19;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'KS', zoomlevel, pixelwidth, name, the_geom FROM roads20;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'KS', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes20;

DROP TABLE roads20;
DROP TABLE routes20;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'KY', zoomlevel, pixelwidth, name, the_geom FROM roads21;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'KY', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes21;

DROP TABLE roads21;
DROP TABLE routes21;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'LA', zoomlevel, pixelwidth, name, the_geom FROM roads22;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'LA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes22;

DROP TABLE roads22;
DROP TABLE routes22;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'ME', zoomlevel, pixelwidth, name, the_geom FROM roads23;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'ME', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes23;

DROP TABLE roads23;
DROP TABLE routes23;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MD', zoomlevel, pixelwidth, name, the_geom FROM roads24;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MD', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes24;

DROP TABLE roads24;
DROP TABLE routes24;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MA', zoomlevel, pixelwidth, name, the_geom FROM roads25;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes25;

DROP TABLE roads25;
DROP TABLE routes25;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MI', zoomlevel, pixelwidth, name, the_geom FROM roads26;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MI', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes26;

DROP TABLE roads26;
DROP TABLE routes26;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MN', zoomlevel, pixelwidth, name, the_geom FROM roads27;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MN', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes27;

DROP TABLE roads27;
DROP TABLE routes27;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MS', zoomlevel, pixelwidth, name, the_geom FROM roads28;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MS', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes28;

DROP TABLE roads28;
DROP TABLE routes28;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MO', zoomlevel, pixelwidth, name, the_geom FROM roads29;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MO', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes29;

DROP TABLE roads29;
DROP TABLE routes29;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'MT', zoomlevel, pixelwidth, name, the_geom FROM roads30;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'MT', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes30;

DROP TABLE roads30;
DROP TABLE routes30;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NE', zoomlevel, pixelwidth, name, the_geom FROM roads31;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NE', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes31;

DROP TABLE roads31;
DROP TABLE routes31;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NV', zoomlevel, pixelwidth, name, the_geom FROM roads32;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NV', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes32;

DROP TABLE roads32;
DROP TABLE routes32;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NH', zoomlevel, pixelwidth, name, the_geom FROM roads33;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NH', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes33;

DROP TABLE roads33;
DROP TABLE routes33;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NJ', zoomlevel, pixelwidth, name, the_geom FROM roads34;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NJ', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes34;

DROP TABLE roads34;
DROP TABLE routes34;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NM', zoomlevel, pixelwidth, name, the_geom FROM roads35;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NM', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes35;

DROP TABLE roads35;
DROP TABLE routes35;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NY', zoomlevel, pixelwidth, name, the_geom FROM roads36;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NY', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes36;

DROP TABLE roads36;
DROP TABLE routes36;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'NC', zoomlevel, pixelwidth, name, the_geom FROM roads37;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'NC', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes37;

DROP TABLE roads37;
DROP TABLE routes37;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'ND', zoomlevel, pixelwidth, name, the_geom FROM roads38;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'ND', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes38;

DROP TABLE roads38;
DROP TABLE routes38;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'OH', zoomlevel, pixelwidth, name, the_geom FROM roads39;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'OH', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes39;

DROP TABLE roads39;
DROP TABLE routes39;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'OK', zoomlevel, pixelwidth, name, the_geom FROM roads40;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'OK', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes40;

DROP TABLE roads40;
DROP TABLE routes40;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'OR', zoomlevel, pixelwidth, name, the_geom FROM roads41;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'OR', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes41;

DROP TABLE roads41;
DROP TABLE routes41;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'PA', zoomlevel, pixelwidth, name, the_geom FROM roads42;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'PA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes42;

DROP TABLE roads42;
DROP TABLE routes42;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'RI', zoomlevel, pixelwidth, name, the_geom FROM roads44;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'RI', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes44;

DROP TABLE roads44;
DROP TABLE routes44;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'SC', zoomlevel, pixelwidth, name, the_geom FROM roads45;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'SC', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes45;

DROP TABLE roads45;
DROP TABLE routes45;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'SD', zoomlevel, pixelwidth, name, the_geom FROM roads46;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'SD', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes46;

DROP TABLE roads46;
DROP TABLE routes46;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'TN', zoomlevel, pixelwidth, name, the_geom FROM roads47;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'TN', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes47;

DROP TABLE roads47;
DROP TABLE routes47;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'TX', zoomlevel, pixelwidth, name, the_geom FROM roads48;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'TX', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes48;

DROP TABLE roads48;
DROP TABLE routes48;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'UT', zoomlevel, pixelwidth, name, the_geom FROM roads49;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'UT', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes49;

DROP TABLE roads49;
DROP TABLE routes49;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'VT', zoomlevel, pixelwidth, name, the_geom FROM roads50;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'VT', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes50;

DROP TABLE roads50;
DROP TABLE routes50;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'VA', zoomlevel, pixelwidth, name, the_geom FROM roads51;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'VA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes51;

DROP TABLE roads51;
DROP TABLE routes51;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'WA', zoomlevel, pixelwidth, name, the_geom FROM roads53;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'WA', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes53;

DROP TABLE roads53;
DROP TABLE routes53;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'WV', zoomlevel, pixelwidth, name, the_geom FROM roads54;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'WV', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes54;

DROP TABLE roads54;
DROP TABLE routes54;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'WI', zoomlevel, pixelwidth, name, the_geom FROM roads55;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'WI', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes55;

DROP TABLE roads55;
DROP TABLE routes55;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name, the_geom)
    SELECT 'WY', zoomlevel, pixelwidth, name, the_geom FROM roads56;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom)
    SELECT 'WY', zoomlevel, pixelwidth, network, ref, modifier, highway, the_geom FROM routes56;

DROP TABLE roads56;
DROP TABLE routes56;



COMMIT;
