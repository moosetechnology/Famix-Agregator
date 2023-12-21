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

	(danglingSource isNil or: [ danglingTarget isNil ]) ifTrue: [
		^ false ].

	danglingSource numberOfDanglingReferences
	+ danglingTarget numberOfDanglingReferences > 0 ifTrue: [ ^ false ].

	(danglingSource metaDescription isMultivalued or: [
		 danglingTarget metaDescription isMultivalued ]) ifTrue: [ ^ true ].

	(self sourceType isNil or: [ self targetType isNil ]) ifTrue: [
		^ false ].
	self sourceType = self targetType ifTrue: [ ^ false ].

	^ (importer
		   alreadyHasAssociation: self metaDescription
		   withSource: self sourceType
		   target: self targetType) not
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
	self registerInImporter.
	self importer allEntities add: self instance
]

{ #category : #accessing }
FMDanglingAssociation >> referenceID: aNumber [

	referenceID := aNumber
]

{ #category : #resolving }
FMDanglingAssociation >> registerInImporter [

	^ importer
		  association: self metaDescription
		  atSourceID: danglingSource typeContainer
		  addTargetID: danglingTarget typeContainer
]

{ #category : #accessing }
FMDanglingAssociation >> sourceType [

	^ danglingSource typeContainer
]

{ #category : #accessing }
FMDanglingAssociation >> targetType [

	^ danglingTarget typeContainer
]
