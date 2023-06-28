Class {
	#name : #FMDanglingMethodReference,
	#superclass : #Object,
	#instVars : [
		'methodID',
		'parentType',
		'importer',
		'aggregatedMethod',
		'description'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMDanglingMethodReference >> aDescription: anObject [

	description := anObject
]

{ #category : #accessing }
FMDanglingMethodReference >> aggregatedMethod [

	^ aggregatedMethod
]

{ #category : #accessing }
FMDanglingMethodReference >> createAggregatedMethod [

	aggregatedMethod := FMFutureEntity in: importer named: description.
	
	aggregatedMethod
		beginProperty: 'name';
		addToPropertyValues: '__aggregatedMethod__';
		endProperty. ", parentType name"
	self flag:
		'we cannot access parentType name when the file order is method -> ref -> class. The resolution of this DMR is triggered by serial which is before inProperty: do:'.

	aggregatedMethod
		beginProperty: 'parentType';
		addToPropertyValues: parentType;
		endProperty.
	importer allEntities add: aggregatedMethod instance.
	^ aggregatedMethod instance
]

{ #category : #accessing }
FMDanglingMethodReference >> description: aDescription [

	description := aDescription
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
