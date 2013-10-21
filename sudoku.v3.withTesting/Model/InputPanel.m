//
//  InputPanel.m
//  Sudoku28.v1
//
//  Created by CS121 on 9/12/13.
//  Copyright (c) 2013 Matt Cook. All rights reserved.
//

#import "InputPanel.h"

@implementation InputPanel

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        
        int dimensionX = self.bounds.size.width * 0.1;
        // y origin will remain the same throughout the panel
        int originY = self.bounds.size.height * 0.1;
        
        // Create the input panel
        for (int i =0; i < 10; i++) {
            
            int originX = 0.01 * self.bounds.size.width + (i * dimensionX);
            int size = self.bounds.size.width * 0.09;
            CGRect buttonFrame = CGRectMake(originX, originY, size, size);
            
            // Create the input panel button
            UIButton* theButton = [[UIButton alloc] initWithFrame:buttonFrame];
            theButton.backgroundColor = [UIColor whiteColor];
            [theButton setTag:false];
            [theButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview: theButton];
            [self.inputButtons addObject: theButton];
        }
        
        
        
    }
    return self;
}

-(NSMutableArray*) inputButtons {
    if (!_inputButtons){
        _inputButtons = [[NSMutableArray alloc] init];
    }
    return _inputButtons;
}

// Set a given button's background to yellow
-(void) setHighlightAll: (UIButton*) highlightedButton {
    
    for (int i = 0; i < 10; i++) {
        UIButton* button = _inputButtons[i];
        button.backgroundColor = [UIColor whiteColor];
    }
    highlightedButton.backgroundColor = [UIColor yellowColor];
}

// action and output for pressing a button on the grid
-(void) buttonPressed: (id) sender {
    
    [self setHighlightAll: sender];

    [self.delegate inputButtonPressed:[[sender currentTitle] intValue]];
    
}



@end
