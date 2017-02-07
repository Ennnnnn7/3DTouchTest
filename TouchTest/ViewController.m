//
//  ViewController.m
//  TouchTest
//
//  Created by 刘杰 on 2017/1/25.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <PhotosUI/PhotosUI.h>



@interface ViewController ()<UIViewControllerPreviewingDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PHLivePhotoView *liveImageView;
@property (nonatomic, strong) UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTableView];
    // 判断当前设备是否支持3D Touch
//    [self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable]
//    [self registerForPreviewingWithDelegate:(id)self sourceView:self.mainTableView];

}
// 添加图片选择
- (void)loadImagePicker {

    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    
    _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeLivePhoto];
    [self presentViewController:_imagePicker animated:YES completion:^{
        
    }];
}
// 添加表视图
- (void)loadTableView {
    _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.rowHeight =70;
    _mainTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mainTableView];
}
// 添加ImageView
- (void)loadSubviews {
    // 添加ImageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor grayColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.center = CGPointMake(375 * 0.5, 667 * 0.5 - 100);
    [self.view addSubview:_imageView];
    
    // 添加手势
    _liveImageView = [[PHLivePhotoView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _liveImageView.center = CGPointMake(375 * 0.5, 667 * 0.5 + 100);
    [self.view addSubview:_liveImageView];
    
    _imageView.image = [PHLivePhotoView livePhotoBadgeImageWithOptions:PHLivePhotoBadgeOptionsLiveOff];
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"icon"];
    cell.imageView.userInteractionEnabled = YES;
    // 注册Peek代理
    [self registerForPreviewingWithDelegate:(id)self sourceView:cell.imageView];
    
    return cell;
}

#pragma mark - UIViewControllerPreviewingDelegate
// Peek展示的控制器
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    return detailVC;
    
}

// pop展示的控制器
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - ImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:^{
        PHLivePhoto *photo = [info objectForKey:UIImagePickerControllerLivePhoto];
        if (photo) {
            _liveImageView.livePhoto = photo;
            _liveImageView.contentMode = UIViewContentModeScaleAspectFill;
            [_liveImageView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
        } else {
            _imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
