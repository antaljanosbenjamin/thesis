MATCH (p:Person {name: 'Alice'})<-[e1:KNOWS]->(f)<-[e2:KNOWS]->(foaf)
RETURN foaf.name