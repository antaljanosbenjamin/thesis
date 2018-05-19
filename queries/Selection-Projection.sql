WITH q0 AS ( -- GetVertices
  SELECT vertex_id AS "p",
        (SELECT value FROM vertex_property
         WHERE parent = vertex_id AND key = 'age') AS "p.age",
        (SELECT value FROM vertex_property
         WHERE parent = vertex_id AND key = 'name') AS "p.name"
  FROM vertex
  WHERE NOT EXISTS(VALUES ('Person')
                   EXCEPT ALL SELECT name FROM label WHERE parent = vertex_id)),
q1 AS ( -- Selection
  SELECT * FROM q0 WHERE "p.age" < 30),
q2 AS ( -- Projection
  SELECT "p.name" AS "name" FROM q1)
-- DuplicateElimination
SELECT DISTINCT * FROM q2