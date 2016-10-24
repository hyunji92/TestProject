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
//        case 1:
//            self.view.backgroundColor = [UIColor yellowColor];
//            break;
//        case 2:
//            self.view.backgroundColor = [UIColor blueColor];
//            break;
//        case 3:
//            self.view.backgroundColor = [UIColor magentaColor];
//            break;
//            
        default:
            break;
    }
    
    [self stringTest];
    [self arrayTest];
    [self dictionaryTest];
    
    
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

- (void) stringTest {
    
    NSString *str = @"1,2,3,4,5,6,7,8,9,10";
    
    NSString *temp1 = [str substringFromIndex:4];
    NSLog(@"temp1 %@",temp1);
    
    NSString *temp2 = [str substringToIndex:4];
    NSLog(@"temp2 %@",temp2);
    
    NSString *temp3 = [str substringWithRange:NSMakeRange(8, 1)];
    NSLog(@"temp3 %@",temp3);
    
    NSInteger temp3_1 = [temp3 integerValue];
    NSLog(@"temp3_1  %ld",(long)temp3_1);
    
    NSInteger temp3_2 = [temp3 floatValue];
    NSLog(@"temp3_2  %f",(float)temp3_2);
    
    NSInteger temp3_3 = [temp3 longLongValue];
    NSLog(@"temp3_3  %ld",temp3_3);
    
    NSString *temp4 = [str stringByReplacingOccurrencesOfString:@"," withString:@"/"];
    NSLog(@"temp4 %@", temp4);
    
    NSArray *temp5 = [temp4 componentsSeparatedByString:@"/"];
    NSLog(@"temp5 : %@", temp5);
    
    if([str isEqualToString:@"1,2,3,4,5,6,7,8,9,10"]){
        NSLog(@"같다");
    }
    
    if([str hasPrefix:@"1"]){
        NSLog(@"앞이 같다");
    }
    
    if([str hasSuffix:@"10"]){
        NSLog(@"뒤가 같다");
    }
    
    if([str containsString:@"5"]){
        NSLog(@"5가 포함되어있다.");
    }
    
    int sum = 0;
    for (int i =0; i < [temp5 count]; i++) {
        
        sum += [[temp5 objectAtIndex:i] integerValue];
        
    }
    NSLog(@"array test :  %d" , sum);
    
    
    // MutableString
    
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString appendString:@"정"];
    [mutableString appendString:@"현"];
    [mutableString appendString:@"지"];

    
}

- (void) arrayTest{
    //NSArray * array = @[@"1",@2,@"3",@4,@"5",@6,@"7",@8,@"9",@10];
    NSArray *array= [[NSArray alloc] initWithObjects:@"1",[NSNumber numberWithInteger:2],@"3",[NSNumber numberWithInteger:4],@"5",[NSNumber numberWithInteger:6],@"7",
                     [NSNumber numberWithInteger:8],@"9",[NSNumber numberWithInteger:10], nil]; // array 기본 형식.
    
    for (int i = 0; i < array.count; i++) {
        //NSLog(@"Array Test  %d :  >>>> %@", i, array[i]);
        NSObject *object = [array objectAtIndex:i];
        NSLog(@"Array Object 11:  >>>> %@", object);
        
    }
    
    for (NSObject *object in array) {
        if([object isKindOfClass:[NSNumber class]]){
            NSLog(@"NSObject Test >>> : %@" , object);
        }
    }
    
    if([array containsObject:@"1"]){
        NSLog(@" 1이 포함되어져있음 ");
    }
    
    NSLog(@"Array Count >>> : %lu " , (unsigned long)array.count);
    NSLog(@"Array Last Object >>> : %@", [array lastObject] );
    
    
    // Mutalble Array
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    
    for (int i =0; i <10 ; i++) {
        
        [mutableArray addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        NSLog(@"Mutable Array TEST >>> : %@ ", [mutableArray objectAtIndex:i]);
    }
    [mutableArray removeObjectAtIndex:3];
    [mutableArray insertObject:@"new >>> 3" atIndex:3];
    NSLog(@"Check Mutable Array >>>  %@ " , [mutableArray objectAtIndex:3]);
    
}

- (void) dictionaryTest{
//    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                @"test1",@"key1"
//                                @"test2",@"key2"
//                                @"test3",@"key3"
//                                @"test4",@"key4"
//                                @"test5",@"key5", nil];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:@[@"test1",@"test2",@"test3"] forKeys:@[@"key1",@"key2",@"key3"]];
    NSLog(@"Dictionary Test : %@ " , [dictionary objectForKey:@"key2"]);
    
    if([[dictionary allKeys] containsObject:@"key3"]){
        NSLog(@"Dictionary Key3값이 있음  >> : %@" ,[dictionary objectForKey:@"key3"]);
    }
    
    
    // Mutable Dictionary
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    
    for (int j =0; j < 10; j++) {
        [mutableDictionary setObject:[NSString stringWithFormat:@"내용 %ld",(long)j] forKey:[NSString stringWithFormat:@"k%ld",(long)j]];
        NSLog(@"Check Mutable Dictionary >>>> :  %@ ", [mutableDictionary objectForKey:[NSString stringWithFormat:@"k%ld",(long)j]]);
    }
    
    
}

@end
