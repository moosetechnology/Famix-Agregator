"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

I represent a non resolved method.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	aggregatedMethod:		<Object>
	description:		<Object>
	importer:		<Object>
	methodID:		<Object>
	parentType:		<Object>


    Implementation Points
"
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

	aggregatedMethod name: '__aggregatedMethod__'.

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
