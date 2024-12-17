Extension { #name : 'SettingTreeBuilder' }

{ #category : '*Pomodoro-Core' }
SettingTreeBuilder >> pomodorosettings [
	"Process a <pomodorosettings> pragma"

	currentPragma methodClass instanceSide
		perform: currentPragma method selector
		with: self
]
