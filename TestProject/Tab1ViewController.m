//
//  Tab1ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab1ViewController.h"

@interface Tab1ViewController (){
    NSInteger currentTag;
    IBOutlet UILabel *test;
}

@end

@implementation Tab1ViewController

- (id)initWithTag:(NSInteger) tag{
    self =  [super init];
    if(self){
        currentTag = tag;
    }
    return self;
}

#pragma mark ===============  viewlifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad:  >>> 뷰가 그려지기 직전 다 로드되었을 때");
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    test.text = [NSString stringWithFormat:@"%ld",(long)currentTag];
    switch (currentTag) {
        case 0:
            self.view.backgroundColor = [UIColor grayColor];
            break;
        case 1:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor blueColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor magentaColor];
            break;
            
        default:
            break;
    }
    
    NSLog(@"viewWillAppear:  >>> 뷰가 나타나기 바로 직전 ");
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear:  >>> 뷰가 다 나타남 ");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear:  >>> 뷰가 모두 사라졌을 때 ");
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear:  >>> 뷰가 사라지기 직전 ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning:  >>> 메모리 warnning");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
