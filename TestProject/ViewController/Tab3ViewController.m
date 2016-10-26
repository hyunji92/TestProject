//
//  Tab3ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab3ViewController.h"
#import "TestTableViewCell.h"
#import "Tab3_1ViewController.h"

@interface Tab3ViewController ()< testDelegate2,UITableViewDelegate, UITableViewDataSource>{
    NSInteger currentTag;
    
    IBOutlet UITableView *mainTableView;
    
    UIButton *button;
    
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
    
    [self makeDummyData];
    [self makeNavigationButton];
    
    

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
    
    [mainTableView reloadData];
}

- (void) makeNavigationButton{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setTitle:@" + " forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside ];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightButton]];
}
- (void) clickAddButton:(UIButton *)sender{
    NSLog(@"click Add Button !!! ");
    Tab3_1ViewController *tab3_1ViewController = [[Tab3_1ViewController alloc] init];
    tab3_1ViewController.delegate = self;
    
    [self.navigationController pushViewController:tab3_1ViewController animated:YES];
    
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
    cell.imgView.clipsToBounds = YES; // imageview 특정 속성
    cell.imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.imgView.layer.borderWidth = 2;
    cell.imgView.layer.cornerRadius = 25; // 모든 view를 깎을 수 있음. (view 안에 layer속성이 있고 그 layer를 깎는것! )
    
    
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

#pragma mark ===== Test Delegate 2

-(void) testTextFiled:(NSString *)value{
    
    
}


@end
