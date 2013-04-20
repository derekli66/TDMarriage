

#import "CoreDataManager.h"
#import "NSManagedObjectContext-EasyFetch.h"

@interface CoreDataManager()
//private methods:
- (void)saveCoreData;
@end

@implementation CoreDataManager
@synthesize managedObjectContext;
-(void) dealloc
{
}

- (void)saveCoreData
{
	NSError *error;
	if (![[self managedObjectContext] save:&error]) {
		NSLog(@"CoreData - Unable To Save: %@", [error description]);
	}
}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext 
{
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
	if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel 
{
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent:PersistentCoreDataSQLiteFileName]];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"CoreData : Unresolved error %@, %@", error, [error userInfo]);
    }    
    
    return persistentStoreCoordinator;
}
#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark Singleton Methods
+ (id)sharedManager
{
	static CoreDataManager *sharedCoreDataManager = nil;
	if (!sharedCoreDataManager) {
		sharedCoreDataManager = [[CoreDataManager alloc] init];
		//inits variables
		[sharedCoreDataManager persistentStoreCoordinator];
		[sharedCoreDataManager managedObjectModel];
		[sharedCoreDataManager managedObjectContext];
	}
	
	return sharedCoreDataManager;
}
	

#pragma mark - Custom Methods
-(id)createNewObjectWithClass:(Class)aClass
{
    id newObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(aClass) inManagedObjectContext:self.managedObjectContext];
    return newObject;
}

-(NSArray *)getAllGuests
{
    NSSortDescriptor *sorter01 = [NSSortDescriptor sortDescriptorWithKey:@"tableID" ascending:YES];
    NSSortDescriptor *sorter02 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSArray *array = [self.managedObjectContext fetchObjectsForEntityName:@"TDGuest"
                                                                 sortWith:@[sorter01, sorter02]
                                                      predicateWithFormat:@"(name != %@)", @""];
    
    if ([array count] == 0) {
        return nil;
    }
    
    return array;
}

-(NSArray *)getGuestListByName:(NSString *)aName
{
    NSArray *array = [self.managedObjectContext fetchObjectsForEntityName:@"TDGuest"
                                                                sortByKey:@"name"
                                                                ascending:YES
                                                      predicateWithFormat:@"(name CONTAINS %@)", aName];
    return array;
}

-(NSArray *)getAllAbsence
{
    
    NSSortDescriptor *sorter01 = [NSSortDescriptor sortDescriptorWithKey:@"tableID" ascending:YES];
    NSSortDescriptor *sorter02 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSArray *array = [self.managedObjectContext fetchObjectsForEntityName:@"TDGuest"
                                                                 sortWith:@[sorter01, sorter02]
                                                      predicateWithFormat:@"(checkBox != %@)", [NSNumber numberWithInteger:2]];
    
//    NSArray *array = [self.managedObjectContext fetchObjectsForEntityName:@"TDGuest"
//                                                                sortByKey:@"name"
//                                                                ascending:YES
//                                                      predicateWithFormat:@"(checkBox != %@)", [NSNumber numberWithInteger:2]];
    
    NSLog(@"array : %@", array);
    
    return array;
}

-(NSArray *)getAllArrived
{
    NSSortDescriptor *sorter01 = [NSSortDescriptor sortDescriptorWithKey:@"tableID" ascending:YES];
    NSSortDescriptor *sorter02 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSArray *array = [self.managedObjectContext fetchObjectsForEntityName:@"TDGuest"
                                                                 sortWith:@[sorter01, sorter02]
                                                      predicateWithFormat:@"(checkBox == %@)", [NSNumber numberWithInteger:2]];
    
    
//    NSArray *array = [self.managedObjectContext fetchObjectsForEntityName:@"TDGuest"
//                                                                sortByKey:@"name"
//                                                                ascending:YES
//                                                      predicateWithFormat:@"(checkBox == %@)", [NSNumber numberWithInteger:2]];
    return array;
}


-(void)cleanUpAllManagedObjects
{

}
@end
