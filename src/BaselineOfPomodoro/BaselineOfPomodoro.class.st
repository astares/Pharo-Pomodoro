"
A baseline for Astares implementation of Pomodoro timer for Pharo 
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
				package: 'Pomodoro-Tests-Core' with: [ spec requires: #('Pomodoro-Core') ].
			
			"Groups"	
			spec	
				group: 'Core' with: #('Pomodoro-Core');
				group: 'Tests' with: #('Pomodoro-Tests-Core');
				group: 'all' with: #('Core' 'Tests');
				group: 'default' with: #('all') ]
]
