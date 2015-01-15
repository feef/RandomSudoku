//
//  SCCPuzzleOptionsViewController.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCPuzzleOptionsViewController : UIViewController

@property(nonatomic,weak)IBOutlet UIButton *easyButton;
@property(nonatomic,weak)IBOutlet UIButton *mediumButton;
@property(nonatomic,weak)IBOutlet UIButton *hardButton;

-(IBAction)tappedCancelButton:(id)sender;

@end
