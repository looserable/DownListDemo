//
//  DownListView.m
//  DownListDemo
//
//  Created by jhon on 16/1/27.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import "DownListView.h"
//button的高度
#define DOWN_LIST_BTN_HEIGHT 30
#define CELL_HEIGHT 30
#define CELL_LIMIT_COUNT 4

@interface DownListView()<UITableViewDelegate,UITableViewDataSource>
{
    /**
     *  一个tableview来做列表
     */
    UITableView * listTabView;
    /**
     *  一个数组来承接数据源
     */
    NSArray * listArray;
    /**
     *  一个初始化的button
     */
    UIButton * downListBtn;
    /**
     *  一个tableview的高度，根据listarray.count来动态的确定
     */
    CGFloat listTabHeight;
}


@end

@implementation DownListView

-(instancetype)initWithFrame:(CGRect)frame andListArray:(NSArray *)array{
    if (self = [super initWithFrame:frame]) {
        
        downListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        downListBtn.frame = CGRectMake(0, 0, frame.size.width, DOWN_LIST_BTN_HEIGHT);
        downListBtn.backgroundColor = [UIColor whiteColor];
        [downListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [downListBtn setTitle:array[0] forState:UIControlStateNormal];
        [downListBtn addTarget:self action:@selector(downClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:downListBtn];
        
        listTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, DOWN_LIST_BTN_HEIGHT, frame.size.width,0)];
        listTabView.delegate = self;
        listTabView.dataSource = self;
        listTabView.backgroundColor = [UIColor clearColor];
//       用来消除tableview的各层视图的影响
        for (UIView * view in listTabView.subviews) {
            view.backgroundColor = [UIColor clearColor];
        }
        [self addSubview:listTabView];
        
        
        listArray = array;
        
        listTabHeight = listArray.count >= CELL_LIMIT_COUNT?CELL_LIMIT_COUNT*CELL_HEIGHT:listArray.count * CELL_HEIGHT;
        
    }
    return self;
}

- (void)downClick:(UIButton *)sender{
    
    if ((sender.tag = !sender.tag)) {
       [UIView animateWithDuration:0.3 animations:^{
           CGRect seFrame = self.frame;
           seFrame.size.height = listTabHeight + DOWN_LIST_BTN_HEIGHT;
           self.frame = seFrame;
           
           CGRect frame = listTabView.frame;
           frame.size.height = listTabHeight;
           listTabView.frame = frame;
       }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect seFrame = self.frame;
            seFrame.size.height = DOWN_LIST_BTN_HEIGHT;
            self.frame = seFrame;
            
            CGRect frame = listTabView.frame;
            frame.size.height = 0;
            listTabView.frame = frame;
        }];
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell ) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5,self.frame.size.width, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = _listTitleColor;
        label.tag = 1000;
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
        
        [self setLastCellSeperatorToLeft:cell];
        
    }
//    为cell设置背景颜色
    for (UIView * view in listTabView.subviews) {
        view.backgroundColor = _listBgColor;
    }
    UILabel * label = (UILabel *)[cell.contentView viewWithTag:1000];
    label.text = listArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect seFrame = self.frame;
        seFrame.size.height = DOWN_LIST_BTN_HEIGHT;
        self.frame = seFrame;
        
        CGRect frame = listTabView.frame;
        frame.size.height = 0;
        listTabView.frame = frame;
    }];
    downListBtn.tag = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(selectBlock:)]) {
        [_delegate selectBlock:indexPath.row];
    }
}

-(void)setDownTitle:(NSString *)title{
    [downListBtn setTitle:title forState:UIControlStateNormal];
}

//cell的分割线顶头
-(void)setLastCellSeperatorToLeft:(UITableViewCell *)cell
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}


@end
