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
		'referenceID'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMDanglingAssociation >> beginProperty: aString [

	self assert: currentProperty isNil.
	currentProperty := FMFutureSourceOrTarget in: self named: aString
]

{ #category : #'as yet unclassified' }
FMDanglingAssociation >> canBeResolved [

	| source target canBeResolved |
	source := self instance source.
	target := self instance target.

	canBeResolved := source isNotNil and: [ target isNotNil ].

	canBeResolved := canBeResolved and: [ source ~= target ].

	canBeResolved := canBeResolved and: [
		                 (source isCollection not and: [
			                  target isCollection not and: [
				                  (source atScope: FamixTType)
				                  = (target atScope: FamixTType) ] ]) not ].

	canBeResolved := canBeResolved and: [
		                 self importer allEntities noneSatisfy: [ :entity |
			                 entity class mooseDescription = metaDescription
				                 and: [
				                 entity source = source and: [
					                 entity target = target ] ] ] ].
	^ canBeResolved
]

{ #category : #accessing }
FMDanglingAssociation >> importer: anObject [

	importer := anObject
]

{ #category : #testing }
FMDanglingAssociation >> isDanglingReference [

	^ true
]

{ #category : #'as yet unclassified' }
FMDanglingAssociation >> maybeResolve [

	self canBeResolved ifFalse: [ ^ self ].
	self importer decoratedImporter assign: self to: referenceID.
	self importer allEntities add: self instance
]

{ #category : #accessing }
FMDanglingAssociation >> referenceID: aNumber [

	referenceID := aNumber
]
