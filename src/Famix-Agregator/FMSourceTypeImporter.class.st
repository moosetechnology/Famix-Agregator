Class {
	#name : #FMSourceTypeImporter,
	#superclass : #FMImporterAggregationDecorator,
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMSourceTypeImporter >> currentParser [

	^ decoratedImporter currentParser
]
