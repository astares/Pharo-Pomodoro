"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPomodoroCore,
	#superclass : #PackageManifest,
	#category : #'Pomodoro-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestPomodoroCore class >> ruleUtilityMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PomodoroMorph #taskbarButtonMenu: #false)) #'2021-12-09T17:06:44.313+01:00') )
]
