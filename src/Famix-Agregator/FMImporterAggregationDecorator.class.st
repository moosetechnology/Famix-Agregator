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
		'classDict'
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

{ #category : #accessing }
FMImporterAggregationDecorator >> classDict [

	^ classDict
]

{ #category : #creating }
FMImporterAggregationDecorator >> createAggregatedMethod: aDescription [

	| aggMethEntity currentReference referencerMeth referencerClass |
	currentReference := importer currentEntity instance.
	referencerMeth := currentReference referencer.
	referencerClass := referencerMeth parentType.
	(self aggregatedMethodExistsFor: referencerClass) ifTrue: [ ^ self ].
	aggMethEntity := FMFutureEntity
		                 in: importer
		                 named:
		                 (aDescription
			                  copyReplaceAll: 'Reference'
			                  with: 'Method').
	aggMethEntity
		beginProperty: 'name';
		addToPropertyValues: '__aggregatedMethod__' , referencerClass name;
		endProperty.
	aggMethEntity
		beginProperty: 'parentType';
		addToPropertyValues: referencerClass;
		endProperty.
	self allEntities add: aggMethEntity instance.
	currentReference referencer: aggMethEntity instance
]

{ #category : #accessing }
FMImporterAggregationDecorator >> currentEntity [

	^ importer currentEntity
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endDocument [

	importer endDocument
]

{ #category : #parsing }
FMImporterAggregationDecorator >> endEntity: aDescription [

	| meth ref referencerMeth |
	1 halt.
	(self isImportingMethod: aDescription)
		ifTrue: [
			meth := importer stack pop instance.
			methodDict add: meth -> meth parentType.]
		ifFalse: [
			(self isImportingReference: aDescription) ifTrue: [
				ref := self currentEntity instance.
				referencerMeth := ref referencer.
				(methodDict includesKey: referencerMeth)
					ifTrue: [
						(self aggregatedMethodExistsFor: referencerMeth parentType)
							ifTrue: [
								referencerMeth := self getAggregatedMethodFor:
									                  referencerMeth parentType ]
							ifFalse: [ self createAggregatedMethod: aDescription ] ]
					ifFalse: [ self createAggregatedMethod: aDescription ] ].
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
