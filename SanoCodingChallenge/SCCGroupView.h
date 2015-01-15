//
//  SCCGroupView.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/13/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCBoardView.h"
#import "SCCGroup.h"
#import "SCCSpaceButton.h"

@interface SCCGroupView : SCCBoardView

@property(nonatomic)SCCGroup *group;
@property(nonatomic,weak)id delegate;

@end

@protocol SCCGroupViewDelegate <NSObject>

-(void)groupView:(SCCGroupView*)groupView selectedButton:(SCCSpaceButton*)button withCoordinate:(SCCCoordinate*)coordinate;

@end
