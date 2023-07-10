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

	currentAssociationReference := FMDanglingAssociationReference new
		                               importer: self decoratedImporter;
		                               description: aDescription;
		                               yourself
]

{ #category : #parsing }
FMAssociationImporter >> beginProperty: aName [
	"We will not create an actual method. So we don't need to create properties"
	"Codage en dur pour le moment, refactoring plus tard"

	| sourceTypes targetTypes |
	sourceTypes := #( 'accessor' 'referencer' 'sender' ).
	targetTypes := #( 'variable' 'refferedType' 'candidates' ).
	(sourceTypes includes: aName) ifTrue: [
		self currentParser importer: (FMSourceTypeImporter on: self) ].
	(targetTypes includes: aName) ifTrue: [
		self currentParser importer: (FMTargetImporter on: self) ]
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

{ #category : #parsing }
FMAssociationImporter >> primitive: value [
	"Nothing to do: the current property is not a source or target of the association, so we don't care 	about it."

	
]

{ #category : #accessing }
FMAssociationImporter >> serial: aNumber [

	currentAssociationReference referenceID: aNumber
]
