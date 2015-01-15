//
//  SCCPuzzleView.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzleView.h"
#import "SCCPuzzleMapper.h"

@interface SCCPuzzleView () <SCCGroupViewDelegate>

@end

@implementation SCCPuzzleView

-(void)setup {
    
    [self addBoxesOfClass:[SCCGroupView class]];
    [self setBackgroundColor:[UIColor blackColor]];
    for (int i = 0; i<self.boxes.count; i++) {
        
        SCCGroupView *groupView = self.boxes[i];
        [groupView setBackgroundColor:[UIColor blackColor]];
        [groupView setTag:i];
        [groupView setDelegate:self];
        
    }
    
    if(self.puzzle) {
        
        [self populateWithPuzzle:self.puzzle];
        
    }
    
}

-(void)populateWithPuzzle:(SCCPuzzle*)puzzle {
    
    for (int i = 0; i<self.boxes.count; i++) {
        
        [self.boxes[i] setGroup:puzzle.groups[i]];
        
    }
    
}

-(void)setPuzzle:(SCCPuzzle *)puzzle {
    
    _puzzle = puzzle;
    [self populateWithPuzzle:puzzle];
    
}

-(void)groupView:(SCCGroupView *)groupView selectedButton:(SCCSpaceButton *)button withCoordinate:(SCCCoordinate *)coordinate {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(puzzleView:selectedButton:atCoordinate:)]) {
                
        [self.delegate puzzleView:self selectedButton:button atCoordinate:[SCCPuzzleMapper coordinateForSpaceCoordinate:coordinate inGroupWithCoordinate:groupView.group.coordinate]];
        
    }
    
}

@end
