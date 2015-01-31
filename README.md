# Introduction

This is my first project with the Godot engine.

Since I'm definitely not an artist, I had to "borrow" the following:
- all sprites are from "Space Shooter" assets by Kenney Vleugels (http://www.kenney.nl)
- the music is part of Robson Cozendey "Sci-fi Music Pack" (http://www.cozendey.com)
- the font is D3-Globalism from DigitalDreamDesign (http://www.fontspace.com/digitaldreamdesign/d3-globalism)
- a huge part of my understanding of Godot came from Calum Knott's "building
  a space shooter" tutorial (https://www.youtube.com/watch?v=c-x_sJVJQRQ)
  
# Features and Design

The game consists of 2 main scenes:
* the title, that I wrote to test UI stuff, transitions between different menu pages etc.
* the game, that is meant for testing 2D stuff, collisions, etc.

I tried to implement an object-oriented approach and create scenes for all objects and make
them as independent as possible (to be honest, I'm not quite sure if this is a good choice,
but we'll see how this scales as the number of objects grows).
Thus, there are scenes for:
* all types of meteors (they share the same GDScript code)
* dust clouds that show when meteors are destroyed
* lasers (thrown by the player ship)
* the universe (the 2d scene that contains all objects)
* the "Player" spaceship should also be a scene but I did not implement that yet

# Ideas for the future

* Make it possible to remap keys
* Make it possible to choose different ships (the current one may have less HP) with different speeds, damage, HP etc.
* Add more enemies
* Add drops and power-ups
* Add weapon mechanics (overheat) to prevent "spray and pray"
* Environmental effects (solar flares, black holes, nebulas, asteroid fields...)
* The game might crash when a meteor is destroyed by an already destroyed foe (due to the foe's reference being used by the meteor's code)
* It's very likely that meteors that are not destroyed will indefinitely travel through space. Fix this.
