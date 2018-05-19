MATCH (p:Person)
CREATE (p)-[k:KNOWS {since: 2018}]->(c:Person:Student {name: 'Carol'})