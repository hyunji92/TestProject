//
//  Tab4CollectionViewCell.h
//  TestProject
//
//  Created by Infobank_mac on 11/4/16.
//  Copyright © 2016 Infobank_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TestCollectionCellDelegate <NSObject>

-(void) selectedCellpath:(NSIndexPath *)path;

@end

@interface Tab4CollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) NSIndexPath *path;

@property (weak, nonatomic) id<TestCollectionCellDelegate>collectiondelegate;

@end
