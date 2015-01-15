//
//  SCCPuzzleArchiver.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCCPuzzle.h"

@interface SCCPuzzleArchiver : NSObject

+(void)archivePuzzle:(SCCPuzzle*)puzzle;
+(SCCPuzzle*)unarchivedPuzzle;

@end
