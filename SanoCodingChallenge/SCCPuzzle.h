//
//  SCCBoard.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SCCGroup.h"

typedef enum {
    
    SCCPuzzleDifficultyEasy,
    SCCPuzzleDifficultyMedium,
    SCCPuzzleDifficultyHard
    
}SCCPuzzleDifficulty;

@interface SCCPuzzle : NSObject <NSCopying, NSCoding>

@property(nonatomic)NSArray *groups;
@property(nonatomic)SCCPuzzleDifficulty difficulty;

@end
