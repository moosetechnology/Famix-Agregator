Class {
	#name : #FMSourceOrTargetImporter,
	#superclass : #FMImporterAggregationDecorator,
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMSourceOrTargetImporter >> beginProperty: aName [

	self currentEntity beginProperty: aName
]

{ #category : #accessing }
FMSourceOrTargetImporter >> currentEntity [

	^ self decoratedImporter currentAssociation
]

{ #category : #accessing }
FMSourceOrTargetImporter >> currentParser [

	^ self decoratedImporter currentParser
]

{ #category : #parsing }
FMSourceOrTargetImporter >> endProperty: aName [

	self currentParser importer: self decoratedImporter.
	self currentEntity endProperty
]

{ #category : #parsing }
FMSourceOrTargetImporter >> referenceNumber: serial [

	self currentEntity currentProperty referenceNumber: serial
]

{ #category : #accessing }
FMSourceOrTargetImporter >> sourceImporter [
	"Decorated importer is a FMAssociationImporter.
	Its decorated importer is a FMImporterAggregationDecorator.
	We want to access the decorated importer of this FMImporterAggregationDecorator which is a 	FMImporter"

	^ self decoratedImporter decoratedImporter decoratedImporter
]
