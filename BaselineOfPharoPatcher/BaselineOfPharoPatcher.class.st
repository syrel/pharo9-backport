Class {
	#name : #BaselineOfPharoPatcher,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoPatcher
}

{ #category : #initialization }
BaselineOfPharoPatcher class >> removePatcherFromSystem [
	'Pharo-Patcher' asPackage removeFromSystem.
	self package removeFromSystem.
]

{ #category : #baselines }
BaselineOfPharoPatcher >> baseline: spec [
	<baseline>

	spec for: #common do: [ spec package: 'Pharo-Patcher' ]
]
