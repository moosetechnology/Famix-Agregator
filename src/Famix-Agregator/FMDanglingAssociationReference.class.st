"
I represent a non resolved association.

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them.

Public API and Key Messages

- message one
- message two
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.

Internal Representation and Key Implementation Points.

    Instance Variables
	description:		<Object>
	importer:		<Object>
	sourceTypeID:		<Object>
	targetTypeID:		<Object>


    Implementation Points
"
Class {
	#name : #FMDanglingAssociationReference,
	#superclass : #Object,
	#instVars : [
		'referenceID',
		'sourceID',
		'targetID',
		'importer',
		'description',
		'sourceType',
		'targetType'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMDanglingAssociationReference >> description: anObject [

	description := anObject
]

{ #category : #accessing }
FMDanglingAssociationReference >> importer: anObject [

	importer := anObject
]

{ #category : #testing }
FMDanglingAssociationReference >> isDanglingReference [

	^ true
]

{ #category : #resolving }
FMDanglingAssociationReference >> maybeResolve [

	sourceType ~= targetType ifTrue: [ ]
]

{ #category : #accessing }
FMDanglingAssociationReference >> referenceID [

	^ referenceID
]

{ #category : #accessing }
FMDanglingAssociationReference >> referenceID: aNumber [

	referenceID := aNumber
]

{ #category : #accessing }
FMDanglingAssociationReference >> sourceID: aNumber [

	sourceID := aNumber
]

{ #category : #accessing }
FMDanglingAssociationReference >> sourceType: anEntity [

	sourceType := anEntity
]

{ #category : #accessing }
FMDanglingAssociationReference >> targetID: aNumber [

	targetID := aNumber
]

{ #category : #accessing }
FMDanglingAssociationReference >> targetType: anEntity [

	targetType := anEntity
]
