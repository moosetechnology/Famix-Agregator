Class {
	#name : #FMTargetImporter,
	#superclass : #FMImporterAggregationDecorator,
	#instVars : [
		'targetName'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMTargetImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #parsing }
FMTargetImporter >> endProperty: aName [

	self currentParser importer: self decoratedImporter
]

{ #category : #parsing }
FMTargetImporter >> referenceNumber: aNumber [

	| entitiesWithParentType |
	entitiesWithParentType := #( 'variable' 'candidates' ).
	(entitiesWithParentType includes: targetName) ifTrue: [
		self sourceImporter
			entityAt: aNumber
			ifPresent: [ :target |
				target parentType ifNotNil: [
					decoratedImporter currentAssociationReference targetType:
						target parentType.
					decoratedImporter currentAssociationReference targetID: aNumber.
					decoratedImporter currentAssociationReference maybeResolve ] ]
			ifAbsent: [
				self sourceImporter
					dangling: FMDanglingReference new to: aNumber ] ].
	targetName = 'referredType' ifTrue: [
		self sourceImporter
			entityAt: aNumber
			ifPresent: [ :target |
				decoratedImporter currentAssociationReference targetType: target.
				decoratedImporter currentAssociationReference targetID: aNumber.
				decoratedImporter currentAssociationReference maybeResolve ]
			ifAbsent: [
			self sourceImporter dangling: FMDanglingReference new to: aNumber ] ]
]

{ #category : #accessing }
FMTargetImporter >> targetName: aName [

	targetName := aName
]
