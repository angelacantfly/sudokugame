//
//  AZViewController.m
//  sudoku.v3.withTesting
//
//  Created by Angela Zhou on 9/20/13.
//  Copyright (c) 2013 Angela Zhou. All rights reserved.
//

#import "AZViewController.h"


@interface AZViewController ()
{
    Grid* theGrid;
    InputPanel* thePanel;
    SudokuModel* theModel;
    int currentNumber;
}

@end

@implementation AZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create bounds and frame for the grid
    int originX = self.view.bounds.size.width * .10;
    int originY = self.view.bounds.size.height * .10;
    int size = MIN(self.view.bounds.size.height, self.view.bounds.size.width) * .80;
    CGRect gridFrame = CGRectMake(originX, originY, size, size);
    
    int panelX = self.view.bounds.size.width * .04;
    int panelY = self.view.bounds.size.height * .80;
    int panelWidth = self.view.bounds.size.width * 0.92;
    int panelHeight = self.view.bounds.size.height * 0.076;
    CGRect panelFrame = CGRectMake(panelX, panelY, panelWidth, panelHeight);
    
    // Create the grid
    theGrid = [[Grid alloc] initWithFrame: gridFrame];
    theGrid.delegate = self;
    [self.view addSubview: theGrid];
    
    // Create the input panel
    thePanel = [[InputPanel alloc] initWithFrame: panelFrame];
    thePanel.delegate = self;
    [self.view addSubview: thePanel];
    
    // Create the model
    theModel = [[SudokuModel alloc] init];
    
    // initialize the currentNumber to start at 0, which is blank
    currentNumber = 0;
    
    //Fill in the grid with values from the Sudoku array of numbers
    for (int i = 0; i < 81; i++) {
        NSInteger buttonIndex = i;
        int buttonValue = [theModel getValueAt:i];
        //NSLog(@"button value is %d", buttonValue);
        UIButton* someButton = [theGrid.gridButtons objectAtIndex:buttonIndex];
        if (buttonValue != 0) {
            [someButton setTitle:[NSString stringWithFormat:@"%d", buttonValue]
                        forState:UIControlStateNormal];
            [someButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
    
    for (int i = 0; i < 10; i++) {
        NSInteger inputValue = i;
        UIButton* someButton = [thePanel.inputButtons objectAtIndex:inputValue];
        if (inputValue != 0) {
            [someButton setTitle:[NSString stringWithFormat:@"%d", inputValue]
                        forState:UIControlStateNormal];
            [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else {
            [someButton setTitle:@"Erase" forState:UIControlStateNormal];
            [someButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
    }
}

-(void) inputButtonPressed:(int)buttonNumber
{
    currentNumber = buttonNumber;
    NSLog(@"The current number highlighted on the input panel is: %d", currentNumber);
}

-(void) gridButtonPressed:(int)buttonNumber
{
    BOOL validLocation = [theGrid checkConsistency:currentNumber AtIndex:buttonNumber];
    if (!validLocation) {
        [theGrid setErrorLabel:@"Can't make that move!"];
        NSLog(@"%d already exists in that row, column, or box!", currentNumber);
    }
    else {
        [theGrid setValue:currentNumber atIndex: buttonNumber];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
