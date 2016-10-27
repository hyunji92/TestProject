//
//  TestTableViewCell.m
//  TestProject
//
//  Created by Infobank_mac on 10/25/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import "TestTableViewCell.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)clickEditButton :(id)sender{
    if(_delegate){
        [_delegate selectedIndexPath:_path];
        
    }
}
@end
