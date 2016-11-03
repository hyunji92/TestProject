//
//  Tab4CollectionViewCell.h
//  TestProject
//
//  Created by 정현지 on 2016. 11. 3..
//  Copyright © 2016년 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestCollectionDelegate <NSObject>

- (void)  selectedCellpath:(NSIndexPath *)cellPath;

@end

@interface Tab4CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
