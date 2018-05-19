MATCH (p:Person)
OPTIONAL MATCH (p)-[i:INTEREST]->(t:Tag)
WHERE i.level > 3
RETURN p.name, t.topic