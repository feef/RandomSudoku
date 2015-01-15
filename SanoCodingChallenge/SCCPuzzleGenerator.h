//
//  SCCPuzzleGenerator.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCCPuzzle.h"

@interface SCCPuzzleGenerator : NSObject

+(void)generatePuzzleWithDifficulty:(SCCPuzzleDifficulty)difficulty toCallbackBlock:(void (^)(SCCPuzzle*))callbackBlock;

@end
