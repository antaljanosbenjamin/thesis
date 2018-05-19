WITH q0 AS ( /* GetVertices: (p:Person) | attributes: p.name */ ),
q1 AS ( /* Selection: p.name = 'Bob' */ ),
...
q4 AS ( /* GetEdges: (current_from)<-[current_edge:KNOWS]->(current_to) */ ),
q5 AS ( -- TransitiveJoin
  WITH RECURSIVE recursive_table AS (
    SELECT "p"               AS start_vertex,
           ARRAY[]::BIGINT[] AS edge_list,
           "p"               AS end_vertex,
           "p.name"
    FROM q1
    UNION ALL
    SELECT start_vertex,
           (edge_list || current_edge),
           current_to AS end_vertex,
           "p.name"
    FROM q4 INNER JOIN recursive_table
            ON "current_edge" <> ALL (edge_list) AND
               end_vertex = current_from         AND
               array_length(edge_list) < 6)
  SELECT start_vertex AS "p",
         edge_list    AS "el",
         end_vertex   AS "foaf",
         "p.name"
  FROM recursive_table
  WHERE array_length(edge_list) >= 1),
q6 AS ( /* GetVertices: (foaf) | attributes: foaf.name */ ),
q7 AS ( /* Join: q5 %*$ \color{comment} \join $*) q6 */ ),
q8 AS ( -- AllDifferent
  SELECT * FROM q7)
-- Projection
SELECT "foaf.name" FROM q8