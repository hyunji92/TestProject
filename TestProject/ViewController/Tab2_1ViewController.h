//
//  Tab2_1ViewController.h
//  TestProject
//
//  Created by Infobank_mac on 10/25/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol testDelegate <NSObject>
// class간의 통신규약 , 일정한 메소드를 통하여 클래스 간에 통신을 할 수 있는 통로를 제공한다.
//@optional

-(void) testPush:(NSString *)value;
-(void) testModal:(NSInteger)value;

@end
@interface Tab2_1ViewController : UIViewController

@property (weak, nonatomic) id<testDelegate> delegate;

@end
