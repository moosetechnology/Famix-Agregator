Class {
	#name : #FMImporterAggregationDecoratorTest,
	#superclass : #TestCase,
	#instVars : [
		'sourceModel',
		'importedModel'
	],
	#category : #'Famix-Agregator-Tests'
}

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> inspectModelClassMethodRef [

	<script>
	self modelClassMethodRef inspect
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelClassMethodRef [

	| model classA mA classB refmethodAtoclassB |
	model := FamixJavaModel new.
	classA := FamixJavaClass named: 'ClassA'.
	mA := FamixJavaMethod named: 'methodA'.
	mA parentType: classA.

	classB := FamixJavaClass named: 'ClassB'.

	refmethodAtoclassB := FamixJavaReference source: mA target: classB.

	model addAll: {
			classA.
			classB.
			mA.
			refmethodAtoclassB }.
	^ model
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> classA [

	^ self mooseEntity: FamixJavaClass named: 'ClassA'
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> classB [

	^ self mooseEntity: FamixJavaClass named: 'ClassB'
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest >> importModel [

	| mseString fileName stream testResourcesDirectory |
	mseString := String streamContents: [ :s |
		             sourceModel exportToMSEStream: s ].

	fileName := 'sourceModel.mse'.
	testResourcesDirectory := (FileLocator localDirectory
	                           / 'iceberg/moosetechnology/Famix-Agregator/Test-resources')
		                          ensureCreateDirectory.
	(testResourcesDirectory / fileName) ensureCreateFile.
	stream := (testResourcesDirectory / fileName) asFileReference writeStream.
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

{ #category : #tests }
FMImporterAggregationDecoratorTest >> methodA [

	^ self mooseEntity: FamixJavaMethod named: 'methodA'
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> methodB [

	^ self mooseEntity: FamixJavaMethod named: 'methodB'
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
FMImporterAggregationDecoratorTest >> testAggregatedMethodNotCreatedWhenNoAssociation [
	
	self classA addMethod: self methodA.
	self importModel.

	self assert: importedModel allModelMethods size equals: 0.
	self assert: importedModel allModelClasses size equals: 1
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> testClassesAreImported [

	self classA.
	self importModel.

	self assert: importedModel allModelClasses size equals: 1.
	self
		assert: importedModel allModelClasses anyOne name
		equals: 'ClassA'
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> testReference [

	| methodA |
	methodA := self methodA.
	self classA addMethod: methodA.
	self
		mooseAssociation: FamixJavaReference
		source: methodA
		target: self classB.
	self importModel.
	
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: '__aggregatedMethod__ClassA'.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: '__aggregatedMethod__ClassA'.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> testReferenceClassMethodRef [

	| methodA |
	methodA := self methodA.
	self classA addMethod: methodA.
	self
		mooseAssociation: FamixJavaReference
		source: methodA
		target: self classB.
	self importModel.
	
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: '__aggregatedMethod__ClassA'.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: '__aggregatedMethod__ClassA'.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]
