//
//  SCCGroup.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCGroup.h"
#import "SCCArchiverHelper.h"

@implementation SCCGroup

-(instancetype)initWithCoordinate:(SCCCoordinate*)coordinate {
    
    self = [super init];
    if(self) {
        
        NSMutableArray *spaces = [[NSMutableArray alloc] init];
        for(int i = 0; i<9; i++) {
            
            SCCSquare *space = [[SCCSquare alloc] initWithCoordinate:[[SCCCoordinate alloc] initWithX:(i%3) + 1 Y:(i/3) + 1]];
            [spaces addObject:space];
            
        }
        _spaces = spaces;
        _coordinate = coordinate;
        
    }
    return self;
    
}

-(NSArray *)openSpaces {
    
    NSMutableArray *openSpaces = [[NSMutableArray alloc] init];
    for (SCCSquare *space in self.spaces) {
        if(space.number == SCC_SPACE_RESET_VALUE) {
            [openSpaces addObject:space];
        }
    }
    return openSpaces;
    
}

-(NSArray*)filledSpaces {
    
    NSMutableArray *filledSpaces = [[NSMutableArray alloc] init];
    for (SCCSquare *space in self.spaces) {
        if(space.number != SCC_SPACE_RESET_VALUE) {
            [filledSpaces addObject:space];
        }
    }
    return filledSpaces;
    
}

-(NSArray*)row:(int)row {
    
    NSMutableArray *s = [[NSMutableArray alloc] init];
    for(int i = row*3; i < row*3 + 3; i++) {
        [s addObject:[self.spaces objectAtIndex:i]];
    }
    return s;
    
}

-(NSArray*)column:(int)col {
    
    NSMutableArray *s = [[NSMutableArray alloc] init];
    for(int i = col; i < col + 9; i+=3) {
        [s addObject:[self.spaces objectAtIndex:i]];
    }
    return s;
    
}

-(void)reset {
    
    for (SCCSquare *space in self.spaces) {
        
        [space reset];
        
    }
    
}

#pragma mark - NSCopying compliance

-(id)copyWithZone:(NSZone *)zone {
    
    SCCGroup *copy = [[SCCGroup alloc] initWithCoordinate:self.coordinate];
    NSMutableArray *spacesCopy = [[NSMutableArray alloc] init];
    for (SCCSquare *space in self.spaces) {
        [spacesCopy addObject:[space copy]];
    }
    [copy setSpaces:spacesCopy];
    return copy;
    
}

#pragma mark - NSCoding compliance

#define SPACE_KEY @"spaces"
#define COORDINATE_KEY @"coordinate"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:[SCCArchiverHelper archiveDatasOfObjects:self.spaces] forKey:SPACE_KEY];
    [aCoder encodeObject:self.coordinate forKey:COORDINATE_KEY];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if(self) {
        
        _spaces = [SCCArchiverHelper unarchiveArrayOfObjectsFromDataArray:[aDecoder decodeObjectForKey:SPACE_KEY]];
        _coordinate = [aDecoder decodeObjectForKey:COORDINATE_KEY];
        
    }
    
    return self;
    
}

@end
