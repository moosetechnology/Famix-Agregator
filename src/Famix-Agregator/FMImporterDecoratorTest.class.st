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

	model allModelMethods do: [ :method |
		self assert: (model allModelClasses includes: method parentType) ].

	model allModelClasses do: [ :class |
		self assert: class methods size equals: 1.
		self
			assert: class methods anyOne name
			equals:
			(String streamContents: [ :s |
				 s << 'aggregatedMethod' << class name ]) ]
]

{ #category : #tests }
FMImporterDecoratorTest >> testClassesAreImported [

	self assert: model allModelClasses size equals: 2
]
