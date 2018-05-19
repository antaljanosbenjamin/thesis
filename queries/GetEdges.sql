SELECT "from" AS "s", edge_id AS "i", "to" AS "t",
      (SELECT "value" FROM edge_property
       WHERE parent = edge_id AND key = 'level') AS "i.level",
      (SELECT "value" FROM vertex_property
       WHERE parent = "to"    AND key = 'topic') AS "t.topic"
FROM edge
WHERE type IN ('INTEREST') AND
      NOT EXISTS(VALUES ('Student')
                 EXCEPT ALL
                 SELECT name FROM label WHERE parent = "from")