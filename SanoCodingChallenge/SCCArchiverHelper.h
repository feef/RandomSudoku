//
//  SCCArchiverHelper.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCArchiverHelper : NSObject

+(NSArray*)archiveDatasOfObjects:(NSArray*)objects;
+(NSArray*)unarchiveArrayOfObjectsFromDataArray:(NSArray*)objectDatas;

@end
