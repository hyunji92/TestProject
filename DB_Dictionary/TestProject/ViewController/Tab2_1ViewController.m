//
//  Tab2_1ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/25/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab2_1ViewController.h"

@interface Tab2_1ViewController ()

@end

@implementation Tab2_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushDismiss:(id)sender{
    NSLog(@"pushDismiss");
    [_delegate testPush:@"푸시 테스트 합니다"];
    
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    //[self.navigationController viewControllers];
//    for (UIViewController *viewController in [self.navigationController viewControllers]) {
//        if(viewController isKindOfClass:)
//    }
//    [self.navigationController popToViewController:nil animated:YES];
    
}

- (IBAction)modalDismiss:(id)sender{
    NSLog(@"modalDismiss");
    [_delegate testModal:23423423];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}


@end
