//
//  Tab3_1ViewController.h
//  TestProject
//
//  Created by Infobank_mac on 10/26/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol testDelegate2 <NSObject>

-(void) testTextFiled:(NSString *)value;

@end

@interface Tab3_1ViewController : UIViewController

@property (weak, nonatomic) id<testDelegate2> delegate;

@end
