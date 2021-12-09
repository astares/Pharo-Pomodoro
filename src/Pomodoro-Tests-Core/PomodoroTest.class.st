"
Test cases for Pomodoro model
"
Class {
	#name : #PomodoroTest,
	#superclass : #TestCase,
	#instVars : [
		'pomodoro'
	],
	#category : #'Pomodoro-Tests-Core-Model'
}

{ #category : #accessing }
PomodoroTest >> defaultTestClass [
	"Returns the class to test"
	
	^Pomodoro
]

{ #category : #running }
PomodoroTest >> setUp [
	"Sets up the receivers test case"
	
	super setUp.
	pomodoro := self defaultTestClass new.
	pomodoro finishedAction: [ ]  "do nothing while running tests"
]

{ #category : #running }
PomodoroTest >> tearDown [ 	

	pomodoro := nil.
	super tearDown
]

{ #category : #testing }
PomodoroTest >> testAlreadyElapsed [

	self assert: pomodoro totalDuration equals: 25 minutes.
	pomodoro alreadyElapsed: 2 minutes.
	self assert: pomodoro remainingDuration equals: 23 minutes
]

{ #category : #testing }
PomodoroTest >> testAlreadyElapsedOverLimit [

	self assert: pomodoro totalDuration equals: 25 minutes.
	pomodoro alreadyElapsed: 30 minutes.
	self assert: pomodoro remainingDuration equals: 0 minutes
]

{ #category : #testing }
PomodoroTest >> testDefaultFinishedAction [

	self assert: pomodoro defaultFinishedAction isBlock
]

{ #category : #testing }
PomodoroTest >> testDefaultTotalDuration [
	self assert: pomodoro defaultTotalDuration equals: 25 minutes
]

{ #category : #testing }
PomodoroTest >> testFinish [

	|actionRun|
	actionRun := false.	
	pomodoro finishedAction: [ actionRun := true ].
	pomodoro finish.
	self assert: actionRun.
	self assert: pomodoro isFinished
]

{ #category : #testing }
PomodoroTest >> testFinished [

	self deny: pomodoro isFinished.
	pomodoro finish.
	self 
		assert: pomodoro isFinished;
		assert: pomodoro state equals: #finished
]

{ #category : #testing }
PomodoroTest >> testFinishedAction [

	self assert: pomodoro finishedAction isBlock
]

{ #category : #testing }
PomodoroTest >> testInitialState [

	self assert: pomodoro isReady
]

{ #category : #testing }
PomodoroTest >> testInitializedWithDefaultTotalDuration [

	self assert: pomodoro totalDuration equals: pomodoro defaultTotalDuration
]

{ #category : #testing }
PomodoroTest >> testIsNotActiveByDefault [

	self deny: pomodoro isActive
]

{ #category : #testing }
PomodoroTest >> testLazyStopWatch [

	self assert: pomodoro stopWatch notNil
]

{ #category : #testing }
PomodoroTest >> testOpenMorph [

	| morph |
	morph := self defaultTestClass new open.
	self assert: morph visible.
	morph delete
]

{ #category : #testing }
PomodoroTest >> testPrintString [

	self assert: pomodoro printString equals: '25:00 interval pomodoro with 25:00 remaining'.
	pomodoro totalDurationInMinutes: 10.
	self assert: pomodoro printString equals: '10:00 interval pomodoro with 10:00 remaining'
]

{ #category : #testing }
PomodoroTest >> testPrintStringIfMoreThanAnHour [

	pomodoro totalDuration: 63 minutes.
	self assert: pomodoro printString equals: '01:03:00 interval pomodoro with 01:03:00 remaining'
]

{ #category : #testing }
PomodoroTest >> testRemainingDurationString [

	self assert: pomodoro remainingDurationString equals: '25:00'
]

{ #category : #testing }
PomodoroTest >> testRemainingDurationStringIfMoreThanAnHour [

	pomodoro totalDuration: 63 minutes.
	self assert: pomodoro remainingDurationString equals: '01:03:00'
]

{ #category : #testing }
PomodoroTest >> testReset [

	self assert: pomodoro totalDuration equals: 25 minutes.
	pomodoro alreadyElapsed: 2 minutes.
	pomodoro reset.
	self assert: pomodoro remainingDuration equals: 25 minutes
]

{ #category : #testing }
PomodoroTest >> testStarted [

	self deny: pomodoro isStarted.
	pomodoro start.
	self 
		assert: pomodoro isStarted;
		assert: pomodoro state equals: #started
]
