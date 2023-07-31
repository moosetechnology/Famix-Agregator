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
	#name : #FMDanglingAssociation,
	#superclass : #Object,
	#instVars : [
		'referenceID',
		'sourceID',
		'targetID',
		'importer',
		'description',
		'source',
		'target'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #accessing }
FMDanglingAssociation >> description: anObject [

	description := anObject
]

{ #category : #accessing }
FMDanglingAssociation >> importer: anObject [

	importer := anObject
]

{ #category : #testing }
FMDanglingAssociation >> isDanglingReference [

	^ true
]

{ #category : #accessing }
FMDanglingAssociation >> referenceID [

	^ referenceID
]

{ #category : #accessing }
FMDanglingAssociation >> referenceID: aNumber [

	referenceID := aNumber
]

{ #category : #resolving }
FMDanglingAssociation >> resolve: element [

	
]

{ #category : #accessing }
FMDanglingAssociation >> source: anEntity [

	source := anEntity
]

{ #category : #accessing }
FMDanglingAssociation >> sourceID: aNumber [

	sourceID := aNumber
]

{ #category : #accessing }
FMDanglingAssociation >> target: anEntity [

	target := anEntity
]

{ #category : #accessing }
FMDanglingAssociation >> targetID: aNumber [

	targetID := aNumber
]
