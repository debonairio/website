+++
date = "2015-12-22T11:23:00-08:00"
title = "Database Collation"
tags = ["debonair-deep-dive"]
author = "brandon"
draft=true
+++

##Background
I was having an interesting discussion with some fellow debonairs regarding database normalization. The discussion took a technical turn and we got on the topic of whether an integer search in a database is faster than a string search.

I took a stroll down memory lane and I remember my database professor mentioning that integer searches are faster, but I could not remember why.

A google search revealed this article on [StackOverflow](http://stackoverflow.com/questions/2346920/sql-select-speed-int-vs-varchar).
In short, collation causes integer searches to be faster than string searches.

Collation are rules that determine how characters are compared. When a computer works with characters and strings, it needs to first convert that into a binary representation. For example, if we have four characters, 'A', 'B', 'a', 'b' (note the different case), each of these characters would be represented by a number. 'A' might be represented by 0, 'B' by 1, 'a' by 2, 'b' by 3 and so forth.

However, you may want to treat your search case insensitive, and so you may use a collation that makes 'A' and 'a' return the same value. The process of converting a character into his numerical value adds additional overhead and causes integer searches to be faster than string searches.

All this theory is fascinating, but as any disquisitive debonair should, I decided to take a deeper dive and run an unscientific experiment.