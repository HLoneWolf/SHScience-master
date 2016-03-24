//
//  NKContainerCellTableViewCell.m
//  ImageGrid
//
//  Created by Nikunj Modi on 9/21/15.
//  Copyright (c) 2015 Nikunj Modi. All rights reserved.
//

#import "NKContainerCellTableViewCell.h"
#import "NkContainerCellView.h"
@interface NKContainerCellTableViewCell ()
@property (strong, nonatomic) NkContainerCellView *collectionView;
@end
@implementation NKContainerCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 200, 40)];
//        imageView.image = [UIImage imageNamed:@"zq_fav"];
        _collectionView = [[NSBundle mainBundle] loadNibNamed:@"NKContainerCellView" owner:self options:nil][0];
        _collectionView.frame = self.bounds;
        [self.contentView addSubview:_collectionView];
//        [self.contentView addSubview:imageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setCollectionData:(NSArray *)collectionData {
    [_collectionView setCollectionData:collectionData];
}

- (void)setCollectionData:(NSArray *)collectionData ImageName:(NSString *) titleImageName{
    [_collectionView setCollectionData:collectionData];
    [_collectionView setTitleImageName:titleImageName];
}

@end
