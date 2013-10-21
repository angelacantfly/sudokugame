//
//  SudokuModel.h
//  Sudoku28.v1
//
//  Created by CS121 on 9/12/13.
//  Copyright (c) 2013 Matt Cook. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SudokuModel : NSObject
{
    // NSMutableArray to store the values in the Sudoku grid
    NSMutableArray* theData;
    // Seed value to know where to start reading the Sudoku values
    int randomSeed;
}

// Returns the value at the specified index
-(int) getValueAt: (NSInteger)index;


// Read data from specified file
- (void) readData: (NSString*)file;

@end
