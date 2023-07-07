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
FMDanglingMethodReference >> aggregatedMethod [

	^ aggregatedMethod
]

{ #category : #'creating a method' }
FMDanglingMethodReference >> createAggregatedMethod [

	aggregatedMethod := (importer metamodel elementNamed: description)
		                    createInstance.

	aggregatedMethod name: '__aggregatedMethod__'. ", parentType name"
	self flag:
		'we cannot access parentType name when the file order is method -> ref -> class. The resolution of this DMR is triggered by serial which is before inProperty: do:'.

	aggregatedMethod parentType: parentType.

	importer allEntities add: aggregatedMethod.

	^ aggregatedMethod
]

{ #category : #accessing }
FMDanglingMethodReference >> description: aDescription [

	description := aDescription
]

{ #category : #'creating a method' }
FMDanglingMethodReference >> ensureCreateAggregatedMethod [
	"ensures the existence of the unique aggregated method in the class. If the class doesn't already have an aggregated method, it creates it."

	parentType methods ifEmpty: [ self createAggregatedMethod ].
	^ parentType methods anyOne
]

{ #category : #accessing }
FMDanglingMethodReference >> importer: anObject [

	importer := anObject
]

{ #category : #testing }
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

{ #category : #resolving }
FMDanglingMethodReference >> resolve: element [
	"this method is polymorphic with FMDanglingReference. This entity is now resolvable. It will be replaced by the parentType's aggregated method only if it is referenced elsewhere in the file."

	self assert: element isNotNil.
	parentType := element.

	importer assignDanglingMethod: self to: methodID
]
