//
//  NKContainerCellTableViewCell.h
//  ImageGrid
//
//  Created by Nikunj Modi on 9/21/15.
//  Copyright (c) 2015 Nikunj Modi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NKContainerCellTableViewCell : UITableViewCell
- (void)setCollectionData:(NSArray *)collectionData;

- (void)setCollectionData:(NSArray *)collectionData ImageName:(NSString *) titleImageName;
@end
