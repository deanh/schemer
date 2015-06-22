# Little Schemer Book Club

This is the scratch dir for a Little Schemer reading club. The ```racket``` dir
contains chapter by chapter implementations in Racket. The ```js``` dir contains
one large file with functions implemented in JavaScript.

## Playing in DrRacket

We define ```atom?``` (which is necessary for the exercises) in ```lib/shared.rkt```. If you open a chapter file in DrRacket, you can access this file by requiring the relative path. Run the code, and play on the REPL.

![DrRacket Screen](img/DrRacket.png)

## Playing with JS in the Browser

Everything for the JS version is included in ```index.html```, you should be able to open the page in your browser and then play in the console.

![Browser Screen](img/Browser.png)

NOTE: functions are currently exported into the global namespace. Take a look at ```index.html``` and ```js/little-jser.js``` for details.
