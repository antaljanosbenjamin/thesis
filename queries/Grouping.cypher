MATCH (p:Person)
WITH p, p.name AS name
UNWIND p.speaks AS lang
RETURN lang, collect(name) AS speakers