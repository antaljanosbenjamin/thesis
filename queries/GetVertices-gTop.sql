WITH q0 AS ( -- GetVertices
  SELECT make_vertex_id('post', "id") AS "m",
         "content" AS "m.content"
  FROM "post"),
q1 AS ( -- GetVertices
  SELECT ROW('comment', "id")::vertex_type AS "m",
         "content" AS "m.content"
  FROM "comment"),
q2 AS ( -- UnionAll
  SELECT "m", "m.content" FROM q0
  UNION ALL
  SELECT "m", "m.content" FROM q1)
-- Projection
SELECT "m.content" FROM q2