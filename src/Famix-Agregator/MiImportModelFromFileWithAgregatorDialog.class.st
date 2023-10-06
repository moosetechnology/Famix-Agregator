Class {
	#name : #MiImportModelFromFileWithAgregatorDialog,
	#superclass : #MiImportModelFromFileDialog,
	#instVars : [
		'agregateButton',
		'agregateMethods'
	],
	#category : #'Famix-Agregator-UI'
}

{ #category : #agregation }
MiImportModelFromFileWithAgregatorDialog >> agregateMethods [

	agregateMethods := true
]

{ #category : #agregation }
MiImportModelFromFileWithAgregatorDialog >> doNotAgregateMethods [

	agregateMethods := false
]

{ #category : #initialization }
MiImportModelFromFileWithAgregatorDialog >> initialize [

	super initialize.
	self doNotAgregateMethods
]

{ #category : #initialization }
MiImportModelFromFileWithAgregatorDialog >> initializeEntitiesSelectionWidgets [

	super initializeEntitiesSelectionWidgets.

	agregateButton := self newRadioButton
		                  label: 'Agregate Methods';
		                  whenActivatedDo: [ self agregateMethods ];
		                  whenDeactivatedDo: [ self doNotAgregateMethods ];
		                  yourself.
	allEntitiesButton associatedRadioButtons: {
			agregateButton.
			customEntitiesButton }
]

{ #category : #action }
MiImportModelFromFileWithAgregatorDialog >> privateImportModel [

	| model importer |
	model := mooseModelDroplist selectedItem new.

	importer := self importerForFile new
		            model: model;
		            inputFile: modelFile.

	agregateMethods
		ifTrue: [ [importer runAgregated] timeProfile ]
		ifFalse: [ importer runFilteredBy: importingContext ].

	model name: (modelNameInput text ifEmpty: [ 'MooseModel' ]).

	^ model
]

{ #category : #initialization }
MiImportModelFromFileWithAgregatorDialog >> simpleLayout [

	| spacing size labelWidth |
	spacing := 10.
	size := 25.
	labelWidth := 120.
	^ SpBoxLayout newTopToBottom
		  spacing: spacing;
		  add: (SpBoxLayout newLeftToRight
				   spacing: spacing;
				   add: 'Model type:' width: labelWidth;
				   add: mooseModelDroplist;
				   yourself)
		  height: size;
		  add: (SpBoxLayout newLeftToRight
				   spacing: spacing;
				   add: 'File path:' width: labelWidth;
				   add: filePathInput;
				   add: filePathButton width: size;
				   yourself)
		  height: size;
		  add: (SpBoxLayout newLeftToRight
				   spacing: spacing;
				   add: 'Model name:' width: labelWidth;
				   add: modelNameInput;
				   add: self newNullPresenter width: size;
				   yourself)
		  height: size;
		  add: (SpBoxLayout newLeftToRight
				   spacing: spacing;
				   add: 'Root folder (optional):' width: labelWidth;
				   add: rootFolderInput;
				   add: rootFolderButton width: size;
				   yourself)
		  height: size;
		  add: (SpBoxLayout newLeftToRight
				   spacing: spacing;
				   add: 'Entity types:' width: labelWidth;
				   add: allEntitiesButton;
				   add: agregateButton;
				   add: customEntitiesButton;
				   yourself)
		  height: size;
		  yourself
]
