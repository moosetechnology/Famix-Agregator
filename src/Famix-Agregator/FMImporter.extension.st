Extension { #name : #FMImporter }

{ #category : #'*Famix-Agregator' }
FMImporter >> assignDanglingMethod: element to: serial [

	| todo |
	todo := reminderDict removeKey: serial ifAbsent: [ {  } ].
	todo do: [ :each |
		each resolve: element ensureCreateAggregatedMethod.
		numberOfDanglingReferences := numberOfDanglingReferences - 1.
		self assert: numberOfDanglingReferences >= 0 ].
	serialDict
		at: serial
		put: (element aggregatedMethod ifNil: [ element ])
]

{ #category : #'*Famix-Agregator' }
FMImporter >> entities [

	^ entities
]

{ #category : #'*Famix-Agregator' }
FMImporter >> entityAt: aNumber ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	

	^ serialDict at: aNumber ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'*Famix-Agregator' }
FMImporter >> reminderDict [
	^ reminderDict
]

{ #category : #'*Famix-Agregator' }
FMImporter >> serialDict [
	^ serialDict
]

{ #category : #'*Famix-Agregator' }
FMImporter >> stack [

	^ stack
]
