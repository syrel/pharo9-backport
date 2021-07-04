Class {
	#name : #PharoPatcher,
	#superclass : #Object,
	#category : #'Pharo-Patcher'
}

{ #category : #'instance creation' }
PharoPatcher class >> haba [
	| each realSuperClass |
	
]

{ #category : #patching }
PharoPatcher class >> patch: aClass source: aSourceCode [
	self patch: aClass source: aSourceCode classified: nil
]

{ #category : #patching }
PharoPatcher class >> patch: aClass source: aSourceCode classified: aCategory [
	| aSelector |
	aSelector := (RBParser parseFaultyMethod: aSourceCode) selector.
	aCategory
		ifNil: [ aClass compile: aSourceCode ]
		ifNotNil: [ aClass compile: aSourceCode classified: aCategory ].
	NonInteractiveTranscript stdout
		space;
		space;
		space;
		nextPutAll: aClass name;
		nextPutAll: '' >> #'';
		nextPutAll: aSelector;
		cr
]

{ #category : #patching }
PharoPatcher class >> updatePackages: aCollectionOfPackageNames during: aBlock [
	| packagesToDelete extensionMethods classesToRemove |

	packagesToDelete := aCollectionOfPackageNames
		collect: [ :each | each asPackage ].

	classesToRemove := packagesToDelete
		flatCollect: [ :eachPackage | eachPackage definedClasses ].

	extensionMethods := classesToRemove
		flatCollect: [ :eachClass | 
			eachClass extensionSelectors
				collect: [ :eachSelector | eachClass >> eachSelector ] ].

	extensionMethods := extensionMethods
		reject: [ :each | packagesToDelete includes: each package ].
		
	extensionMethods := extensionMethods collect: [ :eachMethod | PharoRemovedExtensionMethod fromCompiledMethod: eachMethod ].

	NonInteractiveTranscript stdout
		nextPutAll: 'Found ';
		nextPutAll: extensionMethods size asString;
		nextPutAll: ' extension methods.';
		cr.

	extensionMethods
		do: [ :eachMethod | 
			NonInteractiveTranscript stdout
				space; space; space;
				nextPut: $[;
				nextPutAll: eachMethod category;
				nextPut: $];
				space;
				nextPutAll: eachMethod extendedClassName;
				nextPutAll: ' >> #';
				nextPutAll: eachMethod selector;
				cr ].

	packagesToDelete do: [ :eachPackage | eachPackage removeFromSystem ].
	
	aBlock value.
	
	(Smalltalk image allClasses
		select: [ :each | each isTrait not and: [ each superclass notNil ] ])
		select: [ :each | each superclass name beginsWith: 'AnObsolete' ]
		thenDo: [ :each | 
			| realSuperClass |
			realSuperClass := self environment at: (each superclass name
				copyReplaceAll: 'AnObsolete'
				with: '') asSymbol.
			each superclass: realSuperClass.
			NonInteractiveTranscript stdout
				space;
				space;
				space;
				nextPutAll: 'Fixed the superclass of ';
				nextPutAll: each name;
				nextPutAll: ' to ';
				nextPutAll: realSuperClass name;
				cr ].

	extensionMethods
		do: [ :eachExtensionMethod | eachExtensionMethod compile ]
]
