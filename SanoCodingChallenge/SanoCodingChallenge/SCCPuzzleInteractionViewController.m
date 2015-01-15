//
//  ViewController.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/12/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzleInteractionViewController.h"
#import "SCCAppDelegate.h"
#import "SCCPuzzleSolver.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define SCC_X_BUTTON_TAG -1

@interface SCCPuzzleInteractionViewController () <SCCPuzzleViewDelegate, UIAlertViewDelegate>

@property(nonatomic)SCCSpaceButton *selectedSquare;

@end

@implementation SCCPuzzleInteractionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupToolbar];
    [self.puzzleView setDelegate:self];
    [self updatePuzzleView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePuzzleView) name:SCC_PUZZLE_UPDATE_NOTIFICATION_KEY object:nil];
    
}

#pragma mark - Toolbar setup

-(void)setupToolbar {
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithObjects:[self flexibleSpace], nil];
    for(int i = 0; i<9; i++) {
        
        [toolbarItems addObject:[self barButtonItemWithNumber:i+1]];
        [toolbarItems addObject:[self flexibleSpace]];
        
    }
    
    [toolbarItems addObject:[[UIBarButtonItem alloc] initWithTitle:@"x" style:UIBarButtonItemStylePlain target:self action:@selector(tappedToolbarItem:)]];
    [toolbarItems addObject:[self flexibleSpace]];
    
    [self setToolbarItems:toolbarItems animated:NO];
    
}

-(UIBarButtonItem*)flexibleSpace {
    
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
}

-(UIBarButtonItem*)barButtonItemWithNumber:(int)number {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%i",number] style:UIBarButtonItemStylePlain target:self action:@selector(tappedToolbarItem:)];
    item.tag = number;
    return item;
    
}

-(UIBarButtonItem*)xBarButtonItem {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"x" style:UIBarButtonItemStylePlain target:self action:@selector(tappedToolbarItem:)];
    item.tag = SCC_X_BUTTON_TAG;
    return item;
    
}

#pragma mark - view updating

-(void)tappedToolbarItem:(UIBarButtonItem*)toolbarItem {
    
    if(toolbarItem.tag == SCC_X_BUTTON_TAG) {
        
        [self.selectedSquare.space reset];
        
    } else {
        
        [self.selectedSquare.space setNumber:(int)toolbarItem.tag];
        [self checkForCompletion];
        
    }
    
}

-(void)puzzleView:(SCCPuzzleView *)puzzleView selectedButton:(SCCSpaceButton *)button atCoordinate:(SCCCoordinate *)coordinate {
    
    [self.selectedSquare setSelected:NO];
    self.selectedSquare = button;
    [self.selectedSquare setSelected:YES];
    
}

-(void)updatePuzzleView {
    
    SCCPuzzle *puzzle = [[SCCAppDelegate sharedInstance] puzzle];
    self.selectedSquare = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.puzzleView setPuzzle:puzzle];
        [self.navigationItem setTitle:[self titleForPuzzleDifficulty:puzzle.difficulty]];
        
    });
    
}

-(NSString*)titleForPuzzleDifficulty:(SCCPuzzleDifficulty)difficulty {
    
    NSString *puzzleString;
    
    switch (difficulty) {
            
        case SCCPuzzleDifficultyEasy:
            puzzleString = @"Easy";
            break;
            
        case SCCPuzzleDifficultyMedium:
            puzzleString = @"Medium";
            break;
            
        case SCCPuzzleDifficultyHard:
            puzzleString = @"Hard";
            break;
            
        default:
            break;
            
    }
    
    return [puzzleString stringByAppendingString:@" Puzzle"];
    
}

-(void)checkForCompletion {
    
    if([SCCPuzzleSolver puzzleIsSolved:[[SCCAppDelegate sharedInstance] puzzle]]) {
        
        [[[UIAlertView alloc] initWithTitle:@"Congratulations!" message:[NSString stringWithFormat:@"You completed the puzzle!"] delegate:self cancelButtonTitle:@"Let's go again!" otherButtonTitles:nil] show];
        
    }
    
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [SVProgressHUD showWithStatus:@"Generating puzzle" maskType:SVProgressHUDMaskTypeBlack];
    [SCCPuzzleGenerator generatePuzzleWithDifficulty:[[SCCAppDelegate sharedInstance] puzzle].difficulty toCallbackBlock:^(SCCPuzzle *puzzle) {
        
        [[SCCAppDelegate sharedInstance] setPuzzle:puzzle];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
        });
        
    }];
    
}

@end
