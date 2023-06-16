Class {
	#name : #FMImporterAggregationDecoratorTest,
	#superclass : #TestCase,
	#instVars : [
		'sourceModel',
		'importedModel'
	],
	#classInstVars : [
		'mseString'
	],
	#category : #'Famix-Agregator-Tests'
}

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> sourceModel [

	| model classA mA1 classB refA1toB mB1 |
	model := FamixJavaModel new.
	classA := FamixJavaClass named: 'ClassA'.
	mA1 := FamixJavaMethod named: 'methodA1'.
	mA1 parentType: classA.

	classB := FamixJavaClass named: 'ClassB'.
	mB1 := FamixJavaMethod named: 'methodB1'.
	mB1 parentType: classB.

	refA1toB := FamixJavaReference
		            source: mA1
		            target: classB
		            model: model.

	model addAll: {
			classA.
			classB.
			mA1.
			mB1. }.
	^ model
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> creatingRef [

	self
		mooseAssociation: FamixJavaReference
		source: (self mooseEntity: FamixJavaMethod named: 'methodA')
		target: (self mooseEntity: FamixJavaClass named: 'ClassA').

	self importModel
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest >> importModel [

	| mseString fileName stream |
	mseString := String streamContents: [ :s |
		             sourceModel exportToMSEStream: s ].

	fileName := 'sourceModel.mse'.
	stream := ('/home/users/etudiant' asFileReference / fileName)
		          writeStream. "stream := (FileLocator home / fileName) asFileReference."
	stream nextPutAll: mseString.
	stream close.

	importedModel := FamixJavaModel new
		                 importFrom: (FamixJavaModel
				                  importFrom: mseString readStream
				                  withMetamodel: FamixJavaModel metamodel
				                  customizingImporterWith: [ :importer |
				                  FMImporterAggregationDecorator on: importer ])
		                 named: 'testModel'
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> mooseAssociation: aFamixAssociation source: anEntity target: anotherEntity [

	^ aFamixAssociation
		  source: anEntity
		  target: anotherEntity
		  model: sourceModel
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> mooseEntity: aFamixEntity named: aString [

	^ aFamixEntity named: aString model: sourceModel
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> setUp [

	super setUp.

	sourceModel := FamixJavaModel new.
	importedModel := nil.
	
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> testAggregatedMethodCreated [

	| expectedAggregatedmethod |
	self mooseEntity: FamixJavaClass named: 'ClassA'.
	self importModel.

	self assert: importedModel allModelMethods size equals: 1.

	expectedAggregatedmethod := importedModel allModelMethods anyOne.

	self
		assert: expectedAggregatedmethod name
		equals: '__aggregatedMethod__ClassA'.
	self
		assert: expectedAggregatedmethod parentType name
		equals: 'ClassA'
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> testClassesAreImported [

	self mooseEntity: FamixJavaClass named: 'ClassA'.
	self importModel.

	self assert: importedModel allModelClasses size equals: 1.
	self assert: importedModel allModelClasses anyOne name equals: 'ClassA'
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> testMethodsInClassNotImported [

	(self mooseEntity: FamixJavaClass named: 'ClassA') addMethod:
		(self mooseEntity: FamixJavaMethod named: 'methodA').
	self importModel.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allModelClasses size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: '__aggregatedMethod__ClassA'
]
