Class {
	#name : #FMDanglingMethodReference,
	#superclass : #Object,
	#instVars : [
		'parentTypeID',
		'methodID'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMDanglingMethodReference >> isDanglingReference [

	^ true
]

{ #category : #accessing }
FMDanglingMethodReference >> methodID [

	^ methodID
]

{ #category : #accessing }
FMDanglingMethodReference >> methodID: aNumber [

	^ methodID := aNumber
]

{ #category : #accessing }
FMDanglingMethodReference >> parentTypeID [

	^ parentTypeID
]

{ #category : #accessing }
FMDanglingMethodReference >> parentTypeID: aNumber [

	^ parentTypeID := aNumber
]

{ #category : #accessing }
FMDanglingMethodReference >> resolve: element at: aPosition in: aDict [

	self assert: methodID isNotNil.
	self assert: parentTypeID isNotNil.
	aDict add: aPosition -> element parentType.
	"parentProperty replaceDanglingReferenceAt: position by: element"
]
