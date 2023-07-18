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
		'source',
		'target',
		'association'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #creating }
FMDanglingAssociationReference >> createAssociation [

	association := (importer metamodel elementNamed: description)
		               createInstance.
	association source: source.
	association target: target.
	^ association
]

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

{ #category : #accessing }
FMDanglingAssociationReference >> referenceID [

	^ referenceID
]

{ #category : #accessing }
FMDanglingAssociationReference >> referenceID: aNumber [

	referenceID := aNumber
]

{ #category : #resolving }
FMDanglingAssociationReference >> resolve: element [

	
]

{ #category : #accessing }
FMDanglingAssociationReference >> source: anEntity [

	source := anEntity
]

{ #category : #accessing }
FMDanglingAssociationReference >> sourceID: aNumber [

	sourceID := aNumber
]

{ #category : #accessing }
FMDanglingAssociationReference >> target: anEntity [

	target := anEntity
]

{ #category : #accessing }
FMDanglingAssociationReference >> targetID: aNumber [

	targetID := aNumber
]
