//
//  SCCSpace.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCCCoordinate.h"

#define SCC_SPACE_RESET_VALUE 0

@interface SCCSquare : NSObject <NSCopying, NSCoding>

-(instancetype)initWithCoordinate:(SCCCoordinate*)coordinate;

-(void)reset;

@property(nonatomic)SCCCoordinate *coordinate;
@property(nonatomic)int number;
@property(nonatomic)BOOL fixed;

@end
