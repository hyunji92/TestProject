//
//  Tab3_1ViewController.h
//  TestProject
//
//  Created by Infobank_mac on 10/26/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TestType_New,
    TestType_Update,
    TestType_Detail
}TestType;

@protocol testDelegate2 <NSObject>

-(void) testTextFiled:(NSString *)value;

@end

@interface Tab3_1ViewController : UIViewController

@property (weak, nonatomic) id<testDelegate2> delegate;

- (id)initWithTestType:(TestType)TestType item:(NSDictionary *)item;
- (id)initWithTestType:(TestType)TestType HjData:(HjData *)data;


@end
