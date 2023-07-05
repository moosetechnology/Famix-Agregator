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

	currentMethodReference := FMDanglingMethodReference new
		                          importer: self decoratedImporter;
										  description: aDescription;
		                          yourself
]

{ #category : #parsing }
FMMethodImporter >> beginProperty: aName [
	"We will not create an actual method. So we don't need to create properties"

	aName = #parentType ifTrue: [
		self currentParser importer: (FMParentTypeImporter on: self) ]

	
]

{ #category : #accessing }
FMMethodImporter >> currentMethodReference [

	^ currentMethodReference
]

{ #category : #parsing }
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

{ #category : #parsing }
FMMethodImporter >> serial: aNumber [

	currentMethodReference methodID: aNumber
]
