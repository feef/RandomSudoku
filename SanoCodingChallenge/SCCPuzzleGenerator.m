//
//  SCCPuzzleGenerator.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzleGenerator.h"
#import "SCCPuzzleSolver.h"
#import "SCCPuzzleMapper.h"
#import "NSMutableArray+SCCShuffling.h"

@implementation SCCPuzzleGenerator

+(void)generatePuzzleWithDifficulty:(SCCPuzzleDifficulty)difficulty toCallbackBlock:(void (^)(SCCPuzzle*))callbackBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        SCCPuzzle *puzzle = [SCCPuzzleGenerator generateNewPuzzle];
        
        //Generate list of all possible coordinates to choose from
        NSMutableArray *allCoordinates = [[NSMutableArray alloc] init];
        for(int r = 0; r<9; r++) {
            
            for(int c = 0; c<9; c++) {
                
                [allCoordinates addObject:[[SCCCoordinate alloc] initWithX:c+1 Y:r+1]];
                
            }
            
        }
        
        //Pick a random set of coordinates, the number of picked coordinates depends on the difficulty
        NSMutableArray *coordinatesToRemove = [[NSMutableArray alloc] init];
        int numberOfSquaresToRemove = [SCCPuzzleGenerator numberOfRemovedSquaresForDifficulty:difficulty];
        for(int i = 0; i<numberOfSquaresToRemove; i++) {
            
            SCCCoordinate *coord = [allCoordinates objectAtIndex:arc4random() % allCoordinates.count];
            SCCCoordinate *complimentaryCoord = [SCCPuzzleMapper complimentaryCoordinate:coord];
            
            [coordinatesToRemove addObject:coord];
            [allCoordinates removeObject:coord];
            
            if(complimentaryCoord) {
                
                [coordinatesToRemove addObject:complimentaryCoord];
                [allCoordinates removeObject:complimentaryCoord];
                
            }
            
        }
        
        BOOL puzzleIsReady = NO;
        for(int i = numberOfSquaresToRemove; i>numberOfSquaresToRemove - 3 && !puzzleIsReady; i--) {
            
            //Remove the squares from a copy of the puzzle to allow us to "undo" if we make an unsolvalbe puzzle
            SCCPuzzle *reducedPuzzle = [puzzle copy];
            for (SCCCoordinate *coord in coordinatesToRemove) {
                
                SCCSquare *space = [SCCPuzzleMapper spaceAtAbsoluteCoordinate:coord inPuzzle:reducedPuzzle];
                space.fixed = NO;
                [space reset];
                
            }
            
            if([SCCPuzzleSolver puzzleIsSolvable:reducedPuzzle]) {
                
                puzzle = reducedPuzzle;
                puzzleIsReady = YES;
                
            } else {
                
                SCCCoordinate *lastCoord = [coordinatesToRemove lastObject];
                [coordinatesToRemove removeObject:[SCCPuzzleMapper complimentaryCoordinate:lastCoord]];
                [coordinatesToRemove removeObject:lastCoord];
                
            }
            
        }
        
        if(puzzleIsReady) {
            
            //We got out of our for loop because the puzzle was succesfully created with the proper difficulty
            puzzle.difficulty = difficulty;
            callbackBlock(puzzle);
            
        } else {
            
            //We couldn't create a puzzle with the proper difficulty. Try again.
            puzzle = nil;
            return [SCCPuzzleGenerator generatePuzzleWithDifficulty:difficulty toCallbackBlock:callbackBlock];
            
        }
        
    });
    
}

+(int)numberOfRemovedSquaresForDifficulty:(SCCPuzzleDifficulty)difficulty {
    
    switch (difficulty) {
        case SCCPuzzleDifficultyEasy:
            return 16;
            
        case SCCPuzzleDifficultyMedium:
            return 23;
            
        case SCCPuzzleDifficultyHard:
            return 28;
            
        default:
            return 16;
    }
    
}

+(SCCPuzzle*)generateNewPuzzle {
    
    SCCPuzzle *puzzle = [SCCPuzzle new];
    [SCCPuzzleGenerator fillPuzzle:puzzle];
    return puzzle;
    
}


+(void)fillPuzzle:(SCCPuzzle*)puzzle {
    
    [SCCPuzzleGenerator fillPuzzle:puzzle withNumber:1];
    
}

+(BOOL)fillPuzzle:(SCCPuzzle*)puzzle withNumber:(int)number {
    
    NSMutableIndexSet *filledRows = [[NSMutableIndexSet alloc] init];
    NSMutableIndexSet *filledCols = [[NSMutableIndexSet alloc] init];
    
    NSArray *filledSpaces = [SCCPuzzleGenerator fillGroupAtIndex:0 ofPuzzle:puzzle withNumber:number filledRows:filledRows filledCols:filledCols withoutStartSpaces:nil];
    
    if(filledSpaces) {
        
        if(number == 9) {
            
            //Whole puzzle is filled with the given number
            return YES;
            
        } else if([SCCPuzzleGenerator fillPuzzle:puzzle withNumber:number + 1]) {
            
            //The next number in the series was filled properly, so we are done
            return YES;
        }
        
        if(number == 9) {
            
            //All 9s are forced into place. If we fail to place 9s, just reset to make 8s undo
            for (SCCSquare *space in filledSpaces) {
                
                [space reset];
                
            }
            
        } else {
            
            //Unable to add numbers further along
            //setup for retry by removing the last filled space (which is forced into place by the other placed numbers)
            SCCSquare *lastSpace = [filledSpaces firstObject];
            [lastSpace reset];
            SCCCoordinate *coord = [SCCPuzzleMapper coordinateForSpaceCoordinate:lastSpace.coordinate inGroupWithCoordinate:[[puzzle.groups lastObject] coordinate]];
            [filledRows removeIndex:coord.y];
            [filledCols removeIndex:coord.x];
            
            for(int j = 1; j<9; j++) {
                
                //Remove the last succesfully placed number that had a choice of placement and place it in a different spot
                
                int groupNum = 8-j; //array is 0 indexed, so we have 0-8 inclusive, making the last placed number with a choice, space number 7
                int possibleRetries = (int)[[puzzle.groups objectAtIndex:groupNum] openSpaces].count;
                lastSpace = [filledSpaces objectAtIndex:j];
                
                [lastSpace reset];
                coord = [SCCPuzzleMapper coordinateForSpaceCoordinate:lastSpace.coordinate inGroupWithCoordinate:[puzzle.groups[groupNum] coordinate]];
                [filledRows removeIndex:coord.y];
                [filledCols removeIndex:coord.x];
                
                NSMutableArray *startSpaces = [[NSMutableArray alloc] initWithObjects:lastSpace, nil];
                for(int r = 0; r<possibleRetries; r++) {
                    
                    NSArray *filled = [SCCPuzzleGenerator fillGroupAtIndex:groupNum ofPuzzle:puzzle withNumber:number filledRows:filledRows filledCols:filledCols withoutStartSpaces:startSpaces];
                    
                    if(filled) {
                     
                        //Succesfully filled off of retry, continue the recursive loop
                        if([SCCPuzzleGenerator fillPuzzle:puzzle withNumber:number + 1]) {
                            
                            //The next number in the series was filled properly, so we are done
                            return YES;
                            
                        } else {
                            
                            //We failed to fill numbers further along on the retry, add the failed start spot to our and try again around the loop
                            for (int f = 0; f<filled.count; f++) {
                                
                                SCCSquare *space = filled[f];
                                [space reset];
                                coord = [SCCPuzzleMapper coordinateForSpaceCoordinate:space.coordinate inGroupWithCoordinate:[puzzle.groups[filled.count - 1 - f] coordinate]];
                                [filledRows removeIndex:coord.y];
                                [filledCols removeIndex:coord.x];
                                
                            }
                            
                            [startSpaces addObject:[filled firstObject]];
                            
                        }
                        
                    } else {
                        
                        //Failed to fill this number on the retry, exit the "possibleRetries" for loop to make the previous number retry it's placement
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    //Iterated through all possible pahts without success, unable to fill this number
    return NO;
}

+(NSArray*)fillGroupAtIndex:(int)groupIndex ofPuzzle:(SCCPuzzle*)puzzle withNumber:(int)number filledRows:(NSMutableIndexSet*)filledRows filledCols:(NSMutableIndexSet*)filledCols withoutStartSpaces:(NSArray*)startSpaces {
    
    SCCGroup *group = [puzzle.groups objectAtIndex:groupIndex];
    NSArray *spaces = [SCCPuzzleGenerator availableSpacesInGroup:group excludingRows:filledRows cols:filledCols];
    
    for(int s = 0; s<spaces.count; s++) {
        
        SCCSquare *selectedSpace = [spaces objectAtIndex:s];
        if([startSpaces containsObject:selectedSpace]) {
            
            //We've started here before, don't do it again
            continue;
            
        }
        
        //Add space to board, update filled rows / cols
        selectedSpace.number = number;
        SCCCoordinate *coord = [SCCPuzzleMapper coordinateForSpaceCoordinate:selectedSpace.coordinate inGroupWithCoordinate:group.coordinate];
        [filledRows addIndex:coord.y];
        [filledCols addIndex:coord.x];
        
        if(groupIndex+1 == 9) {
            
            return @[selectedSpace];
            
        } else {
            
            NSArray *filled = [SCCPuzzleGenerator fillGroupAtIndex:groupIndex+1 ofPuzzle:puzzle withNumber:number filledRows:filledRows filledCols:filledCols withoutStartSpaces:nil];
            if(filled) {
                
                //The group after us found a space, add our space to the filled array and return
                return [filled arrayByAddingObject:selectedSpace];
                
            }
            
        }
        
        //Remove space from board, update filled rows / cols
        [filledRows removeIndex:coord.y];
        [filledCols removeIndex:coord.x];
        [selectedSpace reset];
        
        
    }
    return nil;
    
}

+(NSArray*)availableSpacesInGroup:(SCCGroup*)group excludingRows:(NSIndexSet*)filledRows cols:(NSIndexSet*)filledCols {
    
    //Exclude spots as needed. Export a shuffled array ( http://stackoverflow.com/a/56656 )
    NSMutableArray *spaces = [[NSMutableArray alloc] initWithArray:[group openSpaces]];
    SCCCoordinate *coordinateOffset = [[SCCCoordinate alloc] initWithX:(group.coordinate.x - 1) * 3 Y:(group.coordinate.y - 1) * 3];
    for (SCCSquare *space in [spaces copy]) {
        
        if(space.number != SCC_SPACE_RESET_VALUE || [filledRows containsIndex:space.coordinate.y + coordinateOffset.y] || [filledCols containsIndex:space.coordinate.x + coordinateOffset.x]) {
            
            [spaces removeObject:space];
            
        }
        
    }
    [spaces shuffle];
    return spaces;
    
}

#pragma mark - puzzle debugging

+(void)printPuzzle:(SCCPuzzle*)puzzle {
    
    NSString *wholeBoard = @"";
    for(int i = 0; i<3; i++) {
        
        for(int j = 0; j<3; j++) {
            
            NSString *row = @"";
            for(int k = 0; k<3; k++) {
                
                NSArray *spaces = [puzzle.groups[k + i*3] row:j];
                row = [row stringByAppendingString:[NSString stringWithFormat:@"%i%i%i  ", [spaces[0] number], [spaces[1] number], [spaces[2] number]]];

            }
            wholeBoard = [wholeBoard stringByAppendingString:row];
            wholeBoard = [wholeBoard stringByAppendingString:@"\n"];
            
        }
        wholeBoard = [wholeBoard stringByAppendingString:@"\n"];
        
    }
    NSLog(@"\n\n%@\n\n", wholeBoard);
    
}

@end
