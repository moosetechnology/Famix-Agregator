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
	#name : #FMImporterAggregationDecorator,
	#superclass : #Object,
	#traits : 'FMTImportExportStructure',
	#classTraits : 'FMTImportExportStructure classTrait',
	#instVars : [
		'importer'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #'instance creation' }
FMImporterAggregationDecorator class >> on: aFMImporter [

	^ self new
		  importer: aFMImporter;
		  yourself
]

{ #category : #parsing }
FMImporterAggregationDecorator >> allEntities [

	^ importer entities
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginDocument [

	importer beginDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginEntity: aDescription [

	importer beginEntity: aDescription
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginProperty: name [

	importer beginProperty: name
]

{ #category : #parsing }
FMImporterAggregationDecorator >> createAggregatedMethodWithDescription: aDescription [

	| methodEntity |
	methodEntity := FMFutureEntity in: importer named: (aDescription copyReplaceAll: 'Class' with: 'Method').
	methodEntity
		beginProperty: 'name';
		addToPropertyValues: '__aggregatedMethod__' , importer currentEntity instance name;
		endProperty.
	methodEntity
		beginProperty: 'parentType';
		addToPropertyValues: importer currentEntity instance;
		endProperty.
	self allEntities add: methodEntity instance
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endDocument [

	importer endDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endEntity: aDescription [

	(self isClassImporting: aDescription)
		ifFalse: [ ^ self ]
		ifTrue: [ self createAggregatedMethodWithDescription: aDescription ].
	importer endEntity: aDescription
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endProperty: name [

	importer endProperty: name
]

{ #category : #accessing }
FMImporterAggregationDecorator >> importer [

	^ importer
]

{ #category : #accessing }
FMImporterAggregationDecorator >> importer: anObject [

	importer := anObject
]

{ #category : #asserting }
FMImporterAggregationDecorator >> isClassImporting: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Class'
]

{ #category : #asserting }
FMImporterAggregationDecorator >> isMethodImporting: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Method'
]

{ #category : #accessing }
FMImporterAggregationDecorator >> model [

 ^ importer model
]

{ #category : #parsing }
FMImporterAggregationDecorator >> primitive: value [

	importer primitive: value
]

{ #category : #parsing }
FMImporterAggregationDecorator >> referenceNumber: index [

	importer referenceNumber: index
]

{ #category : #running }
FMImporterAggregationDecorator >> run [

	importer parser new
		stream: importer stream;
		importer: self;
		run
]

{ #category : #parsing }
FMImporterAggregationDecorator >> serial: index [

	importer serial: index
]
