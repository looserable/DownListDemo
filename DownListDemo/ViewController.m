//
//  ViewController.m
//  DownListDemo
//
//  Created by jhon on 16/1/27.
//  Copyright © 2016年 jhon. All rights reserved.
//

#import "ViewController.h"
#import "DownListView.h"

@interface ViewController ()<AppreaDelegate>
{
    DownListView * listView;
}
@property (nonatomic,copy)NSArray * listArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    _listArr = @[@"按钮一",@"按钮二",@"按钮三",@"按钮四"];
    
    listView = [[DownListView alloc]initWithFrame:CGRectMake(200, 100, 100, 30) andListArray:_listArr];
    listView.delegate = self;
    [listView setDownTitle:@"下拉列表"];
    listView.listTitleColor = [UIColor whiteColor];
    listView.listBgColor = [UIColor colorWithWhite:0 alpha:0.2];

    [self.view addSubview:listView];
    

    
}

- (void)selectBlock:(NSInteger)index{
    [listView setDownTitle:_listArr[index]];
//    接下来进行一些其它的操作
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
