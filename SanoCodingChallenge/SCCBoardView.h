//
//  SCCBoardView.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCBoardView : UIView

-(void)setup;

-(void)addBoxesOfClass:(Class)subviewClass;

@property(nonatomic)NSArray *boxes;

@end
