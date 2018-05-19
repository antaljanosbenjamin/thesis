SELECT vertex_id AS "p",
      (SELECT "value" FROM vertex_property
       WHERE parent = vertex_id AND key = 'name') AS "p.name"
FROM vertex
WHERE NOT EXISTS(VALUES ('Person'), ('Student')
                 EXCEPT ALL
                 SELECT name FROM label WHERE parent = vertex_id)