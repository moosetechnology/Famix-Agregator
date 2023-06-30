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
FMImporterAggregationDecoratorTest class >> modelAccess [

	| mseString |
	mseString := '(					
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
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelClassInvocMethod [

	| mseString |
	mseString := '(			
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodB'')
   			 	(parentType (ref: 2)))			
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB''))		
			(Famix-Java-Entities.Invocation (id: 5)
    			(candidates (ref: 4))
    			(sender (ref: 3))
    			(signature ''methodB'')))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelClassMethodInvoc [

	| mseString |
	mseString := '(					
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB''))
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodB'')
   			 	(parentType (ref: 2)))
			(Famix-Java-Entities.Invocation (id: 5)
    			(candidates (ref: 4))
    			(sender (ref: 3))
    			(signature ''methodB'')))'.
	^ mseString
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
FMImporterAggregationDecoratorTest class >> modelClassRefMethod [

	| mseString |
	mseString := '(
        (Famix-Java-Entities.Class (id: 4)
            (name ''ClassA''))
        (Famix-Java-Entities.Class (id: 3)
            (name ''ClassB''))	  
        (Famix-Java-Entities.Reference (id: 1)
            (referencer (ref: 2))
            (referredType (ref: 3)))
        (Famix-Java-Entities.Method (id: 2)
            (name ''methodA'')
            (parentType (ref: 4))))'.
	^ mseString
]

{ #category : #'test data' }
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

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelInvocClassMethod [

	| mseString |
	mseString := '(									
			(Famix-Java-Entities.Invocation (id: 5)
    			(candidates (ref: 4))
    			(sender (ref: 3))
    			(signature ''methodB''))			
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB''))		
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodB'')
   			 	(parentType (ref: 2))))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelInvocMethodClass [

	| mseString |
	mseString := '(									
			(Famix-Java-Entities.Invocation (id: 5)
    			(candidates (ref: 4))
    			(sender (ref: 3))
    			(signature ''methodB''))			
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodB'')
   			 	(parentType (ref: 2)))
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB'')))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelInvocationInSameClass [

	| mseString |
	mseString := '(					
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Method (id: 2)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodB'')
   			 	(parentType (ref: 1)))
			(Famix-Java-Entities.Invocation (id: 4)
    			(candidates (ref: 3))
    			(sender (ref: 2))
    			(signature ''methodB'')))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelMethodClassInvoc [

	| mseString |
	mseString := '(			
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodB'')
   			 	(parentType (ref: 2)))			
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB''))		
			(Famix-Java-Entities.Invocation (id: 5)
    			(candidates (ref: 4))
    			(sender (ref: 3))
    			(signature ''methodB'')))'.
	^ mseString
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

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelMethodInvocClass [

	| mseString |
	mseString := '(			
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodB'')
   			 	(parentType (ref: 2)))					
			(Famix-Java-Entities.Invocation (id: 5)
    			(candidates (ref: 4))
    			(sender (ref: 3))
    			(signature ''methodB''))		
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB'')))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelMethodRefClass [

	| mseString |
	mseString := '(
			(Famix-Java-Entities.Method (id: 2)
            (name ''methodA'')
            (parentType (ref: 4)))		
        	(Famix-Java-Entities.Reference (id: 1)
            (referencer (ref: 2))
            (referredType (ref: 3)))
        	(Famix-Java-Entities.Class (id: 4)
            (name ''ClassA''))
        	(Famix-Java-Entities.Class (id: 3)
            (name ''ClassB'')))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelMultipleInvocationsToSameMethods [

	| mseString |
	mseString := '(					
        	(Famix-Java-Entities.Class (id: 1)
    			(name ''ClassA''))
			(Famix-Java-Entities.Class (id: 2)
    			(name ''ClassB''))
			(Famix-Java-Entities.Method (id: 3)
    			(name ''methodA1'')
    			(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 4)
    			(name ''methodA2'')
   			 	(parentType (ref: 1)))
			(Famix-Java-Entities.Method (id: 5)
    			(name ''methodB1'')
   			 	(parentType (ref: 2)))
			(Famix-Java-Entities.Invocation (id: 6)
    			(candidates (ref: 5))
    			(sender (ref: 3))
    			(signature ''methodB1''))
			(Famix-Java-Entities.Invocation (id: 7)
    			(candidates (ref: 5))
    			(sender (ref: 4))
    			(signature ''methodB1'')))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelRefClassMethod [

	| mseString |
	mseString := '(					
        	(Famix-Java-Entities.Reference (id: 1)
            (referencer (ref: 2))
            (referredType (ref: 3)))			
        	(Famix-Java-Entities.Class (id: 4)
            (name ''ClassA''))
        	(Famix-Java-Entities.Class (id: 3)
            (name ''ClassB''))
			(Famix-Java-Entities.Method (id: 2)
            (name ''methodA'')
            (parentType (ref: 4))))'.
	^ mseString
]

{ #category : #'test data' }
FMImporterAggregationDecoratorTest class >> modelRefMethodClass [

	| mseString |
	mseString := '(					
        	(Famix-Java-Entities.Reference (id: 1)
            (referencer (ref: 2))
            (referredType (ref: 3)))
			(Famix-Java-Entities.Method (id: 2)
            (name ''methodA'')
            (parentType (ref: 4)))
        	(Famix-Java-Entities.Class (id: 4)
            (name ''ClassA''))
        	(Famix-Java-Entities.Class (id: 3)
            (name ''ClassB'')))'.
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

{ #category : #running }
FMImporterAggregationDecoratorTest >> expectedAggregatedMethodName [

	^ "'__aggregatedMethod__ClassA'" '__aggregatedMethod__'
]

{ #category : #running }
FMImporterAggregationDecoratorTest >> expectedAttributeName [

	^ 'attributeA'
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
		                 importFrom: (FamixStModel
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

{ #category : #running }
FMImporterAggregationDecoratorTest >> testAccess [

	self importModel: self class modelAccess.

	self assert: importedModel allModelClasses size equals: 1.
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
		equals: 'attributeA'
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

{ #category : #running }
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

{ #category : #running }
FMImporterAggregationDecoratorTest >> testInvocationInSameClassDoesNotCreateDependance [

	self importModel: self class modelInvocationInSameClass.

	self assert: importedModel allModelClasses size equals: 1.
	self assert: importedModel allModelMethods size equals: 0.
	self assert: importedModel allInvocations size equals: 0
]

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
FMImporterAggregationDecoratorTest >> testLocalModel [
	"importedModel := '/home/users/etudiant/projet_totoum_patricia_coo/output.mse'
		                 asFileReference readStreamDo: [ :st |
		                 FamixJavaModel new
			                 importFrom: (FamixJavaModel
					                  importFrom: st
					                  withMetamodel: FamixJavaModel metamodel
					                  customizingImporterWith: [ :importer |
					                  FMImporterAggregationDecorator on: importer ])
			                 named: 'testModel' ]"
]

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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

{ #category : #running }
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
