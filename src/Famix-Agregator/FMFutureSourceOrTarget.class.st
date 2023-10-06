Class {
	#name : #FMFutureSourceOrTarget,
	#superclass : #FMFutureProperty,
	#instVars : [
		'otherEndID'
	],
	#category : #'Famix-Agregator-Core'
}

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

{ #category : #parsing }
FMFutureSourceOrTarget >> referenceNumber: serial [

	self addToValues: (self importer decoratedImporter
			 entityAt: serial
			 ifPresent: [ :entity |
				 entity isDanglingReference
					 ifTrue: [
						 entity maybeResolve.
						 entity aggregatedMethod ifNil: [
							 self importer
								 dangling: (FMDanglingReference with: self)
								 to: serial ] ]
					 ifFalse: [ entity ] ]
			 ifAbsent: [
			 self importer
				 dangling: (FMDanglingReference with: self)
				 to: serial ])
]

{ #category : #parsing }
FMFutureSourceOrTarget >> shouldBeImported [
	"The other end of the association is not nil and has no dangling references."

	| otherEndProperty oppositeEntity otherEndOppositeEntity |
	values size > 1 ifTrue: [ ^ true ].
	otherEndID ifNil: [ ^ false ].

	otherEndProperty := parentElement importer decoratedImporter reminderDict 
		                    at: otherEndID
		                    ifAbsent: [ ^ false ].
	otherEndProperty numberOfDanglingReferences > 0 ifTrue: [ ^ false ].
	otherEndProperty values size > 1 ifTrue: [ ^ true ].

	oppositeEntity := values anyOne.
	otherEndOppositeEntity := otherEndProperty values anyOne.
	
	otherEndOppositeEntity = oppositeEntity ifTrue: [ ^ false ].
	(metaDescription isSource
		 ifTrue: [ oppositeEntity instance queryAllOutgoing object ]
		 ifFalse: [ oppositeEntity instance queryAllIncoming object ])
	= otherEndOppositeEntity ifTrue: [ ^ false ].

	"My class (self if I am a class) is not nil.
	The class of the other end of the association (itself if it is a class) is not nil.
	Both classes are different.
	In the case of multivalued properties, we import." "There is no other association between my end of the association and the other end."
	^ true
]
