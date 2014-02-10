cd slim
start chrome http://localhost:8080/root
java -Xmx100M -jar fitnesse.jar -o -e 0 -p 8080 %1 %2 %3 %4 %5
pause

