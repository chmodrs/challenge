#!/bin/bash

IP=`curl ipinfo.io/ip`/

apt-get install -y apache2-utils

echo "Stress NGINX: 50 users 2 connections for each"
ab -n 100 -c 50 -k $IP

echo "Stress NGINX: 50 users 30 connections for each"
ab -n 1500 -c 50 -k $IP

echo "Stress NGINX: 50 users 100 connections for each"
ab -n 5000 -c 50 -k $IP

echo "Stress NGINX: 100 users 100 connections for each"
ab -n 10000 -c 100 -k $IP

echo "Stress NGINX: 100 users 200 connections for each"
ab -n 20000 -c 100 -k $IP

echo "Stress NGINX: 100 users 500 connections for each"
ab -n 50000 -c 100 -k $IP

echo "Stress NGINX: 100 users 1000 connections for each"
ab -n 100000 -c 100 -k $IP

echo "Stress NGINX: 100 users 2000 connections for each"
ab -n 200000 -c 100 -k $IP

echo "Stress NGINX: 500 users 1000 connections for each"
ab -n 500000 -c 500 -k $IP

echo "Stress NGINX: 10000 users 2 connections for each"
ab -n 20000 -c 10000 -k $IP

echo "Stress NGINX: 500000 users 1 connections for each"
ab -n 500000 -c 500000 -k $IP
