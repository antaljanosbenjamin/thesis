WITH q0 AS ( /* GetVertices: (c:Class) | attributes: c.subject */ ),
q1 AS ( /* GetEdges: (c)-[e1:SUBCLASS_OF]->(v1) */ ),
q2 AS ( -- AntiJoin
  SELECT * FROM q0 AS "left"
  WHERE NOT EXISTS(
    SELECT 1 FROM q1 AS "right"
    WHERE "left"."c" = "right"."c"))
-- Projection
SELECT "c.subject" FROM q2