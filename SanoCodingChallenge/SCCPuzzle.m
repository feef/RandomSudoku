//
//  SCCBoard.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzle.h"
#import "SCCArchiverHelper.h"

@implementation SCCPuzzle

-(instancetype)init {
    
    self = [super init];
    if(self) {
        
        NSMutableArray *groups = [[NSMutableArray alloc] init];
        for(int i = 0; i<9; i++) {
            
            [groups addObject:[[SCCGroup alloc] initWithCoordinate:[[SCCCoordinate alloc] initWithX:(i%3)+1 Y:(i/3)+1]]];
            
        }
        _groups = groups;
        
    }
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone {
    
    SCCPuzzle *copy = [SCCPuzzle new];
    NSMutableArray *groupsCopy = [[NSMutableArray alloc] init];
    for (SCCGroup *group in self.groups) {
        [groupsCopy addObject:[group copy]];
    }
    [copy setGroups:groupsCopy];
    [copy setDifficulty:self.difficulty];
    return copy;
    
}

#define NSCoding compliance

#define GROUP_KEY @"groups"
#define DIFFICULTY_KEY @"difficulty"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:[SCCArchiverHelper archiveDatasOfObjects:self.groups] forKey:GROUP_KEY];
    [aCoder encodeInteger:self.difficulty forKey:DIFFICULTY_KEY];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if(self) {
     
        _groups = [SCCArchiverHelper unarchiveArrayOfObjectsFromDataArray:[aDecoder decodeObjectForKey:GROUP_KEY]];
        _difficulty = (SCCPuzzleDifficulty)[aDecoder decodeIntegerForKey:DIFFICULTY_KEY];
        
    }
    
    return self;
    
}

@end
