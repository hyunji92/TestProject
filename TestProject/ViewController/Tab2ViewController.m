//
//  Tab2ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab2ViewController.h"
#import "Tab2_1ViewController.h"

@interface Tab2ViewController ()<testDelegate>{
    NSInteger currentTag;
    IBOutlet UILabel *test2;
    
    IBOutlet UIButton *button1;
    IBOutlet UIButton *button2;
    IBOutlet UIButton *button3;
    
    UIButton *button4;
    

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

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGRect rect = button1.frame;
    NSLog(@"rect >>>> : %f %f %f %f  ", rect.origin.x, rect.origin.y , rect.size.width, rect.size.height);
    rect.origin.y += rect.size.height * 2;
    
    button4 = [[UIButton alloc] initWithFrame:rect];
    
    [button4 setTitle:@"Button4" forState:UIControlStateNormal];
    [self.view addSubview:button4];
    [button4 addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
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
    }else if(btn ==  button4){
        NSLog(@"button4");
    }
    
}

- (IBAction)changeValue:(UISlider*)sender{
    
    NSLog(@"change slider value %f" ,sender.value );
    
}

- (IBAction)clickSwitch:(UISwitch*)sender{
    NSLog(@"change switch %@ " , sender.isOn?@"Yes":@"NO");
}

- (IBAction)pushAction:(id)sender{
    // 네비게이션에 히스토리가 쌓인다.
    Tab2_1ViewController *tab2_1ViewController = [[Tab2_1ViewController alloc] init];
    tab2_1ViewController.delegate = self;
    
    [self.navigationController pushViewController:tab2_1ViewController animated:YES];
    
    
}

- (IBAction)modalAction:(id)sender{
    // 네비게이션 컨드롤러가 쌓이지 않는다.
    // rootviewcontroller위에 viewController가 하나 올라간다.
    
    Tab2_1ViewController *tab2_1ViewController = [[Tab2_1ViewController alloc] init];
    tab2_1ViewController.delegate = self;
    
    [self presentViewController:tab2_1ViewController animated:YES completion:nil];
    
    
}


#pragma mark ===== Test Delegate 

-(void) testPush:(NSString *)value{
    NSLog(@"test push %@" ,  value);
}
-(void) testModal:(NSInteger)value{
    NSLog(@"test modal %ld" ,  (long)value);
}

@end
