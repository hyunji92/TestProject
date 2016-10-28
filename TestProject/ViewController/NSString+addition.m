//
//  NSString+addition.m
//  TestProject
//
//  Created by Infobank_mac on 10/28/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "NSString+addition.h"

@implementation NSString (addition)

-(BOOL) isEmpty{
    if (self == nil || [self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


-(BOOL) isNumber{
//    @try {
//        [self integerValue];
//    } @catch (NSException *exception) {
//        return NO;
//    } @finally {
//        
//    }
//    return YES;
    
    const char *test = (const char *)[self UTF8String];
    for (int i =0; i < strlen(test); i++) {
        if(test[i] < '0' || test[i] > '9'){
            return NO;
        }
    }
    return YES;
}


-(void) testtrim{
    
    [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}


@end
