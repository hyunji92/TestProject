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
#import "TestDBManager.h"

@interface Tab3ViewController ()< testDelegate2,UITableViewDelegate, UITableViewDataSource ,TestTableViewCellDelegate>{
    IBOutlet UITableView *mainTableView;
    NSInteger currentTag;
    UIButton *button;
    
    TestDBManager *dbTestManager;
    
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
    
    // [self makeDummyData];
    [self makeNavigationButton];
    
    dbTestManager = [TestDBManager sharedDBManager];
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 여기서 로딩바를 돌리고
    dispatch_async(dispatch_get_global_queue(0, 0), ^{ // 데이타 처리할때 쓰는 쓰레드 백그라운드에서 도는 스레드
        self.items = [dbTestManager selectAllListWithHjData];
        dispatch_async(dispatch_get_main_queue(), ^{ // 위에 스레드 끝나면 UI갱신시 사용
            [mainTableView reloadData]; //db에있는 data한번 가져옴.
            //이 안에서 로딩바를 끝내면 된다.
        });
    });
    
    
    
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
    Tab3_1ViewController *tab3_1ViewController = [[Tab3_1ViewController alloc] initWithTestType:TestType_New item:nil];
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
    cell.celldelegate = self;
    cell.path = indexPath;
    cell.imgView.clipsToBounds = YES; // imageview 특정 속성
    cell.imgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.imgView.layer.borderWidth = 2;
    cell.imgView.layer.cornerRadius = 25; // 모든 view를 깎을 수 있음. (view 안에 layer속성이 있고 그 layer를 깎는것! )
    
    
    HjData *data =  [self.items objectAtIndex:indexPath.row];
    
    cell.cellLable.text = data.title;
    cell.cellLable2.text = data.context;
    UIImage *image = [UIImage imageWithData:data.img];
    cell.imgView.image = image;


    return cell;
}

// 삭제에 필요한 함수들
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //삭제버튼 누른 다음 , 여기서 삭제 처리
    //[dbTestManager insertObject:currentData];
    HjData *data = [self.items objectAtIndex:indexPath.row];

    BOOL isSuccess = [dbTestManager deleteWithHjData:data];
    if (!isSuccess) {
        return;
    }
    [_items removeObjectAtIndex:indexPath.row];

    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [tableView endUpdates];
    
    //[_items addObject:data];
    //[tableView beginUpdates];
    //[tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //[tableView endUpdates];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    // 편집 가능 여부
    if (indexPath.row < 0) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark === Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    lable.text = @" section text ";
    
    return lable;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Table Index path row : %ld" , indexPath.row);
    
    HjData *data = [self.items objectAtIndex:indexPath.row];
    
    Tab3_1ViewController *tab3_1ViewController = [[Tab3_1ViewController alloc] initWithTestType:TestType_Detail HjData:data];
    tab3_1ViewController.delegate = self;
    
    [self.navigationController pushViewController:tab3_1ViewController animated:YES];
    
    
}

#pragma mark ===== Test Delegate 2

-(void) testTextFiled:(NSString *)value{
    
    
}

-(void) selectedIndexPath:(NSIndexPath *)path{
    
    HjData *data = [self.items objectAtIndex:path.row];
    Tab3_1ViewController *tab3_1ViewController = [[Tab3_1ViewController alloc] initWithTestType:TestType_Update HjData:data];
    tab3_1ViewController.delegate = self;
    
    [self.navigationController pushViewController:tab3_1ViewController animated:YES];
    
    NSLog(@"편집 row %ld" , path.row);
}


@end
