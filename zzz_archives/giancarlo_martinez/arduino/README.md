# Ardunio Project

The longterm goal is to create an animatronic dragon head with various stages (mini projects) of complexity. As this is my first arduino project, I will attempt to break it down into small projects and that consist of examples/tutorials (when a new piece of hardware is introduced) and a new stage of development for the dragon.
The dragon will respond to manual inputs and sensors like light or sound, but also to APIs. 

The first step is learning the arduino's basics. I'll complete tutorials for buttons, potentiometers, photocells and motion sensors in relation to powering standard LEDs and RGB LEDs. Next, i'll apply those inputs to motors (steppers/servos).

Not all work will be coding. Some will be soldering and some steps will require purchasing additional hardware. 

I will also learn how to draw circuits and include them for each new circuit (not for tutorials)

Going to try this out too to keep working with Angular, and then find a way to have the controller speak to the app via wifi
https://medium.com/code-zen/intro-to-iot-with-arduino-firebase-and-angular-js-ea08c70f41ef

##EYES
###Part One: Programming RGB LEDS for the eyes
- Tutorials to learn light sequencing within sketches with standard LEDs, how to identify and use resistors and making lights respond to inputs
- Using potentiometers to change lights on and off, change brightness, change color
- Using photocell as control

###Part Two: Making the eyelids
- Design eyelids (plastic easter egg, hinge from clip)
- Tutorials to learn how to use stepper motors (synchronized)
- hook up steppers to eyelids to respond to manual inputs 
- respond to photocell sensor

###Part Three: Hooking up to WiFi
- Hook up arduino to wifi and test connections to any APIs
- Possibly use Espruino WiFi, code calls in JS
