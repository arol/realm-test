Realm Test
==========

## Features used in CoreData

### Batch importing

*Please, take in account the speed (benchmarking to CoreData) and threading issues.*

### NSFetchedResultsController

*Simulate its behaviour with realm*

Lluís: 
Right now it's not possible to completely simulate the NSFRC behaviour because, as they say in their "Current Limitations" section, they only support "realm changed" notifications and therefore we can only update the whole table view whenever this notification is fired. They say though that in the NEAR FUTURE they will add fine-grained (core-data-like) notifications allowing to discern between added/removed/moved/updated model objects.

### Quering

*NSPredicate, Sorting criterias, sections*

### DB Browser

### JSON Mapping

### Testing

*stubs, expectations…*

### Cascade behaviour

Lluís: 
No he trobat res al respecte, però ho estic preguntant per reddit a veure si ho pensen afegir o què.

### Optional Fields

### Reverse relationships

### Fullfill issues

## New features in Realm

### Migrations

### Transactions

### Merging Realms

### Non-persisting objects
