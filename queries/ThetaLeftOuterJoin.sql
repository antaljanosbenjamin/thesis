WITH q0 AS (/* GetVertices: (p:Person) | attributes: p.name */),
q1 AS (/* GetEdges: (p)-[i:INTEREST]->(t:Tag) | attributes: i.level, t.topic */),
q2 AS (-- ThetaLeftOuterJoin
  SELECT "left"."p", "left"."p.name",
    "right"."i.level", "right"."i", "right"."t", "right"."t.topic"
  FROM q0 AS "left" LEFT OUTER JOIN q1 AS "right"
  ON "left"."p" = "right"."p" AND "i.level" > 3)
-- Projection
SELECT "p.name", "t.topic" FROM q2;