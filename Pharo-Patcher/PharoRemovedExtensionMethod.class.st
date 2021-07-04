Class {
	#name : #PharoRemovedExtensionMethod,
	#superclass : #Object,
	#instVars : [
		'extendedClassName',
		'category',
		'sourceCode',
		'selector'
	],
	#category : #'Pharo-Patcher'
}

{ #category : #'instance creation' }
PharoRemovedExtensionMethod class >> fromCompiledMethod: aCompiledMethod [
	^ self new
		extendedClassName: aCompiledMethod methodClass name;
		sourceCode: aCompiledMethod sourceCode;
		category: aCompiledMethod category;
		selector: aCompiledMethod selector
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> category [
	^ category
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> category: anObject [
	category := anObject
]

{ #category : #compiling }
PharoRemovedExtensionMethod >> compile [
	(self class environment at: self extendedClassName)
		compile: self sourceCode
		classified: self category
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> extendedClassName [
	^ extendedClassName
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> extendedClassName: anObject [
	extendedClassName := anObject
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> selector [
	^ selector
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
PharoRemovedExtensionMethod >> sourceCode: anObject [
	sourceCode := anObject
]
