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

	(aName = #parentType) ifTrue: [ self parser decoratedImporter: (FMParentTypeImporter on: self) ]
]

{ #category : #accessing }
FMMethodImporter >> currentMethodReference [

	^ currentMethodReference
]

{ #category : #parsing }
FMMethodImporter >> endEntity: aDescription [

	self parser importer: self decoratedImporter
]

{ #category : #parsing }
FMMethodImporter >> serial: aNumber [

	currentMethodReference methodID: aNumber
]
