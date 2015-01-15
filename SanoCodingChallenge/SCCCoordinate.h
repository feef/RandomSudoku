//
//  SCCCoordinate.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SCCCoordinate : NSObject <NSCoding>

-(instancetype)initWithX:(int)x Y:(int)y;

@property(nonatomic)int x;
@property(nonatomic)int y;

@end
