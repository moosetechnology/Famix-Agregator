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
	self modelCreation inspect
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelClassMethodRef [

	| mseString |
	mseString := '(
        (Famix-Java-Entities.Class (id: 4)
            (name ''ClassA''))
        (Famix-Java-Entities.Class (id: 3)
            (name ''ClassB''))
        (Famix-Java-Entities.Method (id: 2)
            (name ''methodA'')
            (parentType (ref: 4)))
        (Famix-Java-Entities.Reference (id: 1)
            (referencer (ref: 2))
            (referredType (ref: 3))))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelCreation [
	| model classA mA classB refmethodAtoclassB |
	model := FamixJavaModel new.
	classA := FamixJavaClass named: 'ClassA'.
	mA := FamixJavaMethod named: 'methodA'.
	mA parentType: classA.

	classB := FamixJavaClass named: 'ClassB'.

	refmethodAtoclassB := FamixJavaReference source: mA target: classB.

	model addAll: {
			mA.
			classA.
			classB.
			refmethodAtoclassB }.
	^ model
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelMethodClassRef [

	| mseString |
	mseString := '(
			(Famix-Java-Entities.Method (id: 2)
            (name ''methodA'')
            (parentType (ref: 4)))
        	(Famix-Java-Entities.Class (id: 4)
            (name ''ClassA''))
        	(Famix-Java-Entities.Class (id: 3)
            (name ''ClassB''))
        	(Famix-Java-Entities.Reference (id: 1)
            (referencer (ref: 2))
            (referredType (ref: 3))))'.
	^ mseString
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

{ #category : #'test data' }
FMImporterAggregationDecoratorTest >> importModel: aModelString [

	importedModel := FamixJavaModel new
		                 importFrom: (FamixJavaModel
				                  importFrom: (ReadStream on: aModelString)
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
FMImporterAggregationDecoratorTest >> testReferenceClassMethodRef [

	self importModel: self class modelClassMethodRef.

	self assert: importedModel allModelClasses size equals: 2.
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
FMImporterAggregationDecoratorTest >> testReferenceMethodClassRef [

	self importModel: self class modelMethodClassRef.

	self assert: importedModel allModelClasses size equals: 2.
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
