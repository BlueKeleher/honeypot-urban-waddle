#!/bin/bash
sudo git add /git
message=`date`
sudo git commit -m "$message"
sudo git push -u origin HEAD:hp
