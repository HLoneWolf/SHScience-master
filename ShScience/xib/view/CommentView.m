//
//  CommentView.m
//  ShScience
//
//  Created by qiya on 16/3/23第13周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "CommentView.h"
#import "QyUtils.h"

@implementation CommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{
    _commentTableView.delegate = self;
    _commentTableView.dataSource = self;
    _commentTableView.backgroundColor = [UIColor clearColor];
    _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 表格的delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;

        cell1 = [self buildZhanXiangHuDongCell:tableView cellForRowAtIndexPath:indexPath];//setup 兴趣小组的单元格

    
    [cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}

#pragma mark - 绘制单元格
- (UITableViewCell *)buildZhanXiangHuDongCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell1;
    if (cell1 == nil){
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, ScreenWitdh, 215)
                                       reuseIdentifier:@"CommentListTableCell"];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentListTableCell" owner:nil options:nil];
    //第一个对象就是CustomCell了
    cell1 = [nib objectAtIndex:0];
    
    return cell1;
}
@end
