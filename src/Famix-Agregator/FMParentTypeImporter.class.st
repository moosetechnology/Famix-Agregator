Class {
	#name : #FMParentTypeImporter,
	#superclass : #FMImporterAggregationDecorator,
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMParentTypeImporter >> endProperty: aName [

	self parser importer: self decoratedImporter
]

{ #category : #parsing }
FMParentTypeImporter >> referenceNumber: aNumber [

	self sourceImporter
		entityAt: aNumber
		ifPresent: [ :parentType |
		 decoratedImporter currentMethodReference resolve: parentType ]
		ifAbsent: [
			self sourceImporter
				dangling: aNumber
				to: decoratedImporter currentMethodReference ]
]

{ #category : #parsing }
FMParentTypeImporter >> sourceImporter [
	"Decorated importer is a FMMethodImporter.
	Its decorated importer is a FMImporterAggregationDecorator.
	We want to access the decorated importer of this FMImporterAggregationDecorator which is a FMImporter"

	^ decoratedImporter decoratedImporter decoratedImporter
]
