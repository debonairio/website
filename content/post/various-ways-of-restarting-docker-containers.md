+++
date = "2016-02-29T22:30:00-07:00"
title = "Various Ways of Restarting Docker Containers"
tags = ["stylish-stacks"]
author = "brandon"
+++

When running docker containers, it's important to be aware that both the container and server can crash at any time. When either of these events occur, containers are not automatically brought back up.

If running Docker on a single host, the [--restart flag](https://docs.docker.com/engine/reference/run/#restart-policies-restart) can be passed in as an option to the docker run command.	
`docker run --restart=always image`
This should cause the container to restart when a crash happens.

If running docker in a swarm cluster, there is a new [experimental feature in Docker Swarm 1.1](https://blog.docker.com/2016/02/docker-1-10/) that will rebalance containers. The current way of doing this is to pass an environment variable to the docker run command.
`docker run -e reschedule:on-node-failure image`
However, at the time of writing, this is still experimental and so docker swarm must be run in [experimental mode](https://github.com/docker/swarm/tree/master/experimental).
`docker run swarm -experimental manage`
`docker run swarm -experimental join`

Alternatives to using the built in Docker / Swarm restart features include process managers like systemd, upstart, or supervisor. These are useful if non docker processes are dependent on docker containers, and/or you want to take advantage of process manager features that handle dependencies.

The Debonair.io stack uses CoreOS on [DigitalOcean](https://m.do.co/c/8e02ffbe63ad) and so systemd is used to restart containers. The current debonair.io systemd file can be found on [GitHub](https://github.com/debonairio/website/blob/089bb0731ff8f0df34161177bb004cbe520345d4/coreos/debonair.io.website.service)
