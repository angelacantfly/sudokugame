//
//  SudokuModel.m
//  Sudoku28.v1
//
//  Created by CS121 on 9/12/13.
//  Copyright (c) 2013 Matt Cook. All rights reserved.
//

#import "SudokuModel.h"

@implementation SudokuModel

-(id) init {
    self = [super init];
    if (self) {
        
        theData = [[NSMutableArray alloc] init];
        NSAssert(theData != NULL, @"theData is null");
        
        int random = arc4random();
        NSLog(@"random number generated is %d", random);
        randomSeed = arc4random() % 30000;
        
        //NSLog(@"theData after initialization is %@", theData);
        [self readData:@"sudokus0"];
        
    }
    return self;
}

-(int) getValueAt: (NSInteger)index {
    NSAssert(index >= 0 && index < [theData count], @"Model getValueAt called with value %d is out of range of [0, %d]", index, (int)[theData count]);
    NSNumber* value = theData[index];
    return [value intValue];
}



- (void) readData:(NSString *)file
{
    NSAssert([file length] > 0, @"file name length is 0.");
    NSString* path = [[NSBundle mainBundle] pathForResource:file ofType: @"txt"];
    NSError* error;
    
    NSString* readString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    
    for (int i=(randomSeed*81) + randomSeed; i < (randomSeed*81)+81 + randomSeed; i++){
        NSString *ichar  = [NSString stringWithFormat:@"%c", [readString characterAtIndex:i]];
        
        if ([ichar isEqual: @"."]){
            ichar = @"0";
        }
        
        int ivalue = [ichar intValue];
        NSNumber* ivalue2 = [NSNumber numberWithInt:ivalue];
        [theData addObject:ivalue2];
        
    }
}
@end
