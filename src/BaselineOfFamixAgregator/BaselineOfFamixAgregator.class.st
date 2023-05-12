Class {
	#name : #BaselineOfFamixAgregator,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixAgregator
}

{ #category : #baselines }
BaselineOfFamixAgregator >> baseline: spec [

	<baseline>
	spec for: #common do: [ spec package: 'Famix-Agregator' ]
]
