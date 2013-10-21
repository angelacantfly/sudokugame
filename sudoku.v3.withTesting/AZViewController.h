//
//  AZViewController.h
//  sudoku.v3.withTesting
//
//  Created by Angela Zhou on 9/20/13.
//  Copyright (c) 2013 Angela Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grid.h"
#import "SudokuModel.h"
#import "InputPanel.h"

@interface AZViewController : UIViewController <InputPanelDelegate, GridDelegate>;

-(void) inputButtonPressed:(int)buttonNumber;
-(void) gridButtonPressed:(int)buttonNumber;


@end
