//
//  SCCPuzzleOptionsViewController.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzleOptionsViewController.h"
#import "SCCPuzzle.h"
#import "SCCAppDelegate.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SCCPuzzleOptionsViewController () <UIAlertViewDelegate>

@property(nonatomic)SCCPuzzleDifficulty selectedDifficulty;

@end

@implementation SCCPuzzleOptionsViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    NSArray *buttons = @[self.easyButton, self.mediumButton, self.hardButton];
    for (int i = 0; i<buttons.count; i++) {
        UIButton *button = buttons[i];
        [button setTag:i];
        [button addTarget:self action:@selector(tappedDifficultyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

#pragma mark - User interaction response

-(void)tappedDifficultyButton:(UIButton *)sender {
    
    self.selectedDifficulty = (SCCPuzzleDifficulty)sender.tag;
    [[[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"This will abandon your current puzzle and any progress you've made on it" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] show];
    
}

-(void)tappedCancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex != alertView.cancelButtonIndex) {
        
        //Tapped "OK", generate the new puzzle and dismiss
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        
        [SVProgressHUD showWithStatus:@"Generating puzzle" maskType:SVProgressHUDMaskTypeBlack];
        __weak SCCPuzzleOptionsViewController *wSelf = self;
        [SCCPuzzleGenerator generatePuzzleWithDifficulty:self.selectedDifficulty toCallbackBlock:^(SCCPuzzle *puzzle) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                SCCPuzzleOptionsViewController *sSelf = wSelf;
                if(sSelf) {
                    
                    [[SCCAppDelegate sharedInstance] setPuzzle:puzzle];
                    [SVProgressHUD dismiss];
                    [sSelf dismissViewControllerAnimated:YES completion:nil];
                    
                }
                
            });

        }];
        
        
    }
    
}

@end
