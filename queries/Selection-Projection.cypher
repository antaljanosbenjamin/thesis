MATCH (p:Person)
WHERE p.age < 30
RETURN DISTINCT p.name AS name