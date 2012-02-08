```
		 ___                                .-.     
		(   )                              /    \   
	  .-.| |    .--.     .--.      .---.   | .`. ;  
	 /   \ |   /    \   /    \    / .-, \  | |(___) 
	|  .-. |  |  .-. ; |  .-. ;  (__) ; |  | |_     
	| |  | |  |  | | | |  |(___)   .'`  | (   __)   
	| |  | |  |  |/  | |  |       / .'| |  | |      
	| |  | |  |  ' _.' |  | ___  | /  | |  | |      
	| '  | |  |  .'.-. |  '(   ) ; |  ; |  | |      
	' `-'  /  '  `-' / '  `-' |  ' `-'  |  | |      
	 `.__,'    `.__.'   `.__,'   `.__.'_. (___)
```
 
 Decaf
=========

This package provides a SliM server implementing the [FitNesse](http://fitnesse.org)
[SliM protocol](http://fitnesse.org/FitNesse.UserGuide.SliM.SlimProtocol). It allows
you to write test fixtures in CoffeeScript or JavaScript, and invoke them from a FitNesse test.

 Setup
-----

Put these commands in a parent of the Decaf test pages.

    !define TEST_SYSTEM {slim}
    !define COMMAND_PATTERN {decaf.cmd %p}
