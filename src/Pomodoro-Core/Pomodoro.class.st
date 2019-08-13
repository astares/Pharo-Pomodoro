"
The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s. The technique uses a timer to break down periods of work into 25-minute intervals called 'Pomodori' (from the Italian word for 'tomatoes') separated by short breaks.

Instance Variables
	duration:		<Duratioon>

duration
	- the duration of a pomodoro

"
Class {
	#name : #Pomodoro,
	#superclass : #Object,
	#instVars : [
		'totalDuration',
		'remainingDuration',
		'finishedAction',
		'state',
		'stopWatch'
	],
	#category : #'Pomodoro-Core-Model'
}

{ #category : #examples }
Pomodoro class >> example1 [
	<example>
	
	self new open
]

{ #category : #examples }
Pomodoro class >> example2 [
	<example>
		
	(self totalDuration: 1 minute) open
]

{ #category : #examples }
Pomodoro class >> example3 [
	<example>
		
	(self totalDuration: 3 seconds)
		finishedAction: [ ClyFullBrowser open ];
		open
]

{ #category : #examples }
Pomodoro class >> example4 [
	<example>
		
	self timerFor: 10 seconds
]

{ #category : #examples }
Pomodoro class >> example5 [
	<example>
		
	self timerFor: 5 seconds 
			     whenFinishedDo: [ self inform: 'Pomodoro finished']
]

{ #category : #'private - formatting' }
Pomodoro class >> formatDuration: aDuration [

	| h m s |
	h := aDuration hours abs.
	m := aDuration minutes abs.
 	s := aDuration seconds abs truncated.
	^String streamContents: [:aStream | 
		"Print hours only if there are hours"
		h > 0 ifTrue: [ 
			h < 10 ifTrue: [ aStream nextPut: $0. ].
			h printOn: aStream. aStream nextPut: $: ].
		
		m < 10 ifTrue: [ aStream nextPut: $0. ].
		m printOn: aStream. aStream nextPut: $:.
		s < 10 ifTrue: [ aStream nextPut: $0. ].
		s printOn: aStream ]
]

{ #category : #'instance creation' }
Pomodoro class >> open [
	<script>
	^self new open
]

{ #category : #'instance creation' }
Pomodoro class >> timerFor: aDuration [ 
	"Open a new pomodoro timer for the given duration."
	
	^(self totalDuration: aDuration) open		 
]

{ #category : #'instance creation' }
Pomodoro class >> timerFor: aDuration whenFinishedDo: aBlock [
	"Open a new pomodoro timer for the given duration."
	
	^(self totalDuration: aDuration)
		finishedAction: aBlock;
		open		 
]

{ #category : #'instance creation' }
Pomodoro class >> totalDuration: aDuration [ 
	"Return a new instance of the receiver with the given total duration"
		
	^(self new)
		totalDuration: aDuration;
		yourself
]

{ #category : #accessing }
Pomodoro >> alreadyElapsed: aDuration [
	"Inform the receiver that there is already a duation elapsed. If more than
	 the total duration there is no duration remaining for the pomodoro"
	
	aDuration > self totalDuration 
		ifTrue: [ self finish ]
		ifFalse: [ self remainingDuration: self totalDuration - aDuration ]
	
]

{ #category : #'private - initialization' }
Pomodoro >> createStopWatch [

	^Stopwatch new
]

{ #category : #defaults }
Pomodoro >> defaultFinishedAction [
	"Returns a default action to be performed when finished"
	
	^[ self inform: 'Pomodoro finished'.		    
	    Beeper beepPrimitive ]
]

{ #category : #defaults }
Pomodoro >> defaultTotalDuration [
	"Returns the default total duration"
	
	^PomodoroSettings defaultTimeInMinutes minutes
]

{ #category : #running }
Pomodoro >> finish [
	self isFinished
		ifTrue: [ ^ self ].
	self remainingDuration: 0 seconds.
	finishedAction value.
	self state: #finished
]

{ #category : #accessing }
Pomodoro >> finishedAction [
	"Returns the finished action"
	
	finishedAction ifNil: [ finishedAction := self defaultFinishedAction ].
	^finishedAction 
]

{ #category : #accessing }
Pomodoro >> finishedAction: aBlock [
	"Sets a new finished action"
	
	finishedAction := aBlock
]

{ #category : #initialization }
Pomodoro >> initialize [
	"Initializes the receiver"
	
	super initialize.
	self totalDuration: self defaultTotalDuration.
	self reset.
]

{ #category : #testing }
Pomodoro >> isActive [

	^self stopWatch isActive
]

{ #category : #testing }
Pomodoro >> isFinished [

	^self state = #finished
]

{ #category : #testing }
Pomodoro >> isPaused [

	^self state = #paused
]

{ #category : #testing }
Pomodoro >> isReady [

	^self state = #ready
]

{ #category : #testing }
Pomodoro >> isStarted [

	^self state = #started
]

{ #category : #operations }
Pomodoro >> open [
	"Open a visual view on the receiver"
	
	^(PomodoroMorph on: self) openInWorld
]

{ #category : #running }
Pomodoro >> pause [

	self state: #paused.	 
	self stopWatch suspend
]

{ #category : #printing }
Pomodoro >> printOn: aStream [

	aStream 
		nextPutAll: (self class formatDuration: self totalDuration);
		nextPutAll: ' interval pomodoro with ';
		nextPutAll: self remainingDurationString;
		nextPutAll: ' remaining'
]

{ #category : #accessing }
Pomodoro >> remainingDuration [
	"Returns the receivers remaining time"
	 
	^remainingDuration
]

{ #category : #accessing }
Pomodoro >> remainingDuration: aDuration [
	"Sets the receivers remaining duration"
	 
	remainingDuration := aDuration roundTo: 0.5 second
]

{ #category : #accessing }
Pomodoro >> remainingDurationString [

	^self class formatDuration: self remainingDuration
]

{ #category : #running }
Pomodoro >> reset [

	self state: #ready.
	self remainingDuration: self totalDuration.
	stopWatch := nil.
]

{ #category : #running }
Pomodoro >> start [

	self state: #started.
	self stopWatch activate.
]

{ #category : #'private - accessing' }
Pomodoro >> state [

	^state
]

{ #category : #'private - accessing' }
Pomodoro >> state: aSymbol [
	state := aSymbol
]

{ #category : #accessing }
Pomodoro >> stopWatch [
	
	stopWatch ifNil: [ stopWatch := self createStopWatch ].
	^stopWatch
]

{ #category : #accessing }
Pomodoro >> totalDuration [
	"Returns the receivers total duration"
	
	^totalDuration
]

{ #category : #'private - accessing' }
Pomodoro >> totalDuration: aDuration [
	"Sets the total duration of the receiver"

	totalDuration := aDuration.
	self remainingDuration: aDuration
]

{ #category : #accessing }
Pomodoro >> totalDurationInMinutes [
	"Returns the receivers total duration in minutes"
	
	^self totalDuration minutes
]

{ #category : #accessing }
Pomodoro >> totalDurationInMinutes: anInteger [
	"Sets the receivers total duration in minutes"
	
	self totalDuration: anInteger minutes
]
