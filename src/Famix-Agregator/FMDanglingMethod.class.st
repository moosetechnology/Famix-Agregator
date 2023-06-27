Class {
	#name : #FMDanglingMethod,
	#superclass : #Object,
	#instVars : [
		'parentTypeID',
		'methodID'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMDanglingMethod >> isDanglingReference [

	^ true
]

{ #category : #accessing }
FMDanglingMethod >> methodID [

	^ methodID
]

{ #category : #accessing }
FMDanglingMethod >> methodID: aNumber [

	^ methodID := aNumber
]

{ #category : #accessing }
FMDanglingMethod >> parentTypeID [

	^ parentTypeID
]

{ #category : #accessing }
FMDanglingMethod >> parentTypeID: aNumber [

	^ parentTypeID := aNumber
]
