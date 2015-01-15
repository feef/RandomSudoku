//
//  AppDelegate.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCCPuzzleGenerator.h"

#define SCC_PUZZLE_UPDATE_NOTIFICATION_KEY @"updatedToNewPuzzle"

@interface SCCAppDelegate : UIResponder <UIApplicationDelegate>

+(SCCAppDelegate*)sharedInstance;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) SCCPuzzle *puzzle;

@end

