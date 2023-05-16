Class {
	#name : #FMImporterDecorator,
	#superclass : #Object,
	#traits : 'FMTImportExportStructure',
	#classTraits : 'FMTImportExportStructure classTrait',
	#instVars : [
		'importer'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #'instance creation' }
FMImporterDecorator class >> on: aFMImporter [

	^ self new
		  importer: aFMImporter;
		  yourself
]

{ #category : #parsing }
FMImporterDecorator >> beginDocument [

	importer beginDocument
]

{ #category : #parsing }
FMImporterDecorator >> beginEntity: name [

	| agregatedMethod |
	
	importer beginEntity: name
]

{ #category : #parsing }
FMImporterDecorator >> beginProperty: name [

	importer beginProperty: name
]

{ #category : #parsing }
FMImporterDecorator >> endDocument [

	importer endDocument
]

{ #category : #parsing }
FMImporterDecorator >> endEntity: name [

	importer endEntity: name
]

{ #category : #parsing }
FMImporterDecorator >> endProperty: name [

	importer endProperty: name
]

{ #category : #accessing }
FMImporterDecorator >> importer [

	^ importer
]

{ #category : #accessing }
FMImporterDecorator >> importer: anObject [

	importer := anObject
]

{ #category : #parsing }
FMImporterDecorator >> primitive: value [

	importer primitive: value
]

{ #category : #parsing }
FMImporterDecorator >> referenceNumber: index [

	importer referenceNumber: index
]

{ #category : #running }
FMImporterDecorator >> run [

	importer parser new
		stream: importer stream;
		importer: self;
		run
]

{ #category : #parsing }
FMImporterDecorator >> serial: index [

	importer serial: index
]

{ #category : #asserting }
FMImporterDecorator >> shouldAgregate: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Method' " or: [ shortName ~= 'Attribute' ]"
]
