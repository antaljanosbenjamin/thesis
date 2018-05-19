WITH
q0 AS
 (-- GetEdges: (p:Person)-[e1:KNOWS]->(f) | attributes: p.name
  SELECT "p", "e1", "f", (SELECT value FROM vertex_property WHERE parent = "p" AND key = 'name') AS "p.name" FROM
    (
      SELECT "from" AS "p", edge_id AS "e1", "to" AS "f" FROM edge
      WHERE type IN ('KNOWS')
    ) subquery),
q1 AS
 (-- GetEdges: (p:Person)<-[e1:KNOWS]-(f) | attributes: p.name
  SELECT "f", "e1", "p", (SELECT value FROM vertex_property WHERE parent = "p" AND key = 'name') AS "p.name" FROM
    (
      SELECT "from" AS "f", edge_id AS "e1", "to" AS "p" FROM edge
      WHERE type IN ('KNOWS')
    ) subquery),
q2 AS
 (-- UnionAll: q0 %*$ \color{comment} \cup $*) q1
  SELECT "p", "e1", "f", "p.name" FROM q0
  UNION ALL
  SELECT "p", "e1", "f", "p.name" FROM q1),
q3 AS
 (-- Selection: p.name = 'Alice'
  SELECT * FROM q2 AS subquery
  WHERE ("p.name" = '{"type":"StringValue","value":{"val":"Alice"}}'::jsonb)),
q4 AS
 (-- GetEdges: (f)-[e2:KNOWS]->(foaf) | attributes: foaf.name
  SELECT "f", "e2", "foaf", (SELECT value FROM vertex_property WHERE parent = "foaf" AND key = 'name') AS "foaf.name" FROM
    (
      SELECT "from" AS "f", edge_id AS "e2", "to" AS "foaf" FROM edge
      WHERE type IN ('KNOWS')
    ) subquery),
q5 AS
 (-- GetEdges: (f)<-[e2:KNOWS]-(foaf) | attributes: foaf.name
  SELECT "foaf", "e2", "f", (SELECT value FROM vertex_property WHERE parent = "foaf" AND key = 'name') AS "foaf.name" FROM
    (
      SELECT "from" AS "foaf", edge_id AS "e2", "to" AS "f" FROM edge
      WHERE type IN ('KNOWS')
    ) subquery),
q6 AS
 (-- UnionAll: q4 %*$ \color{comment} \cup $*) q5
  SELECT "f", "e2", "foaf", "foaf.name" FROM q4
  UNION ALL
  SELECT "f", "e2", "foaf", "foaf.name" FROM q5),
q7 AS
 (-- EquiJoinLike
  SELECT left_query."p", left_query."p.name", left_query."e1", left_query."f", right_query."e2", right_query."foaf", right_query."foaf.name" FROM
    q3 AS left_query
    INNER JOIN
    q6 AS right_query
  ON left_query."f" = right_query."f"),
q8 AS
 (-- AllDifferent
  SELECT * FROM q7 AS subquery
    WHERE is_unique(ARRAY["e1", "e2"]))
SELECT "foaf.name"
  FROM q8