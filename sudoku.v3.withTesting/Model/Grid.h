//
//  Grid.h
//  Sudoku28.v1
//
//  Created by CS121 on 9/12/13.
//  Copyright (c) 2013 Matt Cook. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridDelegate <NSObject>

-(void)gridButtonPressed:(int)buttonNumber;

@end

@interface Grid : UIView

@property (nonatomic, strong) NSMutableArray* gridButtons;
@property (nonatomic, strong) id <GridDelegate> delegate;

- (void) buttonPressed: (id) sender;

- (void) setValue:(int) contents atIndex: (int) index;

- (int) getValue:(int) index;

- (BOOL) checkConsistency:(int)value AtIndex:(int)index;

- (void) setErrorLabel: (NSString*)inputString;
@end
