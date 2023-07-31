"
I create a DanglingMethodReference when the importer decorator finds a method.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	currentMethodReference:		<Object>


    Implementation Points
"
Class {
	#name : #FMMethodImporter,
	#superclass : #FMImporterAggregationDecorator,
	#instVars : [
		'currentMethodReference'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMMethodImporter >> beginEntity: aDescription [

	currentMethodReference := FMDanglingMethod new
		                          importer: self decoratedImporter;
		                          description: aDescription;
		                          yourself
]

{ #category : #parsing }
FMMethodImporter >> beginProperty: aName [
	"We will not create an actual method. So we don't need to create properties"

	| importer |
	importer := FMParentTypeImporter on: self.

	aName = #parentType ifTrue: [
		self currentParser importer: importer ]
]

{ #category : #accessing }
FMMethodImporter >> currentMethodReference [

	^ currentMethodReference
]

{ #category : #accessing }
FMMethodImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #parsing }
FMMethodImporter >> endProperty: name [

	
]

{ #category : #parsing }
FMMethodImporter >> primitive: value [
	"Nothing to do: the current property is not #parentType, so we don't care about it."

	
]

{ #category : #parsing }
FMMethodImporter >> referenceNumber: index [

	"Nothing to do: the current property is not #parentType, so we don't care about it."

	
]

{ #category : #accessing }
FMMethodImporter >> serial: aNumber [

	currentMethodReference methodID: aNumber
]
