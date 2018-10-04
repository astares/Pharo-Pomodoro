"
A morph to implement Pomodoro
"
Class {
	#name : #PomodoroMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'pomodoro',
		'displayClock',
		'stopWatch',
		'progressBar',
		'pauseButton',
		'isMinimized',
		'isActive',
		'startButton'
	],
	#classInstVars : [
		'menuIcon'
	],
	#category : #'Pomodoro-Core-UI'
}

{ #category : #private }
PomodoroMorph class >> createMenuIcon [ 

	^Form fromBinaryStream: self menuIconContent base64Decoded readStream
]

{ #category : #'world menu' }
PomodoroMorph class >> menuCommandOn: aBuilder [ 
	"Add a custom menu item to the world menu"	
	<worldMenu> 
	
	(aBuilder item: #'Pomodoro')
	       icon: self menuIcon;  
			 parent: #'Tools';
			 help: 'Open Pomodoro';
			 action: [ self new openInWorld ].
]

{ #category : #accessing }
PomodoroMorph class >> menuIcon [
	"Cache the menu item"
	
	menuIcon isNil ifTrue: [ menuIcon := self createMenuIcon ].
	^menuIcon 
 
]

{ #category : #private }
PomodoroMorph class >> menuIconContent [
	"
	(Base64MimeConverter mimeEncode: (FileStream readOnlyFileNamed: 'pomodoro.png') binary) contents
	"
	
	^'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAADL0lEQVQ4y3WTSWwbdRjFfzNj
z4wdx3az2InTpKFNo6RKDvRAynKp2rRRISKKUA9IILEcekIcOAHqKVJPCCEkLlxYpBaBKCA2
tYUDkRAKjdQlNBVum8StE9uxE29jz3/Gs3AIiipR3uXTk973Tr8H/6NSo5D8ZOWzd2zPDgLY
rtAelZMeNo7bUi7c/OjcUme1z1Zs/ZtrP85MT5xMm6IZ8rP3Oufaz7yaGpv+6pEFTrXU8eD8
2ffeKF55Oae5cqtHg70RhuJJVr9L07awyXi/5n3gDywqZz9/Sd43kt4tsLfy3aVXjs4vFHMj
mQcGloC657L1wmN0LhY5VqjTHwAF6FFBHUwW+PSPCSW1PyMBZN+a/Vq7tT7bmRoCYYLrsp1b
I7tyA8eDzgCEZQhJ0NadgkoO48TkpdiHl6cCtXt/ja6dGpsZOXIav1qhZVu0XBdHDmJ6Ego+
hgceoPUOIj35LIgqrd++mDTXlocDhd9/OR5wkM3cfRQtQqG8SXZjlUajjgSoErg++D4kEoNI
toUfSyIfmZbrS38+FbDK210hNcja6i0Id3A/n8H2d55kwJHAB2QJNm7Msy8URtVC+N39WKbo
kouu6qwrEYSok8lnaHjQ9MD0QPhg+jtXeGC5HvW71/BCOvmlBQzRsuS9B/enr5cMloVMUIH2
4UO4QAsgEiP6+ARSvAupPUawd4BAopvFn86TvX2dxOCBO4G+p4//2q5LVtgJait6DHejgOdJ
aJKPJnm4TgtLUWgYTco0yDVMDsom4bhWjR5+Zl4OdyRK+snZixXbImFs0ocgkUgQiHdhhmKU
Slu4tk2qTWfUrzNuF3GFgXXqxQvBSLQpA4y+9ub76x09+XUHyo0G5nYBqVaiO5Uk0deLapSx
a9sYlk3Jhb8Hhu6oz7/+8S6JQgj1yvffzlw99+6cmrl7ICQhK0CAHfr0fyGSJTzn8BOLe868
PXf0xNQlXdft3S0IIdTby8uHrl788nR+/vKkWE2PeIYRBtDiHZXo6NhSz+RzP4wfm/p5eHg4
ret66z9rBGg2m1qtVotWKpU9jWolJsmyG4nFa/F4vBKNRmu6rtsP5/8B8kBudJ3n+60AAAAA
SUVORK5CYII='
]

{ #category : #'instance creation' }
PomodoroMorph class >> on: aPomodoro [
	"Return a new instance with the given pomodoro as model"

	^(self new)
		model: aPomodoro;
		yourself
]

{ #category : #'private - accessing' }
PomodoroMorph >> boxExtent [
	^14 @ 14
]

{ #category : #'private - menu' }
PomodoroMorph >> buildWindowMenu [
	"Answer the menu to be put up in response to the user's clicking on the window-menu control in the window title."

	| aMenu |
	aMenu := UIManager default
					newMenuIn: self for: self.
	aMenu add: 'Open settings...' selector: #openSettings.	 
	aMenu add: 'Set time' selector: #setTime.		
	aMenu add: 'Set action' selector: #setAction.				
	^aMenu
]

{ #category : #updating }
PomodoroMorph >> changed [
	super changed.
	self updateClock.
	self updateProgressBar.
	self updateButtons
	
	
]

{ #category : #actions }
PomodoroMorph >> closeBoxHit [

	self stop.
	self delete
]

{ #category : #actions }
PomodoroMorph >> collapseBoxHit [
	self minimize
]

{ #category : #'private - accessing' }
PomodoroMorph >> displayClock [
	displayClock ifNil: [ displayClock := self initialClockTextMorph ].
	^displayClock
]

{ #category : #'private - initialization' }
PomodoroMorph >> initButtons [
	| stopButton |
	startButton  := PluggableButtonMorph
					on: self
					getState: #startButtonEnabled
					action: #start.
	startButton label: 'Start'.		
						
	stopButton := 	PluggableButtonMorph
					on: self
					getState: #stopButtonEnabled
					action: #stop.								
	stopButton label: 'Stop'.

	pauseButton := 	PluggableButtonMorph
					on: self
					getState: #pauseButtonEnabled
					action: #pause.								
	pauseButton label: 'Pause'; position: 100@(self extent y - 30).
			 
	self 
		addMorph: startButton fullFrame: #(0 1 0.33 1 5 -35 -5 -10) asLayoutFrame;
		addMorph: stopButton fullFrame: #(0.33 1 0.66 1 5 -35 -5 -10) asLayoutFrame;
 		addMorph: pauseButton fullFrame: #(0.66 1 1 1 5 -35 -5 -10) asLayoutFrame.
	
 
]

{ #category : #'private - initialization' }
PomodoroMorph >> initClock [
	|clock|
	clock := self displayClock.	 
	self addMorph: clock fullFrame: {0.5. 0. 0.5. 0.5. (clock extent x) negated. 5. 0. 0.} asLayoutFrame.
 
]

{ #category : #'private - initialization' }
PomodoroMorph >> initCloseBox [

	| closeBox ext |
	closeBox := self theme createCloseBoxFor: self.
	ext := self boxExtent.
	self addMorph: closeBox fullFrame: {0. 0. 0. 0. 2. 2. 2 + ext x. 2 + ext y.} asLayoutFrame.
]

{ #category : #'private - initialization' }
PomodoroMorph >> initCollapseBox [

	| collapseBox ext |
	collapseBox := self theme createCollapseBoxFor: self.
	ext := self boxExtent.
	self addMorph: collapseBox fullFrame: {0. 0. 0. 0. 2 + ext x. 2. 2 + (ext x * 2). 2 + ext y.} asLayoutFrame.
	
 
	 
]

{ #category : #'private - initialization' }
PomodoroMorph >> initMenuBox [

	| menuBox ext |
	menuBox := self theme createMenuBoxFor: self.
	ext := self boxExtent.
	self addMorph: menuBox fullFrame: {1. 0. 1. 0. (2 + ext x) negated. 2. 0. 2 + ext y.} asLayoutFrame.
	
 
	 
]

{ #category : #'private - initialization' }
PomodoroMorph >> initMorph [
	self changeProportionalLayout.
	self stopStepping.
	self color: self standardColor.
	self
		 borderRaised;
		 extent: 200@105.
]

{ #category : #'private - initialization' }
PomodoroMorph >> initProgressBar [
	|pb top |
	pb := self progressBar.
	top :=  (self displayClock extent y * 2).
	self addMorph: pb fullFrame: {0. 0. 1. 1. 5. top. -5. -45.} asLayoutFrame.
	pb barFillStyle: PomodoroSettings progressBarColor
	 
]

{ #category : #'private - accessing' }
PomodoroMorph >> initialClockTextMorph [ 

	^(TextMorph new) 
		contents: '00:00'; 
		font: (LogicalFont familyName: 'Source Sans Pro' pointSize: 20);
		lock;
		yourself
]

{ #category : #initialization }
PomodoroMorph >> initialize [
	"Initializes the receiver"
	
	super initialize.	
	isMinimized := false.
	isActive := true.
 	self 
		initMorph;
		initCloseBox;
		initCollapseBox;
		initMenuBox;
		initClock;
		initProgressBar;
		initButtons
 
	
]

{ #category : #'private - accessing' }
PomodoroMorph >> isActive [
	^ isActive
]

{ #category : #'private - accessing' }
PomodoroMorph >> isActive: aBoolean [
	isActive := aBoolean
]

{ #category : #testing }
PomodoroMorph >> isCollapsed [
	^self isMinimized
]

{ #category : #testing }
PomodoroMorph >> isMaximized [
	^self isMinimized not
]

{ #category : #testing }
PomodoroMorph >> isMinimized [
	^ isMinimized
]

{ #category : #'private - accessing' }
PomodoroMorph >> isMinimized: aBoolean [
	isMinimized := aBoolean.
	isMinimized ifTrue: [ self hide ] 
]

{ #category : #'private - events' }
PomodoroMorph >> maximize [ 
	isMinimized ifTrue: [ 
		self comeToFront; 
		show. 
		isMinimized := false] 
]

{ #category : #'private - events' }
PomodoroMorph >> minimize [
	self isMinimized ifFalse: [ 
		self isMinimized: true.
		self isActive: false] 
]

{ #category : #accessing }
PomodoroMorph >> model [
	pomodoro isNil ifTrue: [ pomodoro := self modelClass new ].
	^pomodoro 
]

{ #category : #accessing }
PomodoroMorph >> model: aModel [

	pomodoro := aModel.
	self changed
	 
]

{ #category : #'private - accessing' }
PomodoroMorph >> modelClass [

	^Pomodoro
]

{ #category : #'private - menu' }
PomodoroMorph >> offerWindowMenu [
	"Popup the window menu."
	
	| aMenu |
	aMenu := self buildWindowMenu.
	aMenu popUpEvent: self currentEvent in: self world
]

{ #category : #'private - events' }
PomodoroMorph >> onFinished [

	self color: PomodoroSettings finishedColor.
	self stopStepping.
	self model finish.
	self stopWatch suspend

]

{ #category : #'private - events' }
PomodoroMorph >> onStepping [
 
	self model alreadyElapsed: self stopWatch duration.
	self changed
]

{ #category : #actions }
PomodoroMorph >> openSettings [
	PomodoroSettings open
]

{ #category : #actions }
PomodoroMorph >> pause [
	self model isReady ifTrue: [ ^self ].
	self model isPaused 
		ifTrue: [ 
			self color: self standardColor.
			self model start ]
		ifFalse: [
			self color: PomodoroSettings pauseColor.
			self model pause ].
	self changed
]

{ #category : #testing }
PomodoroMorph >> pauseButtonEnabled [
	^self model isActive
]

{ #category : #'private - accessing' }
PomodoroMorph >> progressBar [
	progressBar ifNil: [ progressBar := ProgressBarMorph new ].
	^progressBar
]

{ #category : #actions }
PomodoroMorph >> reset [
	self model reset.
	self color: (UITheme current paneColorFor: self).
	
]

{ #category : #actions }
PomodoroMorph >> restore [
	self isMinimized ifTrue: [ 
		self maximize.  
		self activate ] 
	ifFalse: [ self minimize ]
]

{ #category : #actions }
PomodoroMorph >> setAction [
	|action|
	self stop.
	action := UIManager default
					request: 'Enter action expression'
					initialAnswer: 'WebBrowser openOn: ''http://www.pharo.org'''
					title: 'Set action'.
	action ifNil: [ ^self ].		
	action	 := '[', action, ']'.
	self model finishedAction: (self class compiler evaluate: action).
	self changed.
	
]

{ #category : #actions }
PomodoroMorph >> setTime [
	|time|
	self stop.
	time := UIManager default
					request: 'Enter time'
					initialAnswer: '5 minutes'
					title: 'Set time'.
	time ifNil: [ ^self ].				
	self model totalDuration: (self class compiler evaluate: time).
	self changed.
	
]

{ #category : #'private - accessing' }
PomodoroMorph >> standardColor [

	^(UITheme current paneColorFor: self)
]

{ #category : #actions }
PomodoroMorph >> start [
	super start.
 	self reset.
	self color: self standardColor.
	self model start.
	self changed
	
	 
]

{ #category : #testing }
PomodoroMorph >> startButtonEnabled [
	^self model isActive not
]

{ #category : #updating }
PomodoroMorph >> step [
	"Do a step"
	 
	(self stopWatch duration roundTo: 0.5 seconds) >= self model totalDuration 
		ifTrue: [ self onFinished ]
		ifFalse: [ self onStepping ]
			
]

{ #category : #updating }
PomodoroMorph >> stepTime [ 
	"Returns the morphs step time - small enough to display seconds"
	
	^500
]

{ #category : #actions }
PomodoroMorph >> stop [	
	super stop.
	self reset.
	self changed
]

{ #category : #testing }
PomodoroMorph >> stopButtonEnabled [
	^self model isActive
]

{ #category : #'private - accessing' }
PomodoroMorph >> stopWatch [
	
	^self model stopWatch 
]

{ #category : #taskbar }
PomodoroMorph >> taskbarButtonClicked [
	"The taskbar button for the receiver has been clicked.
	If minimised then restore.
	If active then minimize.
	Otherwise make active."

	self isMinimized
		ifTrue: [self restore]
		ifFalse: [self isActive
					ifTrue: [self minimize]
					ifFalse: [self isActive: true]]
]

{ #category : #taskbar }
PomodoroMorph >> taskbarButtonEntered: aButton event: evt in: aMorph [
	"Expected by the taskbar. Do nothing"
]

{ #category : #taskbar }
PomodoroMorph >> taskbarButtonFor: aTaskbar [
	"Answer a new task bar button for the receiver.
	Answer nil if not required."

	^(aTaskbar theme
			newTaskbarButtonIn: aTaskbar
			for: self)
			paneColor: self color;
			yourself
			
]

{ #category : #taskbar }
PomodoroMorph >> taskbarButtonLeft: aButton event: evt in: aMorph [
	"Expected by the taskbar. Do nothing"
]

{ #category : #taskbar }
PomodoroMorph >> taskbarButtonMenu: aMenuMorph [ 
	aMenuMorph 
		add: 'Start' selector: #start;
		add: 'Pause' selector: #pause;
		add: 'Stop' selector: #stop;
		addLine;
		add: 'Delete' selector: #delete.
	^aMenuMorph 
]

{ #category : #taskbar }
PomodoroMorph >> taskbarIcon [
	^self class menuIcon 
]

{ #category : #taskbar }
PomodoroMorph >> taskbarLabel [
	^Pomodoro formatDuration: pomodoro remainingDuration 
]

{ #category : #taskbar }
PomodoroMorph >> taskbarState [
	"Answer one of #minimized, #restored, #maximized or #active."

	^self isMinimized
		ifTrue: [#minimized]
		ifFalse: [self isMaximized
			ifTrue: [#maximized]
			ifFalse: [self isActive
						ifTrue: [#active]
						ifFalse: [#restored]]]
]

{ #category : #taskbar }
PomodoroMorph >> taskbarTask [
	"Answer a new taskbar task for the receiver.
	Answer nil if not required."

	(self valueOfProperty: #noTaskbarTask ifAbsent: [false]) ifTrue: [^nil].
	^TaskbarTask
		morph: self
		state: self taskbarState
		icon: self taskbarIcon
		label: self taskbarLabel
]

{ #category : #'private - updating' }
PomodoroMorph >> updateButtons [
	startButton ifNotNil: [:button |
		button 
			label:
				(self model isReady
					ifTrue: [ 'Start' ]
					ifFalse: [ 'Restart' ])].

	pauseButton ifNotNil: [:button |
		button 
			label:
				(self model isPaused
					ifTrue: [ 'Continue' ]
					ifFalse: [ 'Pause' ])].
]

{ #category : #'private - updating' }
PomodoroMorph >> updateClock [
	"Update the clocks contents"
	
	displayClock ifNil: [ ^self ].
	displayClock contents: self model remainingDurationString
	 
]

{ #category : #'private - updating' }
PomodoroMorph >> updateProgressBar [  
	self progressBar endAt: self model totalDuration asSeconds.
	self progressBar value: self model remainingDuration asSeconds.
]
