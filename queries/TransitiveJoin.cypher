MATCH (p:Person {name: 'Bob'})<-[el:KNOWS*1..6]->(foaf)
RETURN foaf.name