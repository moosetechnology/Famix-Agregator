Class {
	#name : #FMSourceTypeImporter,
	#superclass : #FMImporterAggregationDecorator,
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMSourceTypeImporter >> currentParser [

	^ decoratedImporter currentParser
]

{ #category : #parsing }
FMSourceTypeImporter >> endProperty: aName [

	self currentParser importer: self decoratedImporter
]

{ #category : #accessing }
FMSourceTypeImporter >> sourceImporter [
	"Decorated importer is a FMAssociationImporter.
	Its decorated importer is a FMImporterAggregationDecorator.
	We want to access the decorated importer of this FMImporterAggregationDecorator which is a 	FMImporter"

	^ decoratedImporter decoratedImporter decoratedImporter
]
