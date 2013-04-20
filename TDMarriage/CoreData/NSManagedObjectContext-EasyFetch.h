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

#import <CoreData/CoreData.h>
@interface NSManagedObjectContext (EasyFetch)
#pragma mark -
#pragma mark Fetch all unsorted

/** @brief Convenience method to fetch all objects for a given Entity name in
 * this context.
 *
 * The objects are returned in the order specified by Core Data.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName;

#pragma mark -
#pragma mark Fetch all sorted

/** @brief Convenience method to fetch all objects for a given Entity name in
 * the context.
 *
 * The objects are returned in the order specified by the provided key and
 * order.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortByKey:(NSString*)key
                            ascending:(BOOL)ascending;

/** @brief Convenience method to fetch all objects for a given Entity name in
 * the context.
 *
 * If the sort descriptors array is not nil, the objects are returned in the
 * order specified by the sort descriptors. Otherwise, the objects are returned
 * in the order specified by Core Data.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                             sortWith:(NSArray*)sortDescriptors;

#pragma mark -
#pragma mark Fetch filtered unsorted

/** @brief Convenience method to fetch selected objects for a given Entity name
 * in the context.
 *
 * If the predicate is not nil, the selection is filtered by the provided
 * predicate.
 *
 * The objects are returned in the order specified by Core Data.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                        withPredicate:(NSPredicate*)predicate;

/** @brief Convenience method to fetch selected objects for a given Entity name
 * in the context.
 *
 * The selection is filtered by the provided formatted predicate string and
 * arguments.
 *
 * The objects are returned in the order specified by Core Data.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                  predicateWithFormat:(NSString*)predicateFormat, ...;

#pragma mark -
#pragma mark Fetch filtered sorted

/** @brief Convenience method to fetch selected objects for a given Entity name
 * in the context.
 *
 * If the predicate is not nil, the selection is filtered by the provided
 * predicate.
 *
 * The objects are returned in the order specified by the provided key and
 * order.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortByKey:(NSString*)key
                            ascending:(BOOL)ascending
                        withPredicate:(NSPredicate*)predicate;

/** @brief Convenience method to fetch selected objects for a given Entity name
 * in the context.
 *
 * If the predicate is not nil, the selection is filtered by the provided
 * predicate.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortWith:(NSArray*)sortDescriptors
                        withPredicate:(NSPredicate*)predicate;

/** @brief Convenience method to fetch selected objects for a given Entity name
 * in the context.
 *
 * The selection is filtered by the provided formatted predicate string and
 * arguments.
 *
 * The objects are returned in the order specified by the provided key and
 * order.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                            sortByKey:(NSString*)key
                            ascending:(BOOL)ascending
                  predicateWithFormat:(NSString*)predicateFormat, ...;

/** @brief Convenience method to fetch selected objects for a given Entity name
 * in the context.
 *
 * The selection is filtered by the provided formatted predicate string and
 * arguments.
 *
 * If the sort descriptors array is not nil, the objects are returned in the
 * order specified by the sort descriptors. Otherwise, the objects are returned
 * in the order specified by Core Data.
 */
- (NSArray*)fetchObjectsForEntityName:(NSString*)entityName
                             sortWith:(NSArray*)sortDescriptors
                  predicateWithFormat:(NSString*)predicateFormat, ...;
@end
