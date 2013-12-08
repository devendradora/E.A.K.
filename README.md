Erase All Kittens (v2)
======================

The next version of Erase All Kittens. The current version, in the master branch on Github, is a mess. This is an (almost) complete rewrite, to provide the following:

* A new, custom physics engine. Box2D was great for us to get started with, but has a number of issues:
    * No support for changing shapes (so most CSS animations / transforms would go out the window)
    * Player movement sucks. With Box2D, we found that modeling the player as a ball was the least worst option for control. The new physics engine will let us write completely custom player movement and control code, so we have a game that *feels* great to play
    * Overkill. Box2D is really good at accurate simulations of 2D physics, but it's way beyond what we need for this game. Our own engine will be stripped back, minimal, and fast

* Localization from the very start. We're using Transifex to make sure that EAK is available to as many people as possible

More info coming soon! :)
