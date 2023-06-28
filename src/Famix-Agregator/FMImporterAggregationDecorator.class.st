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
		'currentParentTypeID',
		'currentSerial',
		'currentReferencerID',
		'currentReferredTypeID',
		'decoratedImporter'
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
FMImporterAggregationDecorator >> beginDocument [

	decoratedImporter beginDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginEntity: aDescription [

	(self isImportingMethod: aDescription) ifTrue: [
		| methodImporter |
		methodImporter := FMMethodImporter on: self.
		self parser decoratedImporter: methodImporter.
		methodImporter beginEntity: aDescription.
		^ self ].
	
	decoratedImporter beginEntity: aDescription
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginProperty: name [

	decoratedImporter beginProperty: name
]

{ #category : #accessing }
FMImporterAggregationDecorator >> currentEntity [

	^ decoratedImporter currentEntity
]

{ #category : #parsing }
FMImporterAggregationDecorator >> currentParentTypeID [

	^ currentParentTypeID
]

{ #category : #accessing }
FMImporterAggregationDecorator >> currentReferencerID [

	^ currentReferencerID
]

{ #category : #parsing }
FMImporterAggregationDecorator >> currentReferredTypeID [

	^ currentReferredTypeID
]

{ #category : #parsing }
FMImporterAggregationDecorator >> currentSerial [

	^ currentSerial
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

{ #category : #asserting }
FMImporterAggregationDecorator >> entityAt: serial ifAbsent: aBlock [

	^ decoratedImporter entityAt: serial ifPresent: [ :element | element isDanglingReference ifTrue: [ element ensureCreateAggregatedMethod ] ifFalse: [ element ] ] ifAbsent: aBlock
]

{ #category : #asserting }
FMImporterAggregationDecorator >> isImportingClass: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Class'
]

{ #category : #asserting }
FMImporterAggregationDecorator >> isImportingMethod: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Method'
]

{ #category : #asserting }
FMImporterAggregationDecorator >> isImportingReference: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Reference'
]

{ #category : #accessing }
FMImporterAggregationDecorator >> model [

 ^ decoratedImporter model
]

{ #category : #parsing }
FMImporterAggregationDecorator >> parser [

	^ decoratedImporter parser
]

{ #category : #parsing }
FMImporterAggregationDecorator >> primitive: value [

	decoratedImporter primitive: value
]

{ #category : #parsing }
FMImporterAggregationDecorator >> referenceNumber: index [

	decoratedImporter referenceNumber: index.

	self currentEntity currentProperty metaDescription name = #parentType
		ifTrue: [ currentParentTypeID := index ].

	self currentEntity currentProperty metaDescription name = #referencer
		ifTrue: [ currentReferencerID := index ].

	self currentEntity currentProperty metaDescription name = #referredType
		ifTrue: [ currentReferredTypeID := index ]
]

{ #category : #parsing }
FMImporterAggregationDecorator >> reminderDict [

	^ decoratedImporter reminderDict
]

{ #category : #running }
FMImporterAggregationDecorator >> run [

	decoratedImporter parser new
		stream: decoratedImporter stream;
		decoratedImporter: self;
		run
]

{ #category : #parsing }
FMImporterAggregationDecorator >> serial: index [

	decoratedImporter serial: index.
	currentSerial := index
]

{ #category : #parsing }
FMImporterAggregationDecorator >> serialDict [

	^ decoratedImporter serialDict
]
