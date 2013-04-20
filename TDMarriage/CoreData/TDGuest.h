//
//  TDGuest.h
//  TDMarriage
//
//  Created by LEE CHIEN-MING on 11/8/12.
//  Copyright (c) 2012 LEE CHIEN-MING. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TDGuest : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * tableID;
@property (nonatomic, retain) NSNumber * checkBox;

@end
