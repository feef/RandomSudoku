//
//  SCCArchiverHelper.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCArchiverHelper.h"

@implementation SCCArchiverHelper

+(NSArray*)archiveDatasOfObjects:(NSArray*)objects {
    
    NSMutableArray *objectDatas = [[NSMutableArray alloc] init];
    for (NSObject *object in objects) {
        
        [objectDatas addObject:[NSKeyedArchiver archivedDataWithRootObject:object]];
        
    }
    return objectDatas;
    
}

+(NSArray*)unarchiveArrayOfObjectsFromDataArray:(NSArray*)objectDatas {
    
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (NSData *data in objectDatas) {
        
        NSObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [objects addObject:object];
        
    }
    return objects;
    
}

@end
