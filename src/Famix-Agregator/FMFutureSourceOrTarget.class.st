Class {
	#name : #FMFutureSourceOrTarget,
	#superclass : #FMFutureProperty,
	#category : #'Famix-Agregator-Core'
}

{ #category : #parsing }
FMFutureSourceOrTarget >> maybeEnd [

	super maybeEnd.
	self parentEntity maybeResolve
]

{ #category : #parsing }
FMFutureSourceOrTarget >> referenceNumber: serial [

	self addToValues: (self importer decoratedImporter
			 entityAt: serial
			 ifPresent: [ :entity |
				 entity isDanglingReference
					 ifTrue: [
						 entity maybeResolve.
						 entity aggregatedMethod ifNil: [
							 self importer
								 dangling: (FMDanglingReference with: self)
								 to: serial ] ]
					 ifFalse: [ entity ] ]
			 ifAbsent: [
			 self importer
				 dangling: (FMDanglingReference with: self)
				 to: serial ])
]
