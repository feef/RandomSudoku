//
//  NSMutableArray+SCCShuffling.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "NSMutableArray+SCCShuffling.h"

@implementation NSMutableArray (SCCShuffling)

//Exclude spots as needed. Export a shuffled array ( http://stackoverflow.com/a/56656 )

- (void)shuffle {
    
    NSUInteger count = [self count];
    
    for (NSUInteger i = 0; i < count; ++i) {
        
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
        
    }
    
}

@end
