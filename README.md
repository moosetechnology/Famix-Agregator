# Famix-Agregator
Famix Agregator is a decorator for the model importer.

To load this project in a Moose image, execute the following: 
```Smalltalk
Metacello new
  baseline: 'FamixAgregator';
  repository: 'github://moosetechnology/Famix-Agregator:main/src';
  load
  ```
  # Exporting the aggregated meta-model
  To export the meta-model and save it to a local file, execute the following:
  ```Smalltalk
  '/path/to/file.mse' asFileReference writeStreamDo: [ :writeStream | (MooseModel root at: aPosition) metamodel exportOn: writeStream ]
```
