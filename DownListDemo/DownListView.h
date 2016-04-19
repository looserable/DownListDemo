//
//  DownListView.h
//  DownListDemo
//
//  Created by jhon on 16/1/27.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppreaDelegate <NSObject>

/**
 *  点击cell之后的回调的代理方法
 *
 *  @param index 点击的位置
 */
- (void)selectBlock:(NSInteger)index;

@end

@interface DownListView : UIView
/**
 *  下拉列表的title的字体颜色
 */
@property (nonatomic,retain)UIColor * listTitleColor;
/**
 *  下拉列表的背景颜色
 */
@property (nonatomic,retain)UIColor * listBgColor;

@property (nonatomic,strong)id <AppreaDelegate> delegate;
/**
 *  初始化downListView的方法
 *
 *  @param frame 给出downListview的位置，必须说明的是它的height是任意值
 *  @param array 这是downListView中各项title文字的数组
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame andListArray:(NSArray*)array;
/**
 *  设置button的文字
 *
 *  @param title 字符串
 */
-(void)setDownTitle:(NSString *)title;


@end
