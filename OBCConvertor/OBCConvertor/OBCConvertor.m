//
//  OBCConvertor.m
//
//  Created by Bill Cheng on 11/1/13.
//  Copyright 2013 R3 Studio. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "OBCConvertor.h"

static OBCConvertor * instance=nil;

@implementation OBCConvertor

+ (OBCConvertor*)getInstance
{
    @synchronized(self) {
        if (instance==nil) {
            instance=[[OBCConvertor alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialize self.
        // Read code table from ts.tab file
        NSString *filrPath = [[NSBundle mainBundle] pathForResource:@"ts.tab" ofType:nil];
        NSString *data = [NSString stringWithContentsOfFile:filrPath encoding:NSUTF8StringEncoding error:NULL];
        
        // Change the NSString to Char
        NSMutableArray *chars = [[NSMutableArray alloc] initWithCapacity:[data length]];
        for (int i=0; i < [data length]; i++) {
            NSString *ichar  = [NSString stringWithFormat:@"%C", [data characterAtIndex:i]];
            [chars addObject:ichar];
        }
        
        ts = [NSMutableDictionary new];
        st = [NSMutableDictionary new];
        
        for (int i = 0; i < [chars count] ; i = i + 2){
            NSString *one = [chars objectAtIndex:i];
            NSString *two = [chars objectAtIndex:(i + 1)];
            [st setObject:one forKey:two];
            [ts setObject:two forKey:one];
        }
    }
    return self;
}

- (NSString*)t2s:(NSString*)string;
{
    NSString *result = @"";
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[string length]];
    for (int i=0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%C", [string characterAtIndex:i]];
        [tmpArray addObject:ichar];
    }
    for (NSString *s in tmpArray){
        if ([ts objectForKey:s]){
            result = [NSString stringWithFormat:@"%@%@", result, [ts objectForKey:s]];
        } else {
            result = [NSString stringWithFormat:@"%@%@", result, s];
        }
    }
    return result;
}

- (NSString*)s2t:(NSString*)string
{
    NSString *result = @"";
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[string length]];
    for (int i=0; i < [string length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%C", [string characterAtIndex:i]];
        [tmpArray addObject:ichar];
    }
    for (NSString *s in tmpArray){
        if ([st objectForKey:s]){
            result = [NSString stringWithFormat:@"%@%@", result, [st objectForKey:s]];
        } else {
            result = [NSString stringWithFormat:@"%@%@", result, s];
        }
    }
    return result;
}

@end
