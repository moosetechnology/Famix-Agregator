Class {
	#name : #FMDanglingMethodReference,
	#superclass : #FMDanglingReference,
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMDanglingMethodReference >> resolve: element [
	
	self assert: element isNotNil.
	parentProperty
		replaceDanglingReferenceAt: position
		by: (element parentType methods detect: [ :eachMethod |
				 eachMethod name = '__aggregatedMethod__'
				 , element parentType name ])
]
