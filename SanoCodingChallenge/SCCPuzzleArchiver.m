//
//  SCCPuzzleArchiver.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#define PUZZLE_KEY @"puzzle"

#import "SCCPuzzleArchiver.h"

@implementation SCCPuzzleArchiver

+(void)archivePuzzle:(SCCPuzzle*)puzzle {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:puzzle] forKey:PUZZLE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(SCCPuzzle*)unarchivedPuzzle {
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:PUZZLE_KEY]];
    
}

@end
