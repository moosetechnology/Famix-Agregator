Class {
	#name : #FMAgregatedImporter,
	#superclass : #Object,
	#traits : 'FMTImportExportStructure',
	#classTraits : 'FMTImportExportStructure classTrait',
	#instVars : [
		'importer'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #'instance creation' }
FMAgregatedImporter class >> on: aFMImporter [

	^ self new
		  importer: aFMImporter;
		  yourself
]

{ #category : #parsing }
FMAgregatedImporter >> beginDocument [

	importer beginDocument
]

{ #category : #parsing }
FMAgregatedImporter >> beginEntity: name [

	(self shouldAgregate: name)
		ifTrue: [  ]
		ifFalse: [ importer beginEntity: name ]
]

{ #category : #parsing }
FMAgregatedImporter >> beginProperty: name [

	importer beginProperty: name
]

{ #category : #parsing }
FMAgregatedImporter >> endDocument [

	importer endDocument
]

{ #category : #parsing }
FMAgregatedImporter >> endEntity: name [

	importer endEntity: name
]

{ #category : #parsing }
FMAgregatedImporter >> endProperty: name [

	importer endProperty: name
]

{ #category : #accessing }
FMAgregatedImporter >> importer [

	^ importer
]

{ #category : #accessing }
FMAgregatedImporter >> importer: anObject [

	importer := anObject
]

{ #category : #parsing }
FMAgregatedImporter >> primitive: value [

	importer primitive: value
]

{ #category : #parsing }
FMAgregatedImporter >> referenceNumber: index [

	importer referenceNumber: index
]

{ #category : #running }
FMAgregatedImporter >> run [

	importer parser new
		stream: importer stream;
		importer: self;
		run
]

{ #category : #parsing }
FMAgregatedImporter >> serial: index [

	importer serial: index
]

{ #category : #asserting }
FMAgregatedImporter >> shouldAgregate: aString [

	| shortName |
	shortName := (aString findTokens: $.) last.
	^ shortName = 'Method' " or: [ shortName ~= 'Attribute' ]"
]
