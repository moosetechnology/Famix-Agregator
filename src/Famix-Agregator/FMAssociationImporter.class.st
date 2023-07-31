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
		'currentAssociationReference'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMAssociationImporter >> beginEntity: aDescription [

	currentAssociationReference := FMDanglingAssociation new
		                               importer: self decoratedImporter;
		                               description: aDescription;
		                               yourself
]

{ #category : #parsing }
FMAssociationImporter >> beginProperty: aName [

    | importer |
    importer := FMSourceTargetImporter on: self.

    ((self isSource: aName) or: [self isTarget: aName]) ifTrue: [
        self currentParser importer: importer ].

]

{ #category : #accessing }
FMAssociationImporter >> currentAssociationReference [

	^ currentAssociationReference
]

{ #category : #accessing }
FMAssociationImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #parsing }
FMAssociationImporter >> endProperty: name [

]

{ #category : #accessing }
FMAssociationImporter >> isSource: aName [

	| associations sources |
	associations := self decoratedImporter metamodel classes select: [ :c |
		                c traits anySatisfy: [ :trait |
			                trait name = #TAssociation ] ].
	sources := associations collect: [ :a |
		           (a allProperties select: #isSource) anyOne
			           implementingSelector ].
	^ sources includes: aName
]

{ #category : #accessing }
FMAssociationImporter >> isTarget: aName [

	| associations targets |
	associations := self decoratedImporter metamodel classes select: [ :c |
		                c traits anySatisfy: [ :trait |
			                trait name = #TAssociation ] ].
	targets := associations collect: [ :a |
		           (a allProperties select: #isTarget) anyOne
			           implementingSelector ].
	^ targets includes: aName
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

	currentAssociationReference referenceID: aNumber
]
