# Pharo-Pomodoro
Pomodoro Timer for Pharo 

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
