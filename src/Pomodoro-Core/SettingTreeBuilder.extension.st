Extension { #name : #SettingTreeBuilder }

{ #category : #'*Pomodoro-Core' }
SettingTreeBuilder >> pomodorosettings [
	"Process a <pomodorosettings> pragma"
	currentPragma methodClass theNonMetaClass perform: currentPragma selector with: self.
]
