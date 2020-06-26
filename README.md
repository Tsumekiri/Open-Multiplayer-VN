# Open Multiplayer VN

This is an on-going refactor of my [previous version](https://gitlab.com/Yohaulticetl/open-multiplayer-vn). It changes the code to be more modular, comprehensible and maintainable. Once that is done, focus will be set to making better server administration tools.

It's made in the Godot engine.

Current font: [Roboto](https://fonts.google.com/specimen/Roboto), change the theme in the Resources folder if you wish to set another main font.

## Features
  
### What is present  
  

* Usage of characters with their expressions (.png images)
* Usage of animated characters through .png sequences (automatically detects those with the name ending in _1.png, or whatever is the number of the frame)
* Usage of backgrounds and animated backgrounds (including .bmp, .jpg, .png, sequences of images)
* Usage of videos, especially background videos (.webm and .ogv formats)
* Usage of background music and sound effects (.wav and .ogg)
* Displaying multiple characters on the screen at one time
* Permission settings based on roles
* Sending and receiving text, with the appropriate settings above

### What is missing

* Basic security features
* Administration features (such as banning, muting one specific player and so on)
* File sharing for automatic updating of resources based on the server
* Features for proper tabletop RPG playing, such as character sheets and dice rolling
* Control for the animation speed of sprites (frames per second)
