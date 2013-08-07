#!/bin/bash
cd /var/www/html/desarrolladores.com.ni/content_desarrolladores
git pull

CT="Content-Type:text/html"
TEST="curl http://localhost:1934/update -H $CT"
echo $TEST
RESPONSE=`$TEST`
echo $RESPONSE
