"
I represent an importer for property ""parentType"".

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
	#name : #FMParentTypeImporter,
	#superclass : #FMImporterAggregationDecorator,
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMParentTypeImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #parsing }
FMParentTypeImporter >> endProperty: aName [

	self currentParser importer: self decoratedImporter
]

{ #category : #parsing }
FMParentTypeImporter >> referenceNumber: aNumber [

	self sourceImporter
		entityAt: aNumber
		ifPresent: [ :parentType |
			decoratedImporter currentMethodReference resolve: parentType ]
		ifAbsent: [
			self sourceImporter
				dangling: decoratedImporter currentMethodReference
				to: aNumber ]
]

{ #category : #accessing }
FMParentTypeImporter >> sourceImporter [
	"Decorated importer is a FMMethodImporter.
	Its decorated importer is a FMImporterAggregationDecorator.
	We want to access the decorated importer of this FMImporterAggregationDecorator which is a FMImporter"

	^ decoratedImporter decoratedImporter decoratedImporter
]
