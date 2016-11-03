//
//  Tab4ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab4ViewController.h"
#import "NSString+addition.h"
#import "Tab4CollectionViewCell.h"
#import "TestDBManager.h"

@interface Tab4ViewController ()<TestCollectionDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
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
    
    self.view.backgroundColor = [UIColor lightTextColor];
    
    [self testUserDefault];
    [self testCategory];
    [self testLocalization];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) testUserDefault {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:@"object" forKey:@"key1"];
    [userDefault setBool:YES forKey:@"key2"];
    [userDefault setInteger:12345 forKey:@"key3"];
    
    [userDefault synchronize];
    
    NSString *str = [userDefault objectForKey:@"key1"];
    BOOL isYes = [userDefault boolForKey:@"key2"];
    NSInteger num = [userDefault integerForKey:@"key3"];
    
    NSLog(@"default string  %@ ", str);
    NSLog(@"default BOOL %@ ", isYes? @"YES":@"NO");
    NSLog(@"default Integer %ld ", num);
    
    // 앱이 삭제 되기 전까지 남아있는 정보
}

-(void) testCategory{
    NSString *value1 = @"";
    NSString *value2 = @" testetset";
    
    if ([value1 isEmpty]) {
        NSLog(@"category test empty");
    }
    
    if (!value2.isEmpty) {
        NSLog(@"Not empty");
    }
    
}

-(void)testLocalization{
    
    //test4.text = NSLocalizedString(@"Hello",nil );
    test4.text = NSLocalizedStringFromTable(@"Hello", @"localizaion", @"인삿말 입나다.");
    
}

-(void) selectedCellpath:(NSIndexPath *)cellPath{
    
}



@end
