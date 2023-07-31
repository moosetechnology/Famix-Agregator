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
	#name : #FMDanglingMethod,
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
FMDanglingMethod >> aggregatedMethod [

	^ aggregatedMethod
]

{ #category : #'creating a method' }
FMDanglingMethod >> createAggregatedMethod [

	aggregatedMethod := (importer metamodel elementNamed: description)
		                    createInstance.

	aggregatedMethod name: '__aggregatedMethod__'.

	aggregatedMethod parentType: parentType.

	importer allEntities add: aggregatedMethod.

	^ aggregatedMethod
]

{ #category : #accessing }
FMDanglingMethod >> description: aDescription [

	description := aDescription
]

{ #category : #'creating a method' }
FMDanglingMethod >> ensureCreateAggregatedMethod [
	"ensures the existence of the unique aggregated method in the class. If the class doesn't already have an aggregated method, it creates it."

	parentType methods ifEmpty: [ self createAggregatedMethod ].
	^ parentType methods anyOne
]

{ #category : #accessing }
FMDanglingMethod >> importer: anObject [

	importer := anObject
]

{ #category : #testing }
FMDanglingMethod >> isDanglingReference [

	^ true
]

{ #category : #accessing }
FMDanglingMethod >> methodID [

	^ methodID
]

{ #category : #accessing }
FMDanglingMethod >> methodID: aNumber [

	^ methodID := aNumber
]

{ #category : #accessing }
FMDanglingMethod >> parentType [

	^ parentType
]

{ #category : #resolving }
FMDanglingMethod >> resolve: element [
	"this method is polymorphic with FMDanglingReference. This entity is now resolvable. It will be replaced by the parentType's aggregated method only if it is referenced elsewhere in the file."

	self assert: element isNotNil.
	parentType := element.
	importer assignDanglingMethod: self to: methodID
]
