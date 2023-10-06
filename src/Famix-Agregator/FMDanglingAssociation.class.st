"
I represent a non resolved association.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	description:		<Object>
	importer:		<Object>
	sourceTypeID:		<Object>
	targetTypeID:		<Object>


    Implementation Points
"
Class {
	#name : #FMDanglingAssociation,
	#superclass : #FMFutureEntity,
	#instVars : [
		'referenceID',
		'danglingSource',
		'danglingTarget'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMDanglingAssociation >> beginProperty: aString [

	self assert: currentProperty isNil.
	currentProperty := FMFutureSourceOrTarget in: self named: aString
]

{ #category : #resolving }
FMDanglingAssociation >> canBeResolved [

	| sourceType targetType |
	(danglingSource isNil or: [ danglingTarget isNil ]) ifTrue: [
		^ false ].
	danglingSource numberOfDanglingReferences
	+ danglingTarget numberOfDanglingReferences > 0 ifTrue: [ ^ false ].
	(danglingSource metaDescription isMultivalued or: [
		 danglingTarget metaDescription isMultivalued ]) ifTrue: [ ^ true ].


	(danglingSource values size > 1 or: [ danglingTarget values size > 1 ])
		ifTrue: [ ^ true ].

	sourceType := danglingSource values anyOne isType
		              ifTrue: [ danglingSource values anyOne ]
		              ifFalse: [
			              (danglingSource values anyOne atScope: FamixTType)
				              ifEmpty: [ ^ false ]
				              ifNotEmpty: [ :scopes | scopes anyOne ] ].
	targetType := danglingTarget values anyOne isType
		              ifTrue: [ danglingTarget values anyOne ]
		              ifFalse: [
			              (danglingTarget values anyOne atScope: FamixTType)
				              ifEmpty: [ ^ false ]
				              ifNotEmpty: [ :scopes | scopes anyOne ] ].
	^ sourceType ~= targetType and: [
		  (sourceType queryOutgoing: metaDescription implementingClass)
			  noneSatisfy: [ :association |
				  (association target isType
					   ifTrue: [ association target ]
					   ifFalse: [
						   (association target atScope: FamixTType)
							   ifEmpty: [ ^ false ]
							   ifNotEmpty: [ :scopes | scopes anyOne ] ]) = targetType ] ]
]

{ #category : #accessing }
FMDanglingAssociation >> danglingSource [

	^ danglingSource
]

{ #category : #accessing }
FMDanglingAssociation >> danglingSource: aFutureSource [

	danglingSource := aFutureSource
]

{ #category : #accessing }
FMDanglingAssociation >> danglingTarget [

	^ danglingTarget
]

{ #category : #accessing }
FMDanglingAssociation >> danglingTarget: aFutureTarget [

	danglingTarget := aFutureTarget
]

{ #category : #accessing }
FMDanglingAssociation >> importer: anObject [

	importer := anObject
]

{ #category : #testing }
FMDanglingAssociation >> isDanglingReference [

	^ true
]

{ #category : #resolving }
FMDanglingAssociation >> maybeResolve [

	self canBeResolved ifFalse: [ ^ self ].
	self importer decoratedImporter assign: self to: referenceID.
	self danglingSource end.
	self danglingTarget end.
	self flag: 'Is the last line necessary?'.
	self importer allEntities add: self instance
]

{ #category : #accessing }
FMDanglingAssociation >> referenceID: aNumber [

	referenceID := aNumber
]
