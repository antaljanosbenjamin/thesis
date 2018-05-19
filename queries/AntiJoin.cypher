MATCH (c:Class)
WHERE NOT (c)-[:SUBCLASS_OF]->()
RETURN c.subject