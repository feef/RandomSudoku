//
//  SCCGroup.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SCCSquare.h"

@interface SCCGroup : NSObject <NSCopying, NSCoding>

-(instancetype)initWithCoordinate:(SCCCoordinate*)coordinate;

-(NSArray*)openSpaces;
-(NSArray*)filledSpaces;
-(NSArray*)row:(int)row;
-(NSArray*)column:(int)col;
-(void)reset;

@property(nonatomic)SCCCoordinate *coordinate;
@property(nonatomic)NSArray *spaces;

@end
