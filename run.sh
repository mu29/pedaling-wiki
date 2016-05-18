#!/bin/bash
pkill ruby
nohup rackup -p 80 --host 0.0.0.0 &
