WITH q0 AS ( -- GetEdges
  SELECT
    make_vertex_id('person', edgeTable."personId") AS "p",
    make_edge_id('LIKES', edgeTable."personId", edgeTable."postId") AS "l",
    make_vertex_id('post', edgeTable."postId") AS "m",
    toTable."content" AS "m.content",
    edgeTable."creationDate" AS "l.creationDate"
  FROM "person_LIKES_post" edgeTable
         JOIN "post" toTable ON (edgeTable."postId" = toTable."id")),
q1 AS ( /* GetEdges: (p:Person)-[l:LIKES]->(m:Comment)
            attributes: m.content, l.creationDate */ ),
q2 AS ( /* UnionAll: q0 %*$ \color{comment} \cup $*) q1 */ )
-- Projection
SELECT "m.content", "l.creationDate" FROM q2