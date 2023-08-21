Extension { #name : #MiJSONFileImporter }

{ #category : #'*Famix-Agregator' }
MiJSONFileImporter >> runAgregated [

	[ model importAgregatedFromJSONStream: inputStream ] ensure: [
		inputStream close ]
]
