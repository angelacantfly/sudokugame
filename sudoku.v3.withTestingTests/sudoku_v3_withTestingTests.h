//
//  sudoku_v3_withTestingTests.h
//  sudoku.v3.withTestingTests
//
//  Created by Angela Zhou on 9/20/13.
//  Copyright (c) 2013 Angela Zhou. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Grid.h"
#import "InputPanel.h"
#import "SudokuModel.h"

@interface sudoku_v3_withTestingTests : SenTestCase
{
    Grid* testGrid;
    InputPanel* testPanel;
    SudokuModel* testModel;
}


-(void)testModelOutOfRangeForGet;
-(void)testGridSetAndGet;
-(void)testGridOutOfRangeForGet;
-(void)testGridOutOfRangeForSet;
-(void)testGridNotNegValueForSet;
-(void)testCheckConsistencyOutOfRange;
-(void)testCheckConsistencyNonStandardInput;
-(void)testInputButton;
-(void)testGridButton;
-(void)testReadData;




@end
