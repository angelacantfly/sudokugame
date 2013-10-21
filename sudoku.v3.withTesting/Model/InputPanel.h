//
//  InputPanel.h
//  Sudoku28.v1
//
//  Created by CS121 on 9/12/13.
//  Copyright (c) 2013 Matt Cook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputPanelDelegate <NSObject>

-(void)inputButtonPressed:(int)buttonNumber;

@end

@interface InputPanel : UIView

@property (nonatomic, strong) NSMutableArray* inputButtons;
@property (nonatomic, strong) id <InputPanelDelegate> delegate;

-(void) setHighlightAll: (UIButton*) highlightedButton;

@end
