//
//  SCCSpace.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCSquare.h"

@implementation SCCSquare

-(instancetype)initWithCoordinate:(SCCCoordinate*)coordinate {
    
    self = [super init];
    if(self) {
        
        _coordinate = coordinate;
        _fixed = YES;
        
    }
    return self;
    
}

-(void)reset {
    
    self.number = SCC_SPACE_RESET_VALUE;
    
}

#pragma mark - NSCopying compliance

-(id)copyWithZone:(NSZone *)zone {
    
    SCCSquare *copy = [[SCCSquare alloc] initWithCoordinate:self.coordinate];
    [copy setNumber:self.number];
    return copy;
    
}

#pragma mark - NSCoding compliance

#define NUMBER_KEY @"number"
#define FIXED_KEY @"fixed"
#define COORDINATE_KEY @"coordinate"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInt:self.number forKey:NUMBER_KEY];
    [aCoder encodeBool:self.fixed forKey:FIXED_KEY];
    [aCoder encodeObject:self.coordinate forKey:COORDINATE_KEY];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if(self) {
        
        _number = [aDecoder decodeIntForKey:NUMBER_KEY];
        _fixed = [aDecoder decodeBoolForKey:FIXED_KEY];
        _coordinate = [aDecoder decodeObjectForKey:COORDINATE_KEY];
        
    }
    
    return self;
    
}

@end
