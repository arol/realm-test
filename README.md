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

Lluís:
You can either use obejctsWithPredicate:(NSPredicate) or objectsWhere:(NSString) with the format string instead of creating an NSPredicate instance with predicateWithFormat:(NSString).
Sorting is easy as well with arraySortedByProperty:ascencing:.

I don't like though that this queries return an RLMArray, coupling the model framework with our view controllers (if we create the queries in them like we do with NSFRC).

### DB Browser

Lluís:
In order to see content changes, you have to reopen the database file.


### JSON Mapping

Lluís:
Methods initWithObject: and createInRealm:withObject: allow to instantiate an RLMObject with the values of an NSDictionary if its keys match the object's property names.

### Testing

*stubs, expectations…*

### Cascade behaviour

Lluís: 
I haven't found anything related to delete rules like cascade, nullify, etc., but I've asked a Realm developer about it in a Reddit thread. 

### Optional Fields

### Reverse relationships

Lluís:
It's not compulsory to define the reverse of each relationship like in core data, but when necessary you have to do explicitely link both relationships (unlike core data) as stated ![in this answer](http://stackoverflow.com/a/24962700).

### Fullfill issues

## New features in Realm

### Migrations

### Transactions

### Merging Realms

### Non-persisting objects
