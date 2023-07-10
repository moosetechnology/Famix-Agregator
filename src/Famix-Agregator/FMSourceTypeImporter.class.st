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

{ #category : #parsing }
FMSourceTypeImporter >> referenceNumber: aNumber [

	self sourceImporter
		entityAt: aNumber
		ifPresent: [ :source |
			source parentType ifNotNil: [
				decoratedImporter currentAssociationReference sourceType:
					source parentType. decoratedImporter currentAssociationReference sourceID: aNumber ].
			 ]
		ifAbsent: [
			self sourceImporter
				dangling: decoratedImporter currentAssociationReference
				to: aNumber ].

	decoratedImporter currentAssociationReference
]

{ #category : #accessing }
FMSourceTypeImporter >> sourceImporter [
	"Decorated importer is a FMAssociationImporter.
	Its decorated importer is a FMImporterAggregationDecorator.
	We want to access the decorated importer of this FMImporterAggregationDecorator which is a 	FMImporter"

	^ decoratedImporter decoratedImporter decoratedImporter
]
