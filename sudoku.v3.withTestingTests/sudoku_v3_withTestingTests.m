//
//  sudoku_v3_withTestingTests.m
//  sudoku.v3.withTestingTests
//
//  Created by Angela Zhou on 9/20/13.
//  Copyright (c) 2013 Angela Zhou. All rights reserved.
//

#import "sudoku_v3_withTestingTests.h"

@implementation sudoku_v3_withTestingTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    
    
    /*
     * CHECK IF WE NEED TO INITWITHFRAMEEEEEEEEE
     *
     *
     *
     *
     *
     *
     */
    testModel = [[SudokuModel alloc] init];
    testGrid = [[Grid alloc] init];
    testPanel = [[InputPanel alloc] init];
    
    // Test for each object initialization
    STAssertNotNil(testModel, @"Model is not created successfully.");
    STAssertNotNil(testGrid, @"Grid is not created successfully.");
    STAssertNotNil(testPanel, @"testPanel is not created successfully.");
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

// Test getValue in Grid: it should throw an exception when index is out of bound.
-(void)testModelOutOfRangeForGet {
    STAssertThrows([testModel getValueAt: 100], @"testModelOutOfRangeForGet");
}

// Test setValue and getValue in Grid: getValue should return the right value.
-(void)testGridSetAndGet {
    for (int i = 0; i < 81; i++) {
        [testGrid setValue:i+1 atIndex:i];
        STAssertEquals([testGrid getValue:i], i+1, @"get value %d, should be %d, but gets %d", i, i+1, [testGrid getValue:i]);
    }
}

// Test getValue in Grid: it should throw and exception when index is out of bound.
-(void)testGridOutOfRangeForGet {
    for (int i = 82; i < 181; i++)
    {
        STAssertThrows([testGrid getValue:i], @"testGridOutOfRangeForGet");
    }
}

// Test setValue in Grid: it should throw an exception when index is out of bound
-(void)testGridOutOfRangeForSet {
    for (int i = 82; i < 181; i++) {
        STAssertThrows([testGrid setValue:i atIndex:i], @"testGridOutOfRangeForGet");
    }
    
}

// Test setValue in Grid: it should throw an exception when index is negative
-(void)testGridNotNegValueForSet {
    for (int i = -1; i > -15; i--) {
        STAssertThrows([testGrid setValue:i atIndex:-i], @"testGridNotNegValueForSet");
    }
    
}

// Test CheckConsistency: it should throw an exception when index is out of range
-(void)testCheckConsistencyOutOfRange {
    for (int i = 81; i < 181; i++){
        STAssertThrows([testGrid checkConsistency:i-81 AtIndex:i], @"testCheckConsistency");
    }
    for (int i = -1; i > -81; i--) {
        STAssertThrows([testGrid checkConsistency:i-81 AtIndex:i], @"testCheckConsistency");
    }
}

// Test CheckConsistency: it should handle negative and large numbers as content.
-(void)testCheckConsistencyNonStandardInput {
    for (int i = -1; i > -80; i--) {
        STAssertNoThrow([testGrid checkConsistency:i AtIndex:-i], @"testCheckConsistencyNegInput");
    }
    
    for (int i = 100; i < 181; i++){
        STAssertNoThrow([testGrid checkConsistency:i AtIndex:i-100],@"testCheckConsistencyLargeInput");
    }
}

// Test InputButton initialization: the buttons should not be nil
-(void)testInputButton{
    STAssertNotNil([testPanel inputButtons], @"inputButtons are nil");
}

// Test GridButton initialization: the buttons should not be nil
-(void)testGridButton{
    STAssertNotNil([testGrid gridButtons], @"gridButtons are nil");
}


// Test ReadData method: it should throw an exception when the input file name is empty
-(void)testReadData{
    STAssertThrows([testModel readData:@""], @"testReadData.");
}

@end
