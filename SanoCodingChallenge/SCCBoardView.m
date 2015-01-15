//
//  SCCBoardView.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCBoardView.h"

@implementation SCCBoardView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        [self setup];
        
    }
    return self;
    
}

-(void)setBounds:(CGRect)bounds {
    
    [super setBounds:bounds];
    for (UIView *sv in self.subviews) {
        [sv removeFromSuperview];
    }
    [self setup];
    
}

//Override in subclasses for custom setup after the bounds has been determined
-(void)setup{}

-(void)addBoxesOfClass:(Class)subviewClass {

    CGRect subviewFrame = self.bounds;
    float borderWidth = floorf(subviewFrame.size.width / 32);
    subviewFrame.size.width /= 3;
    subviewFrame.size.height /= 3;
    subviewFrame.size.width -= (borderWidth * 2)/3;
    subviewFrame.size.height -= (borderWidth * 2)/3;
    subviewFrame.origin.y = 0;
    
    NSMutableArray *boxes = [[NSMutableArray alloc] init];
    
    for(int r = 0; r<3; r++) {
        
        subviewFrame.origin.x = 0;
        for(int c = 0; c<3; c++) {
            
            UIView *subview = [[subviewClass alloc] initWithFrame:subviewFrame];
            [self addSubview:subview];
            subviewFrame.origin.x += borderWidth + subviewFrame.size.width;
            [boxes addObject:subview];
            
        }
        subviewFrame.origin.y += borderWidth + subviewFrame.size.height;
        
    }
    
    self.boxes = boxes;
    
}



@end
