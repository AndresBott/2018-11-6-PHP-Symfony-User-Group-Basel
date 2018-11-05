#!/usr/bin/env bash

#Backgroun PID
#echo "version: $BASH_VERSION"
#function abc() # wait for some event to happen, can be terminated by other process
#{
#          echo "inside a subshell $BASHPID" # This gives you the PID of the current instance of Bash.
#          sleep 3333
#}
#
#echo "PID: $$" # (i)
#abc &
#echo "PID: $$" # (ii)
#echo "another way $!" # This gives you the PID of the last job run in background
#echo "same than (i) and (ii) $BASHPID" # This should print the same result than (i) and (ii)
#

run ab with N defined concurent and huge a