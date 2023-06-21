Class {
	#name : #FMDanglingMethodReference,
	#superclass : #FMDanglingReference,
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMDanglingMethodReference >> resolve: element [

	| aggMethod methName |
	methName := '__aggregatedMethod__'
		             , element parentType name.
	self assert: element isNotNil.
	aggMethod := element parentType methods detect: [ :meth |
		             meth name = methName ].

	parentProperty replaceDanglingReferenceAt: position by: aggMethod
]
