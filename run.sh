#!/bin/bash
pkill ruby
nohup RACK_ENV=production rackup -p 80 --host 0.0.0.0 &
