Class {
	#name : #FMDanglingMethodReference,
	#superclass : #Object,
	#instVars : [
		'methodID',
		'parentType',
		'importer',
		'aggregatedMethod',
		'aDescription'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMDanglingMethodReference >> aDescription: anObject [

	aDescription := anObject
]

{ #category : #accessing }
FMDanglingMethodReference >> aggregatedMethod [

	^ aggregatedMethod
]

{ #category : #accessing }
FMDanglingMethodReference >> createAggregatedMethod [

	aggregatedMethod := FMFutureEntity in: importer named: aDescription.
	aggregatedMethod
		beginProperty: 'name';
		addToPropertyValues:
			'__aggregatedMethod__' , aggregatedMethod parentType name;
		endProperty.
	aggregatedMethod
		beginProperty: 'parentType';
		addToPropertyValues: parentType;
		endProperty.
	importer allEntities add: aggregatedMethod instance
]

{ #category : #accessing }
FMDanglingMethodReference >> ensureCreateAggregatedMethod [

	^ aggregatedMethod ifNil: [ self createAggregatedMethod ]
]

{ #category : #accessing }
FMDanglingMethodReference >> importer: anObject [

	importer := anObject
]

{ #category : #accessing }
FMDanglingMethodReference >> isDanglingReference [

	^ true
]

{ #category : #accessing }
FMDanglingMethodReference >> methodID [

	^ methodID
]

{ #category : #accessing }
FMDanglingMethodReference >> methodID: aNumber [

	^ methodID := aNumber
]

{ #category : #accessing }
FMDanglingMethodReference >> parentType [

	^ parentType
]

{ #category : #accessing }
FMDanglingMethodReference >> resolve: element [
	"this method is polymorphic with FMDanglingReference. This entity is now resolvable. It will be replaced by the parentType's aggregated method only if it is referenced elsewhere in the file."

	self assert: element isNotNil.
	parentType := element.

	importer assignDanglingMethod: self to: methodID
]
