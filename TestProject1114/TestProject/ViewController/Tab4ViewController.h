//
//  Tab4ViewController.h
//  TestProject
//
//  Created by Infobank_mac on 10/20/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tab4ViewController : UIViewController

@property (strong, nonatomic, readonly) NSString *string;
@property NSInteger integer; // (weak, nonatomic)
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

- (id)initWithTag:(NSInteger) tag;

@end
