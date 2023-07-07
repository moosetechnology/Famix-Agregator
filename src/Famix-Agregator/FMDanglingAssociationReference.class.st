Class {
	#name : #FMDanglingAssociationReference,
	#superclass : #Object,
	#instVars : [
		'sourceTypeID',
		'targetTypeID',
		'importer'
	],
	#category : #'Famix-Agregator-Core'
}

{ #category : #testing }
FMDanglingAssociationReference >> isDanglingReference [

	^ true
]
