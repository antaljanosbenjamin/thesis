WITH q0 AS ( -- GetEdges: (p:Person)-[e1:KNOWS]->(f) | attributes: p.name
  SELECT "from" AS "p", edge_id AS "e1", "to" AS "f",... AS "p.name" FROM edge ...),
q1 AS ( -- GetEdges:      (p:Person)<-[e1:KNOWS]-(f) | attributes: p.name
  SELECT "from" AS "f", edge_id AS "e1", "to" AS "p",... AS "p.name" FROM edge ...),
q2 AS ( -- UnionAll: q0 %*$ \color{comment} \cup $*) q1
  SELECT ... FROM q0 UNION ALL SELECT ... FROM q1),
q3 AS ( -- Selection: p.name = 'Alice'
  SELECT * FROM q2 WHERE ("p.name" = 'Alice')),
q4 AS ( -- GetEdges: (f)-[e2:KNOWS]->(foaf) | attributes: foaf.name
  SELECT "from" AS    "f", edge_id AS "e2", "to" AS "foaf",... FROM edge ...),
q5 AS ( -- GetEdges: (f)<-[e2:KNOWS]-(foaf) | attributes: foaf.name
  SELECT "from" AS "foaf", edge_id AS "e2", "to" AS    "f",... FROM edge ...),
q6 AS ( -- UnionAll: q4 %*$ \color{comment} \cup $*) q5
  SELECT ... FROM q4 UNION ALL SELECT ... FROM q5),
q7 AS ( -- Join
  SELECT "left"."p", "left"."p.name", "left"."e1", "left"."f",
    "right"."e2", "right"."foaf", "right"."foaf.name"
  FROM q3 AS "left" INNER JOIN q6 AS "right" ON "left"."f" = "right"."f"),
q8 AS ( -- AllDifferent
  SELECT * FROM q7 WHERE is_unique(ARRAY["e1", "e2"]))
-- Projection
SELECT "foaf.name" FROM q8