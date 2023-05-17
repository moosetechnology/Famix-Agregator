"
I represent a decorator of the model importer.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	importer:		<Object>


    Implementation Points
"
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

	importer beginEntity: name.

	(self isClassImporting: name) ifTrue: [ self createAgregatedMethod ]
]

{ #category : #parsing }
FMImporterAgregationDecorator >> beginProperty: name [

	importer beginProperty: name
]

{ #category : #parsing }
FMImporterAgregationDecorator >> createAgregatedMethod [

	| agregatedMethod currentEntityInstance |
	currentEntityInstance := importer currentEntity instance.
	agregatedMethod := FMFutureEntity
		                   in: self
		                   named:
		                   (currentEntityInstance name
			                    copyReplaceAll: 'Class'
			                    with: 'Method').
	agregatedMethod instance parentType: currentEntityInstance.
	agregatedMethod instance name:
		'agregatedMethod' , currentEntityInstance name.
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
FMImporterAgregationDecorator >> isClassImporting: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Class'
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
