//
//  SCCPuzzleSolver.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzleSolver.h"
#import "SCCPuzzleMapper.h"
#import "NSIndexSet+Operations.h"

@implementation SCCPuzzleSolver


+(BOOL)puzzleIsSolvable:(SCCPuzzle*)puzzle {
    
    NSMutableArray *solvedGroups = [[NSMutableArray alloc] init];
    SCCPuzzle *solved = [puzzle copy];
    SCCGroup *lastSolvedGroup = nil;
    while(YES) {
        
        for(int g = 0; g<9; g++) {
            
            SCCGroup *group = [solved.groups objectAtIndex:g];
            if([lastSolvedGroup isEqual:group]) {
                
                //Trying to solve the same group on repeat, which means we've run out of groups to solve
                return NO;
                
            }
            
            if(![solvedGroups containsObject:group]) {
                
                if([self solveAllSpacesOfGroup:group inPuzzle:solved]) {
                    
                    if([group openSpaces].count == 0) {
                        
                        [solvedGroups addObject:group];
                        if(solvedGroups.count == 9) {
                            
                            //All solved! Return YES
                            return YES;
                            
                        }
                        
                    }
                    lastSolvedGroup = group;
                    
                }
                
            }
            
        }
        if(!lastSolvedGroup) {
            
            //We couldn't solve any group! unsolvable
            return NO;
            
        }
        
    }
    
}

//Return yes if ANY spaces are solved
+(BOOL)solveAllSpacesOfGroup:(SCCGroup*)group inPuzzle:(SCCPuzzle*)puzzle {
    
    NSArray *unsolvedSpaces = [group openSpaces];
    if(unsolvedSpaces.count != 0) {
        
        //There are unsolved spaces to fill in
        NSMutableIndexSet *solvedNumbers = [NSMutableIndexSet indexSet];
        for (SCCSquare *space in [group filledSpaces]) {
            
            [solvedNumbers addIndex:space.number];
            
        }
        NSIndexSet *unsolvedNumbers = [solvedNumbers relativeComplementInRange:NSMakeRange(1, 9)];
        
        //Try union of unsolvedNumbers with those missing from rows / columns of space's coordinate
        NSMutableArray *possibilities = [[NSMutableArray alloc] init];
        for (SCCSquare *space in unsolvedSpaces) {
            
            NSIndexSet *missingInRow = [SCCPuzzleSolver missingNumbersInRow:space.coordinate.y + (group.coordinate.y - 1) * 3 ofPuzzle:puzzle];
            NSIndexSet *missingInColumn = [SCCPuzzleSolver missingNumbersInColumn:space.coordinate.x + (group.coordinate.x - 1) * 3 ofPuzzle:puzzle];
            NSIndexSet *possibleNumbers = [[unsolvedNumbers intersectionWith:missingInRow] intersectionWith:missingInColumn];
            if(possibleNumbers.count == 1) {
                
                //We just solved a space!
                space.number = (int)[possibleNumbers lastIndex];
                
                //Call this method recursively to try to solve for more in this group
                [SCCPuzzleSolver solveAllSpacesOfGroup:group inPuzzle:puzzle];
                
                //Return yes, regardless of whether or not the rest of the group could be solved, because we solved 1 space
                return YES;
                
            }
            
            [possibilities addObject:possibleNumbers];
            
        }
        
        //Checking against rows / columns failed, but we could find a solution if one of our arrays contains an index that none of the other groups have
        for(int i = 0; i<possibilities.count; i++) {
            
            NSMutableIndexSet *uniqueNumbers = [[NSMutableIndexSet alloc] initWithIndexSet:[possibilities objectAtIndex:i]];
            for(int j = 0; j<possibilities.count; j++) {
                
                if(j == i) {
                    //Naturally, we need to skip comparing the same index set against itself
                    continue;
                }
                
                [uniqueNumbers removeIndexes:[uniqueNumbers intersectionWith:[possibilities objectAtIndex:j]]];
                
            }
            
            if(uniqueNumbers.count == 1) {
                
                //This is the only space in the group that can hold this number, so we have solved for the space!
                //Because fast enumeration goes in order, we can just use "i" as the index of the solved space
                [[unsolvedSpaces objectAtIndex:i] setNumber:(int)[uniqueNumbers lastIndex]];
                
                //Call this method recursively to try to solve for more in this group
                [SCCPuzzleSolver solveAllSpacesOfGroup:group inPuzzle:puzzle];
                
                //Return yes, regardless of whether or not the rest of the group could be solved, because we solved 1 space
                return YES;
                
            }
            
        }
        
        
        return NO;
    }
    
    return YES;
    
}

+(NSIndexSet*)missingNumbersInRow:(int)row ofPuzzle:(SCCPuzzle*)puzzle {
    
    NSMutableIndexSet *numbers = [[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(1, 9)];
    for (int c = 0; c<9; c++) {
        
        SCCSquare *space = [SCCPuzzleMapper spaceAtAbsoluteCoordinate:[[SCCCoordinate alloc] initWithX:c+1 Y:row] inPuzzle:puzzle];
        if(space.number != SCC_SPACE_RESET_VALUE) {
            [numbers removeIndex:space.number];
        }
        
    }
    return numbers;
    
}

+(NSIndexSet*)missingNumbersInColumn:(int)col ofPuzzle:(SCCPuzzle*)puzzle {
    
    NSMutableIndexSet *numbers = [[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(1, 9)];
    for (int r = 0; r<9; r++) {
        
        SCCSquare *space = [SCCPuzzleMapper spaceAtAbsoluteCoordinate:[[SCCCoordinate alloc] initWithX:col Y:r+1] inPuzzle:puzzle];
        if(space.number != SCC_SPACE_RESET_VALUE) {
            [numbers removeIndex:space.number];
        }
        
    }
    return numbers;
    
}

+(BOOL)isSolvedGroup:(SCCGroup*)group {
    
    NSArray *filledSpaces = [group filledSpaces];
    if(filledSpaces.count == 9) {
        
        NSMutableIndexSet *solvedNumbers = [[NSMutableIndexSet alloc] init];
        for (SCCSquare *space in filledSpaces) {
            
            [solvedNumbers addIndex:space.number];
            
        }
        return solvedNumbers.count == 9;
        
    }
    return NO;
    
}

+(BOOL)puzzleIsSolved:(SCCPuzzle*)puzzle {
    
    for(int i = 0; i<9; i++) {
        
        if(!([SCCPuzzleSolver missingNumbersInColumn:i+1 ofPuzzle:puzzle].count == 0 && [SCCPuzzleSolver missingNumbersInRow:i+1 ofPuzzle:puzzle] && [SCCPuzzleSolver isSolvedGroup:puzzle.groups[i]]))
            return NO;
        
    }
    return YES;

}

@end
