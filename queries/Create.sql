WITH q0 AS ( /* GetVertices: (p:Person) */ ),
q1 AS ( -- GenerateId
  SELECT *, nextval('vertex_seq') AS "c" FROM q0),
q2 AS ( -- InsertVertex
  INSERT INTO vertex SELECT "c" AS vertex_id FROM q1),
q3 AS ( -- InsertLabels
  INSERT INTO label SELECT q1."c" AS parent, labels.l AS name
                    FROM q1, (VALUES ('Person'), ('Student')) AS labels(l)),
q4 AS ( -- InsertVertexProperty
  INSERT INTO vertex_property
    SELECT "c" AS parent, 'name' AS key, 'Carol' AS value FROM q1),
q5 AS ( -- GenerateId
  SELECT *, nextval('edge_seq') AS "k" FROM q1),
q6 AS ( -- InsertEdge
  INSERT INTO edge
    SELECT "k" AS edge_id, "p" AS "from", "c" AS "to", 'KNOWS' AS type FROM q5),
q7 AS ( -- InsertEdgeProperty
  INSERT INTO edge_property
    SELECT "k" AS parent, 'since' AS key, 2018 AS value FROM q5)
SELECT "p", "k", "c" FROM q5