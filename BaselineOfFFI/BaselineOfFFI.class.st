Class {
	#name : #BaselineOfFFI,
	#superclass : #BaselineOf,
	#category : #BaselineOfFFI
}

{ #category : #baselines }
#BaselineOfFFI >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
				package: 'FFI-Kernel';
				package: 'FFI-Pools'. ]
]
