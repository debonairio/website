+++
date = "2016-01-07T22:17:00-08:00"
title = "Windows vs Unix-Like Filesystems and Git"
author = "brandon"
+++

## Introduction
A debonair uses the right tool for the job and has no trouble switching between Windows, Mac, and Linux. 

However moving between different operating systems has its own share of issues, especially when in comes to how files are handle.

## Filesystem Differences
In secure computing, a file has permissions which control who can read, write, and execute the file. Mac OS and other unix-like variants have separate file modes for each of those actions. However, Windows does not have a file mode for executable files, and basically all files are executable.

## The Problem
When developing and colloborating on scripts that need to be run on Windows, Mac OS, and *nix systems, a Windows developer does not have to make a file executable in order to run it. However, if they were to check it into a Git repo, any *nix user would not be able to run that file until they chmod +x the file, adding the executable bit. This is highly inefficient, as every *nix user would have to do this.

## The Fix
Once a file is commited, a windows developer can run this command to add executable permissions:
`git update-index --chmod=+x file.sh`
Voila! Now any developer cloning the repository can run the file without any hassle.

