Class {
	#name : #FMImporterAgregationDecorator,
	#superclass : #Object,
	#traits : 'FMTImportExportStructure',
	#classTraits : 'FMTImportExportStructure classTrait',
	#instVars : [
		'importer'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #'instance creation' }
FMImporterAgregationDecorator class >> on: aFMImporter [

	^ self new
		  importer: aFMImporter;
		  yourself
]

{ #category : #parsing }
FMImporterAgregationDecorator >> beginDocument [

	importer beginDocument
]

{ #category : #parsing }
FMImporterAgregationDecorator >> beginEntity: name [

	| parentClass aggregatedMethodName aggregatedMethod |
	importer beginEntity: name.

	(self isClass: name) ifFalse: [ ^ self ].
	parentClass := importer currentEntity.
	aggregatedMethodName := 'aggregatedMethod' , parentClass name.
	aggregatedMethod := FMFutureEntity
		                    in: self
		                    named: aggregatedMethodName.
	aggregatedMethod parentType: parentClass.
	importer stack push: aggregatedMethod
]

{ #category : #parsing }
FMImporterAgregationDecorator >> beginProperty: name [

	importer beginProperty: name
]

{ #category : #parsing }
FMImporterAgregationDecorator >> createAgregatedMethod [

	| agregatedMethod |
	agregatedMethod := FMFutureEntity
		                   in: self
		                   named:
		                   (importer currentEntity name
			                    copyReplaceAll: 'Class'
			                    with: 'Method').
	agregatedMethod instance parentType: importer currentEntity instance.
	^ agregatedMethod
]

{ #category : #parsing }
FMImporterAgregationDecorator >> endDocument [

	importer endDocument
]

{ #category : #parsing }
FMImporterAgregationDecorator >> endEntity: name [

	importer endEntity: name
]

{ #category : #parsing }
FMImporterAgregationDecorator >> endProperty: name [

	importer endProperty: name
]

{ #category : #accessing }
FMImporterAgregationDecorator >> importer [

	^ importer
]

{ #category : #accessing }
FMImporterAgregationDecorator >> importer: anObject [

	importer := anObject
]

{ #category : #asserting }
FMImporterAgregationDecorator >> isClass: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Class' " or: [ shortName ~= 'Attribute' ]"
]

{ #category : #parsing }
FMImporterAgregationDecorator >> primitive: value [

	importer primitive: value
]

{ #category : #parsing }
FMImporterAgregationDecorator >> referenceNumber: index [

	importer referenceNumber: index
]

{ #category : #running }
FMImporterAgregationDecorator >> run [

	importer parser new
		stream: importer stream;
		importer: self;
		run
]

{ #category : #parsing }
FMImporterAgregationDecorator >> serial: index [

	importer serial: index
]
