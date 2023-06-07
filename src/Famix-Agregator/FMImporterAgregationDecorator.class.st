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
FMImporterAgregationDecorator >> beginEntity: description [

	importer beginEntity: description.
	(self isClassImporting: description)
		ifFalse: [ ^ self ]
		ifTrue: [
			self createAgregatedMethodWithDescription:
				(importer currentEntity instance metaDescription
					 copyReplaceAll: 'Class'
					 with: 'Method') ]
]

{ #category : #parsing }
FMImporterAgregationDecorator >> beginProperty: name [

	importer beginProperty: name
]

{ #category : #parsing }
FMImporterAgregationDecorator >> createAggregatedMethodWithDescription: aDescription for: aClass [

	| methodEntity aggregatedMethod |
	methodEntity := FMFutureEntity in: importer named: aDescription.
	aggregatedMethod := methodEntity instance.
	aggregatedMethod
		name: 'aggregatedMethod'; "name: 'aggregatedMethod' , aClass name"
		parentType: aClass.
	aClass addMethod: aggregatedMethod
]

{ #category : #parsing }
FMImporterAgregationDecorator >> createAggregatedMethodWithDescriptionV0: aDescription for: aClass [

	| agregatedMethod |
	agregatedMethod := FamixJavaMethod named: aDescription.
	agregatedMethod name: 'agregatedMethod'.
	aClass addMethod: agregatedMethod
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
