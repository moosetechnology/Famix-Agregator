"
I represent an importer for the source property of an association.

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
	#name : #FMSourceTargetImporter,
	#superclass : #FMImporterAggregationDecorator,
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMSourceTargetImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #parsing }
FMSourceTargetImporter >> endProperty: aName [

	self currentParser importer: self decoratedImporter
]

{ #category : #parsing }
FMSourceTargetImporter >> referenceNumber: aNumber [

	self sourceImporter
		entityAt: aNumber
		ifPresent: [ :element |
			decoratedImporter currentAssociationReference resolve: element. ]
		ifAbsent: [
			self sourceImporter
				dangling: decoratedImporter currentAssociationReference
				to: aNumber ]
]

{ #category : #accessing }
FMSourceTargetImporter >> sourceImporter [
	"Decorated importer is a FMAssociationImporter.
	Its decorated importer is a FMImporterAggregationDecorator.
	We want to access the decorated importer of this FMImporterAggregationDecorator which is a 	FMImporter"

	^ decoratedImporter decoratedImporter decoratedImporter
]
