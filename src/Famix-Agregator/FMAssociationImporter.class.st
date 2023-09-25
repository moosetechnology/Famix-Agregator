"
I represent an importer for associations such as accesses, invocations, references.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #FMAssociationImporter,
	#superclass : #FMImporterAggregationDecorator,
	#instVars : [
		'currentAssociation'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMAssociationImporter >> beginEntity: aDescription [

	currentAssociation := FMDanglingAssociation
		                      in: self decoratedImporter
		                      named: aDescription
]

{ #category : #parsing }
FMAssociationImporter >> beginProperty: aName [

	
]

{ #category : #accessing }
FMAssociationImporter >> currentAssociation [

	^ currentAssociation
]

{ #category : #accessing }
FMAssociationImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #'as yet unclassified' }
FMAssociationImporter >> endEntity [

	currentAssociation maybeResolve
]

{ #category : #parsing }
FMAssociationImporter >> endProperty: name [

	
]

{ #category : #parsing }
FMAssociationImporter >> inProperty: aName do: aBlock [

	| sourceOrTargetImporter |
	((self isSource: aName) or: [ self isTarget: aName ]) ifFalse: [
		super inProperty: aName do: aBlock.
		^ self ].

	sourceOrTargetImporter := FMSourceOrTargetImporter on: self.
	self currentParser importer: sourceOrTargetImporter.
	sourceOrTargetImporter inProperty: aName do: aBlock
]

{ #category : #accessing }
FMAssociationImporter >> isSource: aName [

	^ (self decoratedImporter metamodel properties detect: [ :prop |
		   prop name = aName ]) isSource
]

{ #category : #accessing }
FMAssociationImporter >> isTarget: aName [

	^ (self decoratedImporter metamodel properties detect: [ :prop |
		   prop name = aName ]) isTarget
]

{ #category : #parsing }
FMAssociationImporter >> primitive: value [
	"Nothing to do: the current property is not a source or target of the association, so we don't care 	about it."

	
]

{ #category : #parsing }
FMAssociationImporter >> referenceNumber: index [
	"Nothing to do: the current property is not a source or target of the association, so we don't care 	about it."

	
]

{ #category : #accessing }
FMAssociationImporter >> serial: aNumber [

	currentAssociation referenceID: aNumber
]
