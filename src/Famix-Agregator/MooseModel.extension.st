Extension { #name : #MooseModel }

{ #category : #'*Famix-Agregator' }
MooseModel >> importAgregatedFromJSONStream: aStream [

	^ self
		  importFrom: (self class
				   importFromJSON: aStream
				   withMetamodel: self metamodel
				   customizingImporterWith: [ :importer |
				   FMImporterAggregationDecorator on: importer ])
		  named: (aStream localName removeSuffix: '.json')
]

{ #category : #'*Famix-Agregator' }
MooseModel >> importAgregatedFromMSEStream: aStream [

	^ self
		  importFrom: (self class
				   importFrom: aStream
				   withMetamodel: self metamodel
				   customizingImporterWith: [ :importer |
				   FMImporterAggregationDecorator on: importer ])
		  named: (aStream localName removeSuffix: '.mse')
]
