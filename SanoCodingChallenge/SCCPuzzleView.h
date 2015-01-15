//
//  SCCPuzzleView.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCBoardView.h"
#import "SCCGroupView.h"
#import "SCCPuzzle.h"

@interface SCCPuzzleView : SCCBoardView

-(void)populateWithPuzzle:(SCCPuzzle*)puzzle;

@property(nonatomic)SCCPuzzle *puzzle;
@property(nonatomic,weak)id delegate;

@end

@protocol SCCPuzzleViewDelegate <NSObject>

-(void)puzzleView:(SCCPuzzleView*)puzzleView selectedButton:(SCCSpaceButton*)button atCoordinate:(SCCCoordinate*)coordinate;

@end
