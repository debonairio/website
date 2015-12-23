+++
date = "2015-12-22T11:23:00-08:00"
title = "Database Collation"
tags = ["debonair-deep-dive"]
author = "brandon"
+++

##Background
I was having an interesting discussion with some fellow debonairs regarding database normalization. The discussion took a technical turn and we got on the topic of whether an integer search in a database is faster than a string search.

I took a stroll down memory lane and I remember my database professor mentioning that integer searches are faster, but I could not remember why.

A google search revealed this article on [StackOverflow](http://stackoverflow.com/questions/2346920/sql-select-speed-int-vs-varchar).
In short, collation causes integer searches to be faster than string searches.

Collation are rules that determine how characters are compared. When a computer works with characters and strings, it needs to first convert that into a binary representation. For example, if we have four characters, 'A', 'B', 'a', 'b' (note the different case), each of these characters would be represented by a number. 'A' might be represented by 0, 'B' by 1, 'a' by 2, 'b' by 3 and so forth.

However, you may want to treat your search case insensitive, and so you may use a collation that makes 'A' and 'a' return the same value. The process of converting a character into his numerical value adds additional overhead and causes integer searches to be faster than string searches.

All this theory is fascinating, but as any disquisitive debonair should, I decided to take a deeper dive and run an unscientific experiment.

##Unscientific Experiment
I decided to come with a little unscientific experiment where I would create a two database tables. Each would have randomly generated data, but one would have a column with integers and another with string.

I found a tool called [generatedata.com](http://www.generatedata.com/) which I could use to generate the data. The demo version would not let me generate more than 1000 rows, but the source code of the app is on GitHub. I was able to use the [Vagrant packaged version](https://github.com/benkeen/generatedata-vagrant) and I generated two sets of data, each containing 100,000 rows. One with an [integer column](https://gist.github.com/chothia/5a8280f0c6b08b22a1d8) and the other with a [string column](https://gist.github.com/chothia/4eb61c4bd0b5a0450360).

I first started a postgres docker container:
- docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres 

I used the following commands to load the data from the sql files. If you are using docker-machine, use the commands docker-machine ip nameOfYourMachine and replace 192.168.99.100 with your ip. If you are on linux, the container is probably running on localhost.
- psql -h 192.168.99.100 -U postgres -f string-values.sql
- psql -h 192.168.99.100 -U postgres -f integer-values.sql

Once the data is loaded, I then used the psql client to connect to the database. To time the queries I ran:
- \timing
and then to turn off paging:
- \pset pager off

I then ran the following queries a few times and took an average:
- select * from normalization_test_2 where app_id = 1;
- select * from normalization_test where app_id = 'AAAAAAAAAAAAAAAA';

The query with an interger search took about 62 ms, and the query with a string search took about 78 ms. It looks like integer searches are a bit faster.

I added indexes to each column and repeated the queries.
- create index on normalization_test(app_id);
- create index on normalization_test_2(app_id);

The query with an interger search (indexed) took about 59 ms, and the query with a string search took about 74 ms. It looks like integer searches are still a bit faster.

While this was a bit of an unscientific test, it does show that in this case integer searches are faster than string searches. 
