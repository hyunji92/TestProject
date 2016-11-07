//
//  TestTableViewCell.h
//  TestProject
//
//  Created by Infobank_mac on 10/25/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestTableViewCellDelegate <NSObject>

-(void) selectedIndexPath:(NSIndexPath *)path;

@end

@interface TestTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *cellLable;
@property (strong, nonatomic) IBOutlet UILabel *cellLable2;
@property (strong, nonatomic) IBOutlet UIButton *editButton;

@property (strong, nonatomic) NSIndexPath *path;

@property (weak, nonatomic) id<TestTableViewCellDelegate> celldelegate;

@end
