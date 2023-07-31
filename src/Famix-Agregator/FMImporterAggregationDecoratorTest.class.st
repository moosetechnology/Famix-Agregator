Class {
	#name : #FMImporterAggregationDecoratorTest,
	#superclass : #TestCase,
	#instVars : [
		'sourceModel',
		'importedModel'
	],
	#category : #'Famix-Agregator-Tests'
}

{ #category : #inspecting }
FMImporterAggregationDecoratorTest class >> inspectModelClassMethodRef [

	<script>
	self modelCreation inspect
]

{ #category : #inspecting }
FMImporterAggregationDecoratorTest class >> modelCreation [

	| model classA classB methodA1 methodA2 methodB1 invocA1toB1 invocA2toB1 |
	model := FamixJavaModel new.

	classA := FamixJavaClass named: 'ClassA'.
	methodA1 := FamixJavaMethod named: 'methodA1'.
	methodA1 parentType: classA.
	methodA2 := FamixJavaMethod named: 'methodA2'.
	methodA2 parentType: classA.

	classB := FamixJavaClass named: 'ClassB'.
	methodB1 := FamixJavaMethod named: 'methodB1'.
	methodB1 parentType: classB.

	invocA1toB1 := FamixJavaInvocation new.
	invocA1toB1 sender: methodA1.
	invocA1toB1 addCandidate: methodB1.
	invocA1toB1 signature: 'methodB1'.

	invocA2toB1 := FamixJavaInvocation new.
	invocA2toB1 sender: methodA2.
	invocA2toB1 addCandidate: methodB1.
	invocA2toB1 signature: 'methodB1'.

	model addAll: {
			classA.
			classB.
			methodA1.
			methodA2.
			methodB1.
			invocA1toB1.
			invocA2toB1 }.

	^ model
]

{ #category : #setting }
FMImporterAggregationDecoratorTest >> expectedAggregatedMethodName [

	^ '__aggregatedMethod__'
]

{ #category : #setting }
FMImporterAggregationDecoratorTest >> expectedAttributeName [

	^ 'attributeB'
]

{ #category : #setting }
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

{ #category : #setting }
FMImporterAggregationDecoratorTest >> importModel: aModelString [

	importedModel := FamixJavaModel new
		                 importFrom: (FamixStModel
				                  importFrom: (ReadStream on: aModelString)
				                  withMetamodel: FamixJavaModel metamodel
				                  customizingImporterWith: [ :importer |
				                  FMImporterAggregationDecorator on: importer ])
		                 named: 'testModel'
]

{ #category : #setting }
FMImporterAggregationDecoratorTest >> mooseEntity: aFamixEntity named: aString [

	^ aFamixEntity named: aString model: sourceModel
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> setUp [

	super setUp.

	sourceModel := FamixJavaModel new.
	importedModel := nil.
	
]

{ #category : #'test access' }
FMImporterAggregationDecoratorTest >> testAccessInSameClassDoesNotCreateDependanceAndMethod [

	self importModel: '(	
        	(Famix-Java-Entities.Class (id: 1)
        		(name ''ClassA''))
    		(Famix-Java-Entities.Method (id: 2)
        		(name ''methodA'')
        		(parentType (ref: 1)))
    		(Famix-Java-Entities.Attribute (id: 3)
        		(name ''attributeA'')
        		(parentType (ref: 1)))
    		(Famix-Java-Entities.Access (id: 4)
        		(accessor (ref: 2))
        		(variable (ref: 3))))'.

	self assert: importedModel allModelClasses size equals: 1.
	self assert: importedModel allModelMethods size equals: 0.
	self assert: importedModel allAccesses size equals: 0
]

{ #category : #'test access' }
FMImporterAggregationDecoratorTest >> testAccessToExternalClassAttribute [

	self importModel: '(					
        	(Famix-Java-Entities.Class (id: 1)
        		(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
        		(name ''ClassB''))
    		(Famix-Java-Entities.Method (id: 3)
        		(name ''methodA'')
        		(parentType (ref: 1)))
    		(Famix-Java-Entities.Attribute (id: 4)
        		(name ''attributeB'')
        		(parentType (ref: 2)))
    		(Famix-Java-Entities.Access (id: 5)
        		(accessor (ref: 3))
        		(variable (ref: 4))))'.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allAccesses size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allAccesses anyOne accessor name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allAccesses anyOne variable name
		equals: self expectedAttributeName
]

{ #category : #'test class' }
FMImporterAggregationDecoratorTest >> testAggregatedMethodNotCreatedWhenNoAssociation [
	
	self classA addMethod: self methodA.
	self importModel.

	self assert: importedModel allModelMethods size equals: 0.
	self assert: importedModel allModelClasses size equals: 1
]

{ #category : #'test class' }
FMImporterAggregationDecoratorTest >> testClassesAreImported [

	self classA.
	self importModel.

	self assert: importedModel allModelClasses size equals: 1.
	self
		assert: importedModel allModelClasses anyOne name
		equals: 'ClassA'
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationClassInvocMethod [

	self importModel: self class modelClassInvocMethod.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.
	self assert: importedModel allInvocations size equals: 1.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationClassMethodInvoc [

	self importModel: self class modelClassMethodInvoc.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.
	self assert: importedModel allInvocations size equals: 1.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationInSameClassDoesNotCreateDependance [

	self importModel: self class modelInvocationInSameClass.

	self assert: importedModel allModelClasses size equals: 1.
	self assert: importedModel allModelMethods size equals: 0.
	self assert: importedModel allInvocations size equals: 0
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationInvocClassMethod [

	self importModel: self class modelInvocClassMethod.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.
	self assert: importedModel allInvocations size equals: 1.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationInvocMethodClass [

	self importModel: self class modelInvocMethodClass.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.
	self assert: importedModel allInvocations size equals: 1.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationMethodClassInvoc [

	self importModel: self class modelMethodClassInvoc.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.
	self assert: importedModel allInvocations size equals: 1.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testInvocationMethodInvocClass [

	self importModel: self class modelMethodInvocClass.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.
	self assert: importedModel allInvocations size equals: 1.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test invocation' }
FMImporterAggregationDecoratorTest >> testMultipleInvocationsToSameMethod [

	self importModel: self class modelMultipleInvocationsToSameMethods.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allInvocations size equals: 2.
	self assert: importedModel allModelMethods size equals: 2.

	self assert: (importedModel allModelMethods allSatisfy: [ :method |
			 method name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation sender name = self expectedAggregatedMethodName ]).

	self assert:
		(importedModel allInvocations allSatisfy: [ :invocation |
			 invocation candidates anySatisfy: [ :candidate |
				 candidate name = self expectedAggregatedMethodName ] ])
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceClassMethodRef [

	self importModel: self class modelClassMethodRef.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceClassRefMethod [

	self importModel: self class modelClassRefMethod.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceFromMethodToItsParentTypeDoesNotCreateDependanceAndMethod [

	self importModel: self class modelRefFromMethodToItsParentType.

	self assert: importedModel allModelClasses size equals: 1.
	self assert: importedModel allModelMethods size equals: 0.
	self assert: importedModel allReferences size equals: 0.
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceMethodClassRef [

	self importModel: self class modelMethodClassRef.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceMethodRefClass [

	self importModel: self class modelMethodRefClass.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceRefClassMethod [

	self importModel: self class modelRefClassMethod.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]

{ #category : #'test reference' }
FMImporterAggregationDecoratorTest >> testReferenceRefMethodClass [

	self importModel: self class modelRefMethodClass.

	self assert: importedModel allModelClasses size equals: 2.
	self assert: importedModel allModelMethods size equals: 1.
	self assert: importedModel allReferences size equals: 1.

	self
		assert: importedModel allModelMethods anyOne name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allModelMethods anyOne parentType name
		equals: 'ClassA'.

	self
		assert: importedModel allReferences anyOne referencer name
		equals: self expectedAggregatedMethodName.
	self
		assert: importedModel allReferences anyOne referredType name
		equals: 'ClassB'
]
