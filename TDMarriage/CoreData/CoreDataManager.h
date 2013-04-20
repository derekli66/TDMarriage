

#import <CoreData/CoreData.h>
#import "CoreDataConstants.h"
#import "TDGuest.h"


@interface CoreDataManager : NSObject  
{
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

+ (id)sharedManager;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

#pragma mark - Custom Methods

-(id)createNewObjectWithClass:(Class)aClass;

-(NSArray *)getAllGuests;

-(NSArray *)getGuestListByName:(NSString *)aName;

-(NSArray *)getAllAbsence;

-(NSArray *)getAllArrived;

-(void)cleanUpAllManagedObjects;
@end
