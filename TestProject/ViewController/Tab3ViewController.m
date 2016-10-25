//
//  Tab3ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab3ViewController.h"
#import "TestTableViewCell.h"

@interface Tab3ViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger currentTag;
    
    IBOutlet UITableView *mainTableView;
    
}

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation Tab3ViewController

- (id)initWithTag:(NSInteger) tag{
    self =  [super init];
    if(self){
        currentTag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //test3.text = [NSString stringWithFormat:@"%ld",(long)currentTag];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    mainTableView.delegate = self;
    mainTableView.dataSource = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) makeDummyData{
    self.items  = [[NSMutableArray alloc] init];
    for (int i =0 ; i < 20 ; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        NSString *title = [NSString stringWithFormat:@"타이틀 테스트 입니다  :  %d" , i];
        [dic setObject:title forKey:@"title"];
        [self.items addObject:dic];
    }
}

#pragma mark === Datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell =  [[UITableViewCell alloc]init];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    TestTableViewCell *cell = (TestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    if(cell == nil){
        NSArray *array  = [[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:self options:nil];
        
        cell = (TestTableViewCell *)[array lastObject];
    }
    
    NSDictionary *dic =  [self.items objectAtIndex:indexPath.row];
    
    cell.cellLable.text = [dic objectForKey:@"title"];
    return cell;
}



#pragma mark === Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    lable.text = @" section text ";
    
    return lable;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Table Index path row : %ld" , indexPath.row);
}




@end
