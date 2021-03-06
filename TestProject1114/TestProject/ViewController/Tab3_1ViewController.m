//
//  Tab3_1ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/26/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab3_1ViewController.h"
#import "TestDBManager.h"
#import "NSString+addition.h"

@interface Tab3_1ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate> {

    TestType testtype;
    NSDictionary *dic;
    
    TestDBManager *dbTestManager;
    UIImage *img;
}
@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (strong, nonatomic) IBOutlet UITextField *titleTextFiled;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;
@property (strong, nonatomic) IBOutlet UIView *buttonBGview;


@end


@implementation Tab3_1ViewController

- (id)initWithTestType:(TestType)TestType item:(NSDictionary *)item{
    self = [super init]; //넘어 온것 세팅
    if(self){
        testtype = TestType;
        dic = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeNavigationButton];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillShowNotification object:nil];
    
    dbTestManager = [TestDBManager sharedDBManager];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    switch (testtype) {
        case TestType_New:
            self.title = @"일기작성";
            break;
        case TestType_Detail:
            self.title = @"상세보기";
            [_titleTextFiled setEnabled:NO];
            [_textview setEditable:NO];
            _buttonBGview.hidden = YES;
            break;
        case TestType_Update:
            self.title = @"편집하기";
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)saveText:(id)sender{
    NSLog(@" text를 저장해보려고 합니다만...");
    [_delegate testTextFiled:@"확인 화면을 만들어 봅니다."];
    NSString *title = _titleTextFiled.text;
    NSString *text = _textview.text;
    
    // UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"test%02ld.jpg",(long)i]];
    if(title == nil || [title isEmpty]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"경고" message:@"타이틀을 입력해 주세요." delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alert show];
        return;
    }else if(text == nil || [text isEmpty]){
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"경고" message:@"내용을 입력해 주세요" delegate:nil cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alert2 show];
        return;
    }
    if(testtype == TestType_New){
        [dbTestManager insertTest:title context:text image:img date:[NSDate new]];
    }else if(testtype == TestType_Update){
        [dbTestManager updateWhtiIdx:[dic objectForKey:@"idx"] str:title context:text image:img date:[NSDate new]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) makeNavigationButton{
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setTitle:@" clear " forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchUpInside ];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:rightButton]];
}
- (void) clearText:(UIButton *)sender{
    NSLog(@"click Clear Button !!! ");
}

- (IBAction)clickImageButton:(id)sender{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker setAllowsEditing:YES];
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@" TEST ! IMAGE");
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editingImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    img = editingImage;
    
    [_imageButton setBackgroundImage:editingImage forState:UIControlStateNormal];
    
}

-(void) keyboard:(NSNotification *)notification{
    
    CGRect keyBoardRect;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyBoardRect];
    
    
    [UIView animateWithDuration:0.4f animations:^{
        
        if([notification.name isEqualToString:UIKeyboardDidHideNotification]){
            
            NSLog(@"UIKeyboardDidHideNotification ! ");
            
        }else if ([notification.name isEqualToString:UIKeyboardDidShowNotification]){
            NSLog(@"UIKeyboardDidShowNotification ! ");
            
        }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]){
            
            _bottomConst.constant = 0;
            NSLog(@"UIKeyboardWillHideNotification ! ");
            
        }else if ([notification.name isEqualToString:UIKeyboardWillShowNotification]){
            
            _bottomConst.constant = keyBoardRect.size.height - self.tabBarController.tabBar.frame.size.height;
            NSLog(@"UIKeyboardWillShowNotification ! ");
            
        }

    }];
    
    
    
}
-(IBAction)dismissKeyboard:(id)sender{
    [_titleTextFiled resignFirstResponder];
    [_textview resignFirstResponder]; //키보드 위에 포커스를 뺀다 .
    
}


@end
