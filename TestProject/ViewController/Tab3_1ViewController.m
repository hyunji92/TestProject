//
//  Tab3_1ViewController.m
//  TestProject
//
//  Created by Infobank_mac on 10/26/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "Tab3_1ViewController.h"

@interface Tab3_1ViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) IBOutlet UITextView *textview;
@property (strong, nonatomic) IBOutlet UITextField *titleTextFiled;

@end

@implementation Tab3_1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeNavigationButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)saveText:(id)sender{
    NSLog(@" text를 저장해보려고 합니다만...");
    [_delegate testTextFiled:@"확인 화면을 만들어 봅니다."];
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
    
    
    [_imageButton setBackgroundImage:editingImage forState:UIControlStateNormal];
    
}

-(void) keyboard:(NSNotification *)notification{
    if([notification.name isEqualToString:UIKeyboardDidHideNotification]){
        NSLog(@"UIKeyboardDidHideNotification ! ");
        
    }else if ([notification.name isEqualToString:UIKeyboardDidShowNotification]){
        NSLog(@"UIKeyboardDidShowNotification ! ");
        
    }else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]){
        NSLog(@"UIKeyboardWillHideNotification ! ");
        
    }else if ([notification.name isEqualToString:UIKeyboardWillShowNotification]){
        NSLog(@"UIKeyboardWillShowNotification ! ");
        
    }
   
}
-(IBAction)dismissKeyboard:(id)sender{
    [_titleTextFiled resignFirstResponder];
    [_textview resignFirstResponder]; //키보드 위에 포커스를 뺀다 .
    
}


@end
