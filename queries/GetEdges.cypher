MATCH (s:Student)-[i:INTEREST]->(t)
RETURN s, i, i.level, t, t.topic