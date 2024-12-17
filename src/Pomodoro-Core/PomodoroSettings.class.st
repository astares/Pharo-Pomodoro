"
Settings for the pomodoro
"
Class {
	#name : 'PomodoroSettings',
	#superclass : 'Object',
	#classVars : [
		'DefaultTimeInMinutes',
		'FinishedColor',
		'PauseColor',
		'ProgressBarColor'
	],
	#category : 'Pomodoro-Core-Settings',
	#package : 'Pomodoro-Core',
	#tag : 'Settings'
}

{ #category : 'accessing - defaults' }
PomodoroSettings class >> defaultProgressBarColor [

	^ SystemVersion current major > 10 
			ifTrue: [  Smalltalk ui theme lightSelectionColor ]
			ifFalse: [ Smalltalk ui theme class lightSelectionColor ]
]

{ #category : 'accessing' }
PomodoroSettings class >> defaultTimeInMinutes [

	^ DefaultTimeInMinutes ifNil: [ DefaultTimeInMinutes := 25 ]
]

{ #category : 'accessing' }
PomodoroSettings class >> defaultTimeInMinutes: anInteger [

	DefaultTimeInMinutes := anInteger
]

{ #category : 'accessing' }
PomodoroSettings class >> finishedColor [

	^ FinishedColor ifNil: [ FinishedColor := Color green ]
]

{ #category : 'accessing' }
PomodoroSettings class >> finishedColor: aColor [

	FinishedColor := aColor
]

{ #category : 'actions' }
PomodoroSettings class >> open [
	<script>

	(SettingBrowser forKeywords: #('pomodorosettings')) open
]

{ #category : 'accessing' }
PomodoroSettings class >> pauseColor [

	^ PauseColor ifNil: [ PauseColor := Color red ]
]

{ #category : 'accessing' }
PomodoroSettings class >> pauseColor: aColor [

	PauseColor := aColor
]

{ #category : 'settings' }
PomodoroSettings class >> pomodoroSettingsOn: aBuilder [
	<systemsettings>
	<pomodorosettings>

	(aBuilder group: #pomodoroSettings)
		label: 'Pomodoro';
		description: 'All settings for Pomodoro timer';
		with: [
			(aBuilder setting: #progressBarColor)
				label: 'Progress bar color';
				description: 'The progress bar color to use'.
			(aBuilder setting: #pauseColor)
				label: 'Pause color';
				description: 'The color to indicate timer pause'.
			(aBuilder setting: #finishedColor)
				label: 'Finished color';
				description: 'The color to indicate timer has finished'.
			(aBuilder setting: #defaultTimeInMinutes)
				label: 'Default time (minutes)';
				description: 'The default time in minutes' ];
		dialog: [
			SimpleButtonMorph new
				target: Pomodoro;
				label: 'Open new timer';
				actionSelector: #open;
				themeChanged;
				yourself ]
]

{ #category : 'accessing' }
PomodoroSettings class >> progressBarColor [

	^ ProgressBarColor ifNil: [
		  ProgressBarColor := self defaultProgressBarColor ]
]

{ #category : 'accessing' }
PomodoroSettings class >> progressBarColor: anObject [

	ProgressBarColor := anObject
]

{ #category : 'class initialization' }
PomodoroSettings class >> reset [
	<script>

	ProgressBarColor := nil.
	PauseColor := nil.
	FinishedColor := nil.
	DefaultTimeInMinutes := 25
]
