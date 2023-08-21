Extension { #name : #MiMSEFileImporter }

{ #category : #'*Famix-Agregator' }
MiMSEFileImporter >> runAgregated [

	[ model importAgregatedFromMSEStream: inputStream ] ensure: [
		inputStream close ]
]
