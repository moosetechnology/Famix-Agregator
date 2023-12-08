Class {
	#name : #FMFutureSourceOrTarget,
	#superclass : #FMFutureProperty,
	#instVars : [
		'otherEndID',
		'referenceNumber'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMFutureSourceOrTarget >> addDanglingTo: serial [

	^ self importer dangling: (FMDanglingReference with: self) to: serial
]

{ #category : #accessing }
FMFutureSourceOrTarget >> end [
	"This method si called by the association one it is resolved"

	metaDescription isFM3Property
		ifTrue: [
		metaDescription setOn: parentElement instance values: values ]
		ifFalse: [
			parentElement instance
				handleFameProperty: metaDescription
				value: values ]
]

{ #category : #initialization }
FMFutureSourceOrTarget >> in: anEntity named: aString [

	super in: anEntity named: aString.
	
	metaDescription isSource ifTrue: [
		parentElement danglingSource: self ].
	metaDescription isTarget ifTrue: [
		parentElement danglingTarget: self ]
]

{ #category : #parsing }
FMFutureSourceOrTarget >> maybeEnd [

	self numberOfDanglingReferences isZero ifFalse: [ ^ self ].
	self parentEntity maybeResolve
]

{ #category : #accessing }
FMFutureSourceOrTarget >> referenceNumber [

	^ referenceNumber
]

{ #category : #parsing }
FMFutureSourceOrTarget >> referenceNumber: serial [

	referenceNumber := serial.
	self addToValues: (self importer decoratedImporter
			 entityAt: serial
			 ifPresent: [ :entity |
				 entity isDanglingReference
					 ifTrue: [
						 entity maybeResolve.
						 entity aggregatedMethod ifNil: [ self addDanglingTo: serial ] ]
					 ifFalse: [ entity ] ]
			 ifAbsent: [ self addDanglingTo: serial ])
]

{ #category : #accessing }
FMFutureSourceOrTarget >> typeContainer [

	^ values ifEmpty: [ nil ] ifNotEmpty: [
		  values anyOne isType
			  ifTrue: [ values anyOne ]
			  ifFalse: [
				  (values anyOne atScope: FamixTType)
					  ifEmpty: [ nil ]
					  ifNotEmpty: [ :scopes | scopes anyOne ] ] ]
]
