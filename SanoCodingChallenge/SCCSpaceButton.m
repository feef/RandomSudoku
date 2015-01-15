//
//  SCCSpaceButton.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCSpaceButton.h"

@implementation SCCSpaceButton

-(void)setSpace:(SCCSquare *)space {
    
    if(_space) {
        
        [self addObservers:NO forSpace:_space];
        
    }
    
    _space = space;
    
    [self addObservers:YES forSpace:_space];
    
    [self setTitleColor:!space.fixed ? [UIColor blueColor] : [UIColor blackColor] forState:UIControlStateNormal];
    [self setUserInteractionEnabled:!space.fixed];
    [self setSelected:NO];
    [self updateTitle];
    
}

-(void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    [self setBackgroundColor:selected ? [UIColor lightGrayColor] : [UIColor whiteColor]];
    
}

-(void)updateTitle {
    
    [self setTitle:self.space.number == SCC_SPACE_RESET_VALUE ? @"" : [NSString stringWithFormat:@"%i",[self.space number]] forState:UIControlStateNormal];

}

#pragma mark - KVO management and observance

-(void)addObservers:(BOOL)add forSpace:(SCCSquare*)space {
    
    if(add) {
        
        [space addObserver:self forKeyPath:@"number" options:0 context:NULL];
        
    } else {
        
        [space removeObserver:self forKeyPath:@"number"];
        
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    [self updateTitle];
    
}

@end
