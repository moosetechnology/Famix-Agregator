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
		'importer',
		'methodDict',
		'currentParentTypeID',
		'currentSerial',
		'currentReferencerID',
		'currentReferredTypeID'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #'instance creation' }
FMImporterAggregationDecorator class >> on: aFMImporter [

	^ self new
		  importer: aFMImporter;
		  yourself
]

{ #category : #asserting }
FMImporterAggregationDecorator >> aggregatedMethodExistsFor: aClass [

	| methodName |
	methodName := '__aggregatedMethod__' , aClass name.
	^ aClass methods anySatisfy: [ :eachMethod |
		  eachMethod name = methodName ]
]

{ #category : #accessing }
FMImporterAggregationDecorator >> allEntities [

	^ importer entities
]

{ #category : #parsing }
FMImporterAggregationDecorator >> beginDocument [

	methodDict := Dictionary new.
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

{ #category : #creating }
FMImporterAggregationDecorator >> createAggregatedMethod: aDescription [

	| aggMethEntity referencerMeth |
	referencerMeth := self currentEntity instance referencer.
	aggMethEntity := FMFutureEntity
		                 in: importer
		                 named:
		                 (aDescription
			                  copyReplaceAll: 'Reference'
			                  with: 'Method').
	aggMethEntity
		beginProperty: 'name';
		addToPropertyValues:
			'__aggregatedMethod__' , referencerMeth parentType name;
		endProperty.
	aggMethEntity
		beginProperty: 'parentType';
		addToPropertyValues: referencerMeth parentType;
		endProperty.
	self allEntities add: aggMethEntity instance.
	self currentEntity instance referencer: aggMethEntity instance
]

{ #category : #accessing }
FMImporterAggregationDecorator >> currentEntity [

	^ importer currentEntity
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

{ #category : #parsing }
FMImporterAggregationDecorator >> endDocument [

	importer endDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endEntity: aDescription [

	| danglingMeth |
	1 halt.
	(self isImportingMethod: aDescription) ifTrue: [
		importer stack pop.
		danglingMeth := FMDanglingMethodReference new.
		danglingMeth parentTypeID: currentParentTypeID.
		danglingMeth methodID: currentSerial.
		self reminderDict add: currentSerial -> danglingMeth.
		currentParentTypeID := nil ].

	(self isImportingReference: aDescription) ifTrue: [
		(self serialDict includesKey: currentReferencerID)
			ifTrue: [ self currentEntity instance referencer: (self serialDict at: currentReferencerID)].
			"ifFalse: [
						referencerMeth := self getAggregatedMethodFor:
							                  referencerMeth parentType ]
					ifFalse: [ self createAggregatedMethod: aDescription ] ]
			ifFalse: [ self createAggregatedMethod: aDescription ]."
		importer endEntity: aDescription ].

	(self isImportingClass: aDescription) ifTrue: [
		importer endEntity: aDescription ]
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endProperty: name [

	importer endProperty: name
]

{ #category : #asserting }
FMImporterAggregationDecorator >> getAggregatedMethodFor: aClass [

	| methodName |
	methodName := '__aggregatedMethod__' , aClass name.
	^ aClass methods
		  detect: [ :eachMethod | eachMethod name = methodName ]
		  ifNone: [ nil ]
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
FMImporterAggregationDecorator >> methodDict [

	^ methodDict
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

	importer referenceNumber: index.

	self currentEntity currentProperty metaDescription name = #parentType
		ifTrue: [ currentParentTypeID := index ].

	self currentEntity currentProperty metaDescription name = #referencer
		ifTrue: [ currentReferencerID := index ].

	self currentEntity currentProperty metaDescription name = #referredType
		ifTrue: [ currentReferredTypeID := index ]
]

{ #category : #parsing }
FMImporterAggregationDecorator >> reminderDict [

	^ importer reminderDict
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

	importer serial: index.
	currentSerial := index
]

{ #category : #parsing }
FMImporterAggregationDecorator >> serialDict [

	^ importer serialDict
]
