//
//  HjData.h
//  TestProject
//
//  Created by Infobank_mac on 10/31/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DictionaryObject.h"

@interface HjData : DictionaryObject 

@property (strong, nonatomic) NSNumber *idx;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *context;
@property (strong, nonatomic) NSData *img;
@property (strong, nonatomic) NSDate *date;



@end
