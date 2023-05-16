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

{ #category : #asserting }
FMImporterDecorator >> isClass: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Class' " or: [ shortName ~= 'Attribute' ]"
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
