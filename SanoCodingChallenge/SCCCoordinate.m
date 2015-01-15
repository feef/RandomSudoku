//
//  SCCCoordinate.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCCoordinate.h"

@implementation SCCCoordinate

-(instancetype)initWithX:(int)x Y:(int)y {
    
    self = [super init];
    if(self) {
        
        _x = x;
        _y = y;
        
    }
    return self;
    
}

-(BOOL)isEqual:(id)object {
    
    return [object isKindOfClass:[SCCCoordinate class]] && [(SCCCoordinate*)object x] == self.x && [(SCCCoordinate*)object y] == self.y;
    
}

#pragma mark - NSCoding compliance

#define X_KEY @"x"
#define Y_KEY @"y"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInt:self.x forKey:X_KEY];
    [aCoder encodeInt:self.y forKey:Y_KEY];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if(self) {
        
        _x = [aDecoder decodeIntForKey:X_KEY];
        _y = [aDecoder decodeIntForKey:Y_KEY];
        
    }
    
    return self;
    
}

@end
