# Pharo-Pomodoro
**Pomodoro Timer** for [Pharo](http://www.pharo.org) following the [Pomodoro Technique](http://en.wikipedia.org/wiki/Pomodoro_Technique)

## About
The Pomodoro Timer for Pharo was written by T. Bergmann (Astares). The following people additionally contributed code to it:
- Phillipe Back (compatibility to Dark Theme)
- StephanEggermont (taskbar integration, cleanups)

## Screenshot
![alt text](doc/screenshot.png "Screenshot")

## Video
[![Watch the video](https://img.youtube.com/vi/voSUzOu5feU/hqdefault.jpg)](https://youtu.be/voSUzOu5feU)

## LICENSE
MIT License

# Quick Start
## Installation via Catalog

You can install Pomodoro directly from the Pharo catalog.

## Installation via Script

```Smalltalk
Metacello new 
	repository: 'github://astares/Pharo-Pomodoro/src';
	baseline: 'Pomodoro';
	load
```

# Usage

You can also script the timer to use a different duration or 

Open a new 25 minute timer (default duration)
```Smalltalk
Pomodoro new open        
```

Opens a new timer with one minute total time
```Smalltalk
Pomodoro timerFor: 1 minute
```

Provide an action when Pomodoro is finished
```Smalltalk
Pomodoro 
     timerFor: 5 seconds 
     whenFinishedDo: [ self inform: 'Pomodoro finished']
```

# History and Related
- Original version starting in Pharo 2.0 - [Post to Pharo mailinglist](https://lists.gforge.inria.fr/pipermail/pharo-project/2013-March/076598.html)
- [Original announcement on Astares blog](https://astares.blogspot.com/2013/03/pomodoro-for-pharo-20.html)
- Initial [repo on SmalltalkHub](http://smalltalkhub.com/#!/~TorstenBergmann/Pomodoro)
- Initial [video on youtube](https://www.youtube.com/watch?v=w00IBi9iM2Y)
- Video from [Stephan on Vimeo](https://vimeo.com/160902072) 
- Updated [video on youtube](https://www.youtube.com/watch?v=voSUzOu5feU)
