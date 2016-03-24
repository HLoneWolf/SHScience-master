//
//  HelpVC.m
//  ShScience
//
//  Created by qiya on 16/2/25第9周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "HelpVC.h"
#import "QyUtils.h"
#import "TTTAttributedLabel.h"
#import "QyDataManger.h"
#import "HelpItem.h"

@interface HelpVC ()

@end

@implementation HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBtnWithTitle:@"帮助"];
    
    _listTable = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, ScreenWitdh-20, ScreenHeight)];
    _listTable.dataSource = self;
    _listTable.delegate = self;
    _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _listTable.rowHeight = UITableViewAutomaticDimension;
    _listTable.estimatedRowHeight = 120.0; // set to whatever your "average" cell height is
    
    [_listTable setBackgroundColor:[UIColor clearColor]];
    //[_grayView addSubview:_listTable];
    [self.view addSubview:_listTable];
    [self requestAllQuestion];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 表格相关
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if(_helpList!=nil){
        return [_helpList count];
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell1;
    if (cell1 == nil){
        
        cell1 = [[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:@"radioListTableCell"];
    }
    
    CGFloat cellWidth = _listTable.frame.size.width;
    CGFloat cellHeight = 80;
    
    //HelpItem *helpItem = nil;
   if(indexPath.row %2== 0){
        
        if(_helpList!=nil&&[_helpList count]>0){
            _helpItem = _helpList[indexPath.section];
        }
        UIView *bgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cellWidth, 30)];
        [bgview setBackgroundColor:RGB(39, 127, 195)];
        [cell1 addSubview:bgview];
       
       UIImageView  *question = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
       question.image = [UIImage imageNamed:@"help_q"];
       [cell1 addSubview:question];
       
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10+20, 5, cellWidth, 20)];
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor whiteColor];
        label.text = @"上海科技馆的开发时间是?";
        if(_helpItem){
            label.text = _helpItem.question;
        }
        [cell1 addSubview:label];
        
    }
    else if(indexPath.row %2 == 1){
        TTTAttributedLabel *_detailDes = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _detailDes.font = [UIFont systemFontOfSize:17];
        //    _detailDes.textColor = [UIColor darkGrayColor];
        _detailDes.lineBreakMode = NSLineBreakByWordWrapping;
        _detailDes.numberOfLines = 0;
        
        UIImageView  *question = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
        question.image = [UIImage imageNamed:@"help_a"];
        [cell1 addSubview:question];
        
        //_detailDes.backgroundColor= [UIColor redColor];
        // If you're using a simple `NSString` for your text,
        // assign to the `text` property last so it can inherit other label properties.
        NSString *text = @"";
        if(_helpItem){
            text = _helpItem.answer;
        }
        
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:text
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)RGB(101, 100, 100).CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        _detailDes.text = attString;
        CGSize s =[TTTAttributedLabel sizeThatFitsAttributedString:attString withConstraints:CGSizeMake(ScreenWitdh-60, 1000) limitedToNumberOfLines:0];
        
        _detailDes.frame = CGRectMake(10+20, 10, s.width, s.height);
        // _detailDes.frame = CGRectMake(5, 5, cellWidth,120);
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(28, 160, ScreenWitdh-56, 310)];
        //[scrollView setBackgroundColor:[UIColor yellowColor]];
        scrollView.contentSize = _detailDes.frame.size;
        //[cell1 addSubview:scrollView];
        //[scrollView addSubview:_detailDes];
        [cell1 addSubview:_detailDes];
    }
    
    //[cell1 setBackgroundColor:[UIColor clearColor]];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2==0){
        return 30;
        
    }
    else {
        //UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        //return cell.frame.size.height;
        //return 120;
        
        NSString *text = @"";
        if(_helpItem){
            text = _helpItem.answer;
        }
        
        
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:text
                                                                        attributes:@{
                                                                                     (id)kCTForegroundColorAttributeName : (id)RGB(39, 127, 195).CGColor,
                                                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]
                                                                                     }];
        CGSize s =[TTTAttributedLabel sizeThatFitsAttributedString:attString withConstraints:CGSizeMake(ScreenWitdh-60, 1000) limitedToNumberOfLines:0];
        
        //_detailDes.frame = CGRectMake(5, 5, s.width, s.height);
        return s.height + 20;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return 0;
    }
    return 20; // you can have your own choice, of course
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = RGB(222, 222, 222);
//    return headerView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"learnVC didSelectRowAtIndexPath=%li",(long)indexPath.row);

}

#pragma mark -  网络请求
-(void) requestAllQuestion{
   DataRequest *r = [QyDataManger getAllQuestion:@"" callback:^(NSArray *items, BOOL success) {
        //
       _helpList = items;
       [_listTable reloadData];
    }];
    [r startAsynchronous];
}

@end
