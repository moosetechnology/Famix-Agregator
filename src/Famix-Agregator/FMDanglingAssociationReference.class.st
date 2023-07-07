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
