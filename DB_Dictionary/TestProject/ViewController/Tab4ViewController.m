s//
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


@interface Tab4ViewController ()<TestCollectionCellDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
    IBOutlet UICollectionView *mainCollectionView;
    NSInteger currentTag;
    IBOutlet UILabel *test4;
    
    TestDBManager *dbTestManager;
}

@property (strong, nonatomic) NSMutableArray *items;

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
    
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    [mainCollectionView registerNib:[UINib nibWithNibName:@"Tab4CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Tab4CollectionViewCell"];
    
    [self testUserDefault];
    [self testCategory];
    [self testLocalization];
    

    dbTestManager = [TestDBManager sharedDBManager];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.items = [dbTestManager selectAllList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainCollectionView reloadData]; //db에있는 data한번 가져옴.
        });
    });

    
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
#pragma mark - UICollectionViewDataSource
#pragma mark - UICollectionViewDelegate

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Tab4CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Tab4CollectionViewCell" forIndexPath:indexPath];

    cell.collectiondelegate = self;
    cell.path = indexPath;
    cell.imageview.clipsToBounds = YES;
    cell.imageview.layer.cornerRadius = 40;
    
    NSDictionary *dic = [self.items objectAtIndex:indexPath.row];
    
    cell.title.text = [dic objectForKey:@"title"];
    if ([dic objectForKey:@"img"] != nil) {
        cell.imageview.image = [UIImage imageWithData:[dic objectForKey:@"img"]];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
   
    return CGSizeMake(self.view.frame.size.width / 4, 80);
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    [cell setBackgroundColor:[UIColor clearColor]];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
}


-(void) selectedCellpath:(NSIndexPath *)path{
 
    
}

@end
