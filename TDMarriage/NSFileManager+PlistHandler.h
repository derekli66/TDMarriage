//
//  NSFileManager+PlistHandler.h
//
//

@interface NSFileManager (PlistHandler)
-(NSDictionary *)readPlistFromBundleWithFile:(NSString*)fileName;
@end
