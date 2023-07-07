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
		'sourceTypeID',
		'targetTypeID',
		'importer',
		'description'
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

{ #category : #accessing }
FMDanglingAssociationReference >> sourceTypeID [

	^ sourceTypeID
]

{ #category : #accessing }
FMDanglingAssociationReference >> sourceTypeID: anObject [

	sourceTypeID := anObject
]

{ #category : #accessing }
FMDanglingAssociationReference >> targetTypeID [

	^ targetTypeID
]

{ #category : #accessing }
FMDanglingAssociationReference >> targetTypeID: anObject [

	targetTypeID := anObject
]
