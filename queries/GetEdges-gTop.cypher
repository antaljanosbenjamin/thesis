MATCH (p)-[l:LIKES]->(m:Message)
RETURN m.content, l.creationDate