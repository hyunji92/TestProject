//
//  Tab4ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab4ViewController.h"

@interface Tab4ViewController (){
    NSInteger currentTag;
    IBOutlet UILabel *test4;
}

@end

@implementation Tab4ViewController

- (id)initWithTag:(NSInteger) tag{
    self =  [super init];
    if(self){
        currentTag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    test4.text = [NSString stringWithFormat:@"%ld",(long)currentTag];
    
    self.view.backgroundColor = [UIColor magentaColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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