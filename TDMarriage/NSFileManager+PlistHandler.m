//
//  NSFileManager+PlistHandler.m
//

#import "NSFileManager+PlistHandler.h"

@implementation NSFileManager (PlistHandler)
-(NSDictionary *)readPlistFromBundleWithFile:(NSString*)fileName{
    NSString *string = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSData *plistData = [[NSFileManager defaultManager] contentsAtPath:string];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    NSDictionary *startUpDict = (NSDictionary *)[NSPropertyListSerialization
                                                  propertyListFromData:plistData
                                                  mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                  format:&format
                                                  errorDescription:&errorDesc];
        
    return startUpDict;
}
@end
