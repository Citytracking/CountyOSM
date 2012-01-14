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



INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'AL', zoomlevel, pixelwidth, name FROM roads01;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'AL', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes01;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'AZ', zoomlevel, pixelwidth, name FROM roads04;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'AZ', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes04;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'AR', zoomlevel, pixelwidth, name FROM roads05;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'AR', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes05;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'CA', zoomlevel, pixelwidth, name FROM roads06;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'CA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes06;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'CO', zoomlevel, pixelwidth, name FROM roads08;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'CO', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes08;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'CT', zoomlevel, pixelwidth, name FROM roads09;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'CT', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes09;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'DE', zoomlevel, pixelwidth, name FROM roads10;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'DE', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes10;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'DC', zoomlevel, pixelwidth, name FROM roads11;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'DC', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes11;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'FL', zoomlevel, pixelwidth, name FROM roads12;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'FL', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes12;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'GA', zoomlevel, pixelwidth, name FROM roads13;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'GA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes13;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'ID', zoomlevel, pixelwidth, name FROM roads16;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'ID', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes16;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'IL', zoomlevel, pixelwidth, name FROM roads17;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'IL', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes17;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'IN', zoomlevel, pixelwidth, name FROM roads18;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'IN', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes18;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'IA', zoomlevel, pixelwidth, name FROM roads19;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'IA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes19;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'KS', zoomlevel, pixelwidth, name FROM roads20;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'KS', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes20;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'KY', zoomlevel, pixelwidth, name FROM roads21;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'KY', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes21;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'LA', zoomlevel, pixelwidth, name FROM roads22;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'LA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes22;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'ME', zoomlevel, pixelwidth, name FROM roads23;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'ME', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes23;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MD', zoomlevel, pixelwidth, name FROM roads24;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MD', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes24;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MA', zoomlevel, pixelwidth, name FROM roads25;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes25;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MI', zoomlevel, pixelwidth, name FROM roads26;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MI', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes26;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MN', zoomlevel, pixelwidth, name FROM roads27;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MN', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes27;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MS', zoomlevel, pixelwidth, name FROM roads28;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MS', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes28;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MO', zoomlevel, pixelwidth, name FROM roads29;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MO', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes29;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'MT', zoomlevel, pixelwidth, name FROM roads30;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'MT', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes30;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NE', zoomlevel, pixelwidth, name FROM roads31;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NE', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes31;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NV', zoomlevel, pixelwidth, name FROM roads32;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NV', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes32;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NH', zoomlevel, pixelwidth, name FROM roads33;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NH', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes33;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NJ', zoomlevel, pixelwidth, name FROM roads34;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NJ', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes34;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NM', zoomlevel, pixelwidth, name FROM roads35;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NM', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes35;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NY', zoomlevel, pixelwidth, name FROM roads36;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NY', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes36;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'NC', zoomlevel, pixelwidth, name FROM roads37;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'NC', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes37;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'ND', zoomlevel, pixelwidth, name FROM roads38;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'ND', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes38;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'OH', zoomlevel, pixelwidth, name FROM roads39;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'OH', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes39;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'OK', zoomlevel, pixelwidth, name FROM roads40;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'OK', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes40;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'OR', zoomlevel, pixelwidth, name FROM roads41;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'OR', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes41;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'PA', zoomlevel, pixelwidth, name FROM roads42;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'PA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes42;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'RI', zoomlevel, pixelwidth, name FROM roads44;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'RI', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes44;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'SC', zoomlevel, pixelwidth, name FROM roads45;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'SC', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes45;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'SD', zoomlevel, pixelwidth, name FROM roads46;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'SD', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes46;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'TN', zoomlevel, pixelwidth, name FROM roads47;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'TN', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes47;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'TX', zoomlevel, pixelwidth, name FROM roads48;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'TX', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes48;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'UT', zoomlevel, pixelwidth, name FROM roads49;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'UT', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes49;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'VT', zoomlevel, pixelwidth, name FROM roads50;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'VT', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes50;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'VA', zoomlevel, pixelwidth, name FROM roads51;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'VA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes51;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'WA', zoomlevel, pixelwidth, name FROM roads53;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'WA', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes53;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'WV', zoomlevel, pixelwidth, name FROM roads54;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'WV', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes54;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'WI', zoomlevel, pixelwidth, name FROM roads55;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'WI', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes55;

INSERT INTO "skeletron_roads" (source, zoomlevel, pixelwidth, name)
    SELECT 'WY', zoomlevel, pixelwidth, name FROM roads56;

INSERT INTO "skeletron_routes" (source, zoomlevel, pixelwidth, network, ref, modifier, highway)
    SELECT 'WY', zoomlevel, pixelwidth, network, ref, modifier, highway FROM routes56;



COMMIT;
