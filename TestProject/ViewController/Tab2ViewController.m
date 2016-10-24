//
//  Tab2ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab2ViewController.h"

@interface Tab2ViewController (){
    NSInteger currentTag;
    IBOutlet UILabel *test2;
    
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
    

}

@end

@implementation Tab2ViewController

- (id)initWithTag:(NSInteger) tag{
    self =  [super init];
    if(self){
        currentTag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    test2.text = [NSString stringWithFormat:@"%ld",(long)currentTag];
   

    self.view.backgroundColor = [UIColor lightGrayColor];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)clickButton:(id)sender{
    
    UIButton *btn =(UIButton *)sender;
    NSLog(@"click!!!!  TAG  :  %ld" , (long)btn.tag);
    
    if (btn == button1) {
        NSLog(@"button1");
    }else if (btn == button2){
        NSLog(@"button2");
    }else if (btn == button3){
        NSLog(@"button3");
    }
    
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
