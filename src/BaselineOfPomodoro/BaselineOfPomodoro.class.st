"
A baseline for Astares implementation of Pomodoro timer for Pharo.

See [https://github.com/astares/Pharo-Pomodoro](https://github.com/astares/Pharo-Pomodoro)
"
Class {
	#name : #BaselineOfPomodoro,
	#superclass : #BaselineOf,
	#category : #BaselineOfPomodoro
}

{ #category : #baseline }
BaselineOfPomodoro >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			"Packages"
			spec 
				package: 'Pomodoro-Core';
				package: 'Pomodoro-Core-Tests' with: [ spec requires: #('Pomodoro-Core') ].
			
			"Groups"	
			spec	
				group: 'Core' with: #('Pomodoro-Core');
				group: 'Tests' with: #('Pomodoro-Core-Tests');
				group: 'all' with: #('Core' 'Tests');
				group: 'default' with: #('all') ]
]
