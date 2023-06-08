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
FMImporterAggregationDecoratorTest class >> inspectMseString [

	<script>
	self mseString inspect
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> mseString [

	^ mseString ifNil: [ 
		  mseString := String streamContents: [ :s | 
			               self sourceModel exportToMSEStream: s ] ]
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> sourceModel [

	| model classA mA1 mA2 classB refA1toB mB1 mB2 |
	model := FamixJavaModel new.
	classA := FamixJavaClass named: 'ClassA'.
	mA1 := FamixJavaMethod named: 'methodA1'.
	mA1 parentType: classA.
	mA2 := FamixJavaMethod named: 'methodA2'.
	mA2 parentType: classA.

	classB := FamixJavaClass named: 'ClassB'.
	mB1 := FamixJavaMethod named: 'methodB1'.
	mB1 parentType: classB.
	mB2 := FamixJavaMethod named: 'methodB2'.
	mB2 parentType: classB.

	refA1toB := FamixJavaReference
		            source: mA1
		            target: classB
		            model: model.

	model addAll: { 
			classA.
			classB.
			mA1.
			mA2.
			mB1.
			mB2 }.
	^ model
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest >> importModel [

	| mseString |
	mseString := String streamContents: [ :s | sourceModel exportToMSEStream: s ].

	importedModel := FamixJavaModel new
		importFrom: (FamixJavaModel
			importFrom: mseString readStream
			withMetamodel: FamixJavaModel metamodel
			customizingImporterWith: [ :importer | FMImporterAggregationDecorator on: importer ])
		named: 'testModel'
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> mooseEntity: aFamixClass named: aString [

	^ aFamixClass new
		mooseModel: sourceModel ;
		name: aString ;
		yourself
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> setUp [

	super setUp.

	sourceModel := FamixJavaModel new.
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> testAggregatedMethodsAreCreatedWhenImportingClass [

	| expectedAggregatedmethod |
	self mooseEntity: FamixJavaClass named: 'ClassA'.
	self importModel.

	self assert: importedModel allMethods size equals: 1.
	
	expectedAggregatedmethod := importedModel allMethods anyOne.
	self assert: expectedAggregatedmethod name equals: '__aggregatedMethod__'.
	self assert: expectedAggregatedmethod parentType name equals: 'ClassA'.
]

{ #category : #tests }
FMImporterAggregationDecoratorTest >> testClassesAreImported [
	
	self mooseEntity: FamixJavaClass named: 'ClassA'.

	self importModel.
	
	self assert: sourceModel allModelClasses size equals: 1
]
