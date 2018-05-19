WITH q0 AS ( /* GetVertices: (p:Person) | attributes: p.speaks, p.name */ ),
q1 AS ( /* Projection: p, p.speaks, p.name AS name */ ),
q2 AS ( -- Unwind
  SELECT "p", "name", unnest("p.speaks") AS "lang"
  FROM q1)
-- Grouping
SELECT "lang", array_agg("name") AS "speakers"
FROM q2
GROUP BY "lang"