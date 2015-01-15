//
//  SCCGroupView.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCGroupView.h"

@implementation SCCGroupView

-(void)setup {
    
    [self addBoxesOfClass:[SCCSpaceButton class]];
    for (int i = 0; i<self.boxes.count; i++) {
        
        SCCSpaceButton *button = self.boxes[i];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.tag = i;
        [button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)setGroup:(SCCGroup *)group {
    
    _group = group;
    for (int i = 0; i<self.boxes.count; i++) {
        
        [self.boxes[i] setSpace:group.spaces[i]];
        
    }
    
}

-(void)pressedButton:(SCCSpaceButton*)button {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(groupView:selectedButton:withCoordinate:)]) {
        
        [self.delegate groupView:self selectedButton:button withCoordinate:[[SCCCoordinate alloc] initWithX:(button.tag % 3) + 1 Y:(int)(button.tag / 3) + 1]];
        
    }
    
}

@end
