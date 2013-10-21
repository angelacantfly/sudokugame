//
//  Grid.m
//  Sudoku28.v1
//
//  Created by CS121 on 9/12/13.
//  Copyright (c) 2013 Matt Cook. All rights reserved.
//

#import "Grid.h"

@implementation Grid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        int dimensionX = self.bounds.size.width * 0.10;
        int dimensionY = self.bounds.size.height * 0.10;
        
        CGRect labelFrame = CGRectMake(200, 650, 220, 50);
        UILabel* messageLabel = [[UILabel alloc] initWithFrame:labelFrame];
        UIColor* labelColor = [UIColor colorWithRed:249/255.0f green:244/255.0f blue:206/255.0f alpha:1.0f];
        messageLabel.backgroundColor = labelColor;
        messageLabel.textAlignment = UITextAlignmentCenter;
        [messageLabel setText:@"Hello, make a move!"];
        [self addSubview:messageLabel];
        
        // Create the buttons on the grid
        for (int j = 0; j < 9; j++) {
            for (int i = 0; i < 9; i++) {
                
                // Create the frame
                int originX = (i*dimensionX);
                int originY = (j*dimensionY);
                int index = j*9+i;
                // create different widths borders for the 3x3 boxes in the Sudoku grid
                if (i < 3)
                    originX = originX + self.bounds.size.width * 0.03;
                else if (i < 6)
                    originX = originX + self.bounds.size.width * 0.06;
                else
                    originX = originX + self.bounds.size.width * 0.09;
                
                if (j < 3)
                    originY = originY + self.bounds.size.height * 0.03;
                else if (j < 6)
                    originY = originY + self.bounds.size.height * 0.06;
                else
                    originY = originY + self.bounds.size.height * 0.09;
                
                int size = self.bounds.size.width * 0.09;
                CGRect buttonFrame = CGRectMake(originX, originY, size, size);
                
                // Now create the button at the given position
                UIButton* theButton = [[UIButton alloc] initWithFrame:buttonFrame];
                theButton.backgroundColor = [UIColor whiteColor];
                [theButton setTag:index];
                [theButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview: theButton];
                [self.gridButtons addObject: theButton];
            }
        }
    }
    return self;
}

// initializer for the buttons array
-(NSMutableArray*) gridButtons {
    if (!_gridButtons){
        _gridButtons = [[NSMutableArray alloc] init];
    }
    return _gridButtons;
}

// Change value of a button with given index number, intended for the Model when a button is pressed
-(void) setValue:(int) contents atIndex: (int) index {
    UIButton* button = [_gridButtons objectAtIndex:index];
    
    // Initialize message lable:
    CGRect labelFrame = CGRectMake(200, 650, 220, 50);
    UILabel* messageLabel = [[UILabel alloc] initWithFrame:labelFrame];
    UIColor* labelColor = [UIColor colorWithRed:249/255.0f green:244/255.0f blue:206/255.0f alpha:1.0f];
    messageLabel.backgroundColor = labelColor;
    messageLabel.textAlignment = UITextAlignmentCenter;
    [messageLabel setText:@"Hello, make a move!"];
    [self addSubview:messageLabel];
    UIColor* greenMessageColor = [UIColor colorWithRed:58/255.0f green:119/255.0f blue:45/255.0f alpha:1.0f];
    
    NSAssert(contents >= 0, @"contents to be set must be non-negative");
    
    // Test if if the pressed button contains a default number, which is blue.
    if ([button titleColorForState:(UIControlStateNormal)] == [UIColor blueColor]) {
        NSLog(@"Can't change the value at the default number!");
        messageLabel.text = @"Can't change default value!";
        messageLabel.textColor = [UIColor redColor];
        return;
    }
    
    // For erase button, whose value is 0
    if (contents == 0) {
        [button setTitle:[NSString stringWithFormat:@""]
            forState:UIControlStateNormal];
        messageLabel.text = @"Erase successfully!";
        messageLabel.textColor = greenMessageColor;
    }
    // Other buttons 
    else {
        [button setTitle:[NSString stringWithFormat:@"%d", contents]
            forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        messageLabel.text = @"That's a good move!";
        messageLabel.textColor = greenMessageColor;
    }
    NSString* message = [[NSString alloc] initWithFormat:@"Setting button %d with contents %d", index, contents];
    NSLog(@"%@", message);
}

// action and output for pressing a button on the grid
-(void) buttonPressed: (id) sender {
    int theTag = [sender tag];
    NSString* message = [[NSString alloc] initWithFormat:@"The button pressed was %d with contents %@", theTag, [sender currentTitle]];
    NSLog(@"%@", message);
    
    [self.delegate gridButtonPressed:theTag];
    
}

// Return the value of the button with the given index
- (int) getValue:(int)index{
    UIButton* button = [_gridButtons objectAtIndex:index];
    int buttonContent = 0;
    //if ([button tag] != 0){                                   ////////////WHAT IS THIS FOR??
        buttonContent = [[button currentTitle] integerValue];
    //}
    return buttonContent;
}

// Check if a given value can be inputted into given index
- (BOOL) checkConsistency:(int)value AtIndex:(int)index{
    
    int buttonNumber = index;
    int currentNumber = value;
    float rowNumber = buttonNumber / ((float) 9) ;
    int row = (int) rowNumber;
    int colNumber = buttonNumber % 9 ;
    
    
    // Check if the input number already exists in the input row
    for (int i = row * 9; i < (row + 1) * 9; i++) {
        int anyNumber = [self getValue:i];
        if (anyNumber == currentNumber && currentNumber != 0){
            return false;
        }
    }
    
    // Check if the input number already exists in the input column
    for (int i = colNumber; i < 81; i = i + 9) {
        int anyNumber = [self getValue:i];
        if (anyNumber == currentNumber && currentNumber != 0){
            return false;
        }
    }
    // Check if the input number already exists in the 3x3 box
    int blockRow = (row / 3) * 3;
    int blockCol = (colNumber / 3) * 3;
    for (int r = blockRow; r < blockRow + 3; r++) {
        for (int c = blockCol; c < blockCol + 3; c++) {
            int i = (r * 9) + c;
            int anyNumber = [self getValue:i];
            if (anyNumber == currentNumber && currentNumber != 0) {
                return false;
            }
        }
    }
    // if there are no conflicts in consistency, we return true
    return true;
}

- (void) setErrorLabel: (NSString*)inputString {
    CGRect labelFrame = CGRectMake(200, 650, 220, 50);
    UILabel* messageLabel = [[UILabel alloc] initWithFrame:labelFrame];
    UIColor* labelColor = [UIColor colorWithRed:249/255.0f green:244/255.0f blue:206/255.0f alpha:1.0f];
    messageLabel.backgroundColor = labelColor;
    messageLabel.textAlignment = UITextAlignmentCenter;
    [messageLabel setText:inputString];
    messageLabel.textColor = [UIColor redColor];
    [self addSubview:messageLabel];
    
    
}

@end
