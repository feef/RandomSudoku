//
//  SCCPuzzleSolver.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCCPuzzle.h"

@interface SCCPuzzleSolver : NSObject

+(BOOL)puzzleIsSolvable:(SCCPuzzle*)puzzle;
+(BOOL)puzzleIsSolved:(SCCPuzzle*)puzzle;

@end
