/** Core Data Easy Fetch Category
 *
 * This is an Objective-C category for Core Data (`NSManagedObjectContext
 * (EasyFetch)`) that offers a few useful functions added that simplify [Core
 * Data][1] programming for Mac OS X and iPhone OS. It's based loosely on
 * [code][2] by Matt Gallagher, but with several enhancements and modifications
 * that I needed for a project I was writing that used Core Data.
 *
 * 1: http://developer.apple.com/mac/library/DOCUMENTATION/Cocoa/Conceptual/CoreData/index.html
 * 2: http://cocoawithlove.com/2008/03/core-data-one-line-fetch.html
 */

#import "NSManagedObjectContext-EasyFetch.h"

@implementation NSManagedObjectContext (EasyFetch)

#pragma mark -
#pragma mark Fetch all unsorted

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
{
  return [self fetchObjectsForEntityName:entityName sortWith:nil
                           withPredicate:nil];
}

#pragma mark -
#pragma mark Fetch all sorted

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortByKey:(NSString*)key
                            ascending:(BOOL)ascending
{
  return [self fetchObjectsForEntityName:entityName sortByKey:key
                               ascending:ascending withPredicate:nil];
}

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                             sortWith:(NSArray*)sortDescriptors
{
  return [self fetchObjectsForEntityName:entityName sortWith:sortDescriptors
                           withPredicate:nil];
}

#pragma mark -
#pragma mark Fetch filtered unsorted

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                        withPredicate:(NSPredicate*)predicate
{
  return [self fetchObjectsForEntityName:entityName sortWith:nil
                           withPredicate:predicate];
}

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                  predicateWithFormat:(NSString*)predicateFormat, ...
{
  va_list variadicArguments;
  va_start(variadicArguments, predicateFormat);
  NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
                                                  arguments:variadicArguments];
  va_end(variadicArguments);

  return [self fetchObjectsForEntityName:entityName sortWith:nil
                           withPredicate:predicate];
}

#pragma mark -
#pragma mark Fetch filtered sorted

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortByKey:(NSString*)key
                            ascending:(BOOL)ascending
                        withPredicate:(NSPredicate*)predicate
{
  NSSortDescriptor* sort = [[NSSortDescriptor alloc] initWithKey:key
                                                        ascending:ascending];

  return [self fetchObjectsForEntityName:entityName sortWith:[NSArray
                         arrayWithObject:sort] withPredicate:predicate];
}

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                             sortWith:(NSArray*)sortDescriptors
                        withPredicate:(NSPredicate*)predicate
{
  NSEntityDescription* entity = [NSEntityDescription entityForName:entityName
                                            inManagedObjectContext:self];
  NSFetchRequest* request = [[NSFetchRequest alloc] init];
  [request setEntity:entity];

  if (predicate)
  {
    [request setPredicate:predicate];
  }

  if (sortDescriptors)
  {
    [request setSortDescriptors:sortDescriptors];
  }

  NSError* error = nil;
  NSArray* results = [self executeFetchRequest:request error:&error];

  if (error != nil)
  {
//	  NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	  [NSException raise:NSGenericException format:@"",[error description]];
  }

  return results;
}

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortByKey:(NSString*)key
                            ascending:(BOOL)ascending
                  predicateWithFormat:(NSString*)predicateFormat, ...
{
  va_list variadicArguments;
  va_start(variadicArguments, predicateFormat);
  NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
                                                  arguments:variadicArguments];
  va_end(variadicArguments);

  return [self fetchObjectsForEntityName:entityName sortByKey:key
                               ascending:ascending withPredicate:predicate];
}

- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                             sortWith:(NSArray*)sortDescriptors
                  predicateWithFormat:(NSString*)predicateFormat, ...
{
  va_list variadicArguments;
  va_start(variadicArguments, predicateFormat);
  NSPredicate* predicate = [NSPredicate predicateWithFormat:predicateFormat
                                                  arguments:variadicArguments];
  va_end(variadicArguments);

  return [self fetchObjectsForEntityName:entityName sortWith:sortDescriptors
                           withPredicate:predicate];
}
@end
