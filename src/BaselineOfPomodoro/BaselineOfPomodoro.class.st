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
				package: 'Pomodoro-Core-Tests' with: [ spec requires: #('Pomodoro-Core') ];
				package: 'Pomodoro-UI-Morphic' with: [ spec requires: #('Pomodoro-Core') ];
				package: 'Pomodoro-UI-Morphic-Tests' with: [ spec requires: #('Pomodoro-UI-Morphic') ].
			
			"Groups"	
			spec	
				group: 'Core' with: #('Pomodoro-Core');
				group: 'UI-Morphic' with: #('Pomodoro-UI-Morphic');
				group: 'Tests' with: #('Pomodoro-Core-Tests' 'Pomodoro-UI-Morphic-Tests');
				group: 'all' with: #('Core' 'UI-Morphic' 'Tests');
				group: 'default' with: #('all') ]
]
