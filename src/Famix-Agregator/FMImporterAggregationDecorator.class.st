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
		'decoratedImporter',
		'currentParser'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #'instance creation' }
FMImporterAggregationDecorator class >> on: aFMImporter [

	^ self new
		  decoratedImporter: aFMImporter;
		  yourself
]

{ #category : #accessing }
FMImporterAggregationDecorator >> allEntities [

	^ decoratedImporter entities
]

{ #category : #parsing }
FMImporterAggregationDecorator >> assignDanglingMethod: element to: serial [

	decoratedImporter assignDanglingMethod: element to: serial
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginDocument [

	decoratedImporter beginDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginEntity: aDescription [

	| translatedName |
	translatedName := decoratedImporter translationUnit translate:
		                  aDescription.
	decoratedImporter stack push:
		(FMFutureEntity in: self named: translatedName)
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginProperty: name [

	decoratedImporter beginProperty: name
]

{ #category : #accessing }
FMImporterAggregationDecorator >> currentEntity [

	^ decoratedImporter currentEntity
]

{ #category : #accessing }
FMImporterAggregationDecorator >> currentParser [

	^ currentParser
]

{ #category : #private }
FMImporterAggregationDecorator >> dangling: aFMDanglingReference to: anInteger [

^ decoratedImporter dangling: aFMDanglingReference to: anInteger
]

{ #category : #accessing }
FMImporterAggregationDecorator >> decoratedImporter [

	^ decoratedImporter
]

{ #category : #accessing }
FMImporterAggregationDecorator >> decoratedImporter: anObject [

	decoratedImporter := anObject
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endDocument [

	decoratedImporter endDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endEntity: aDescription [

	decoratedImporter endEntity: aDescription
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endProperty: name [

	decoratedImporter endProperty: name
]

{ #category : #parsing }
FMImporterAggregationDecorator >> entityAt: serial ifAbsent: aBlock [

	^ decoratedImporter
		  entityAt: serial
		  ifPresent: [ :element |
			
			  element isDanglingReference
				  ifTrue: [ element ensureCreateAggregatedMethod ]
				  ifFalse: [ element ] ]
		  ifAbsent: aBlock
]

{ #category : #parsing }
FMImporterAggregationDecorator >> inEntity: aDescription do: aBlock [

	(self isImportingMethod: aDescription) ifTrue: [
		| methodImporter |
		methodImporter := FMMethodImporter on: self.
		currentParser importer: methodImporter.
		methodImporter beginEntity: aDescription.
		aBlock value.
		currentParser importer: self.
		^ self ].

	self beginEntity: aDescription.
	aBlock value.
	self endEntity: aDescription
]

{ #category : #asserting }
FMImporterAggregationDecorator >> isImportingMethod: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Method'
]

{ #category : #meta }
FMImporterAggregationDecorator >> metamodel [

	^ decoratedImporter metamodel
]

{ #category : #accessing }
FMImporterAggregationDecorator >> model [

 ^ decoratedImporter model
]

{ #category : #accessing }
FMImporterAggregationDecorator >> parser [

	^ decoratedImporter parser
]

{ #category : #parsing }
FMImporterAggregationDecorator >> primitive: value [

	decoratedImporter primitive: value
]

{ #category : #parsing }
FMImporterAggregationDecorator >> referenceNumber: index [

	decoratedImporter referenceNumber: index
]

{ #category : #accessing }
FMImporterAggregationDecorator >> reminderDict [

	^ decoratedImporter reminderDict
]

{ #category : #running }
FMImporterAggregationDecorator >> run [
	
	currentParser := decoratedImporter parser new.
	currentParser
		stream: decoratedImporter stream;
		importer: self;
		run
		
]

{ #category : #accessing }
FMImporterAggregationDecorator >> serial: index [

	decoratedImporter serial: index.
]

{ #category : #accessing }
FMImporterAggregationDecorator >> serialDict [

	^ decoratedImporter serialDict
]
