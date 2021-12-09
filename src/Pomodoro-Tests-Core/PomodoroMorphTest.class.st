"
Test cases for Pomodoro morph
"
Class {
	#name : #PomodoroMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'morph'
	],
	#category : #'Pomodoro-Tests-Core-UI'
}

{ #category : #accessing }
PomodoroMorphTest >> defaultTestClass [
	"Returns the class to test"

	^PomodoroMorph
]

{ #category : #running }
PomodoroMorphTest >> setUp [	
	
	super setUp.
	morph := self defaultTestClass new
]

{ #category : #testing }
PomodoroMorphTest >> testCachedMenuItem [
	
	self assert: self defaultTestClass menuIcon == self defaultTestClass menuIcon
]

{ #category : #testing }
PomodoroMorphTest >> testInstanceCreation [

	self assert: morph model notNil
]
