#!/bin/sh

cd slim
open http://localhost:8080/root
java -Xmx100M -jar fitnesse.jar -o -e 0 -p 8080

