//
//  Tab2_1ViewController.h
//  TestProject
//
//  Created by Infobank_mac on 10/25/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol testDelegate <NSObject>
//@optional

-(void) testPush:(NSString *)value;
-(void) testModal:(NSInteger)value;

@end
@interface Tab2_1ViewController : UIViewController

@property (weak, nonatomic) id<testDelegate> delegate;

@end
