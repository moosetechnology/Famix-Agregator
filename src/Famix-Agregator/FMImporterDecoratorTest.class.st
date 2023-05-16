Class {
	#name : #FMImporterDecoratorTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#classInstVars : [
		'mseString'
	],
	#category : #'Famix-Agregator-Tests'
}

{ #category : #'test data' }
FMImporterDecoratorTest class >> inspectMseString [

	<script>
	self mseString inspect
]

{ #category : #'test data' }
FMImporterDecoratorTest class >> mseString [

	^ mseString ifNil: [ 
		  mseString := String streamContents: [ :s | 
			               self sourceModel exportToMSEStream: s ] ]
]

{ #category : #'test data' }
FMImporterDecoratorTest class >> sourceModel [

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

{ #category : #running }
FMImporterDecoratorTest >> setUp [

	super setUp.
	model := FamixJavaModel new
		         importFrom: (FamixJavaModel
				          importFrom: self class mseString readStream
				          withMetamodel: FamixJavaModel metamodel
				          customizingImporterWith: [ :importer | 
				          FMImporterDecorator on: importer ])
		         named: 'testModel'
]

{ #category : #tests }
FMImporterDecoratorTest >> testAggregatedMethodsAreCreated [

	| classA classB aggregatedMethodA aggregatedMethodB |
	classA := model allModelClasses
		          detect: [ :class | class name = 'ClassA' ]
		          ifNone: [ self assert: false ].
	classB := model allModelClasses
		          detect: [ :class | class name = 'ClassB' ]
		          ifNone: [ self assert: false ].

	"retrieves all methods from the imported model, and finds the aggregated methods and the 	parent-types corresponding to them."
	aggregatedMethodA := model allModelMethods detect: [ :method |
		                     method name = 'aggregatedMethodA' and: [
			                     method parent = classA ] ].

	aggregatedMethodB := model allModelMethods detect: [ :method |
		                     method name = 'aggregatedMethodB' and: [
			                     method parent = classB ] ].

	"checks that the aggregated methods have been created successfully."
	self assert: aggregatedMethodA notNil.
	self assert: aggregatedMethodB notNil
]

{ #category : #tests }
FMImporterDecoratorTest >> testClassesAreImported [

	self assert: model allModelClasses size equals: 2
]

{ #category : #tests }
FMImporterDecoratorTest >> testMethodsAreNotImported [

	self assert: model allModelMethods size equals: 2.
	self assert:
		(model allModelMethods allSatisfy: [ :m | 
			 m name = 'agregatedMethod' ])
]
