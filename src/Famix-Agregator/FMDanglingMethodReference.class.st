Class {
	#name : #FMDanglingMethodReference,
	#superclass : #Object,
	#instVars : [
		'methodID',
		'parentType',
		'importer'
	],
	#category : #'Famix-Agregator-Core'
}

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
FMDanglingMethodReference >> parentType: aNumber [

	^ parentType := aNumber
]

{ #category : #accessing }
FMDanglingMethodReference >> resolve: element [
	"this method is polymorphic with FMDanglingReference. This entity is now resolvable. It will be replaced by the parentType aggregated method only it is referenced elsewhere in the file."

	self assert: element isNotNil.
	parentType := element.
	importer assign: self to: methodID
]
