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

{ #category : #asserting }
FMImporterAggregationDecorator >> aggregatedMethodExistsFor: aClass [

	| methodName |
	methodName := '__aggregatedMethod__' , aClass name.
	^ aClass methods anySatisfy: [ :eachMethod |
		  eachMethod name = methodName ]
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

{ #category : #creating }
FMImporterAggregationDecorator >> createAggregatedMethod: aDescription [

	| aggMethEntity referencerMeth |
	referencerMeth := self currentEntity instance referencer.
	aggMethEntity := FMFutureEntity
		                 in: decoratedImporter
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

	| danglingMeth |
	(self isImportingMethod: aDescription) ifTrue: [
		decoratedImporter stack pop.
		danglingMeth := FMDanglingMethodReference new.
		danglingMeth parentType: (self serialDict at: currentParentTypeID).
		danglingMeth methodID: currentSerial.
		self reminderDict add: currentSerial -> danglingMeth.
		currentParentTypeID := nil ].

	(self isImportingReference: aDescription) ifTrue: [
		(self serialDict includesKey: currentReferencerID) ifTrue: [
			self currentEntity instance referencer:
				(self serialDict at: currentReferencerID) ].
		"ifFalse: [
						referencerMeth := self getAggregatedMethodFor:
							                  referencerMeth parentType ]
					ifFalse: [ self createAggregatedMethod: aDescription ] ]
			ifFalse: [ self createAggregatedMethod: aDescription ]."
		decoratedImporter endEntity: aDescription ].

	(self isImportingClass: aDescription) ifTrue: [
		decoratedImporter endEntity: aDescription ]
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endProperty: name [

	decoratedImporter endProperty: name
]

{ #category : #asserting }
FMImporterAggregationDecorator >> getAggregatedMethodFor: aClass [

	| methodName |
	methodName := '__aggregatedMethod__' , aClass name.
	^ aClass methods
		  detect: [ :eachMethod | eachMethod name = methodName ]
		  ifNone: [ nil ]
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
