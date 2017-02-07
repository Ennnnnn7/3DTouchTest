//
//  DetailViewController.m
//  TouchTest
//
//  Created by 刘杰 on 2017/1/25.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "DetailViewController.h"
#import <Photos/Photos.h>


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    _detailImageView.image = [UIImage imageNamed:@"icon"];
    [self.view addSubview:_detailImageView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(rightTestAction)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightTestAction
{
    NSLog(@"点击右侧按钮");
}

// peek quick action
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"test" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点了啥 你知道不 你知道不");
    }];
    NSArray *arr = @[action];
    return arr;
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

@end
