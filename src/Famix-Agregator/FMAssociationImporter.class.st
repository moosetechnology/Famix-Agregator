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

{ #category : #accessing }
FMAssociationImporter >> currentAssociationReference [

	^ currentAssociationReference
]

{ #category : #accessing }
FMAssociationImporter >> currentParser [

	^ decoratedImporter currentParser
]