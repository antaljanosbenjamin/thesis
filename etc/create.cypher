CREATE
(:Person {id: 'b', name: 'Bob', age: 53, speaks: ['en', 'de']})
<-[:KNOWS {id: 1, since: 2014}]-
(:Person:Student {id: 'a', name: 'Alice', age: 24, speaks: ['en']})
-[:INTEREST {id: 2, level: 4}]->
(:Tag {id: 'c', topic: 'Neofolk'})
-[:CLASS {id: 3}]->
(:Class {id: 'd', subject: 'Folk'})
-[:SUBCLASS_OF {id: 4}]->
(:Class {id: 'e', subject: 'Music'})
-[:SUBCLASS_OF {id: 5}]->
(:Class {id: 'f', subject: 'Art'})