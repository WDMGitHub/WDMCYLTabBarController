//
//  DMPlusButtonSubclass.m
//  DMCYLTabBarController
//
//  Created by demin on 16/8/10.
//  Copyright © 2016年 Demin. All rights reserved.
//

#import "DMPlusButtonSubclass.h"
#import "CYLTabBarController.h"

@interface DMPlusButtonSubclass ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation DMPlusButtonSubclass

#pragma mark - Life Cycle

+ (void)load {
    [super registerSubclass];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

//上下结构的 button
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //控件大小，间距大小
    //注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的plusButton的iocn不是正方形。
    //button的图片宽度
    CGFloat const imageViewEdgeWidth = self.bounds.size.width * 0.7;
    //button的图片高度
    CGFloat const imageViewEdgeHeight = imageViewEdgeWidth * 0.9;
    //button的中心高度
    CGFloat const centerOfView = self.bounds.size.width * 0.5;
    //button的title的行高
    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
    CGFloat const verticalMarginT = self.bounds.size.height - labelLineHeight - imageViewEdgeWidth;
    CGFloat const verticalMargin = verticalMarginT / 2;
    
    //imageView和titleLabel中心的Y值
    CGFloat const centerOfImageView = verticalMargin + imageViewEdgeWidth * 0.5;
    CGFloat const centerOfTitleLabel = imageViewEdgeWidth + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
    
    //title position 位置
    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
}

#pragma mark - CYLPlusButtonSubclassing Methods
/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    DMPlusButtonSubclass *button = [[DMPlusButtonSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitle:@"选中" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    //    button.frame = CGRectMake(0.0, 0.0, 250, 100);
    //    button.backgroundColor = [UIColor redColor];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


/*
 *
 Create a custom UIButton without title and add it to the center of our tab bar
 *
 */
//+ (id)plusButton
//{
//
//    UIImage *buttonImage = [UIImage imageNamed:@"hood.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"hood-selected.png"];
//
//    DMPlusButtonSubclass* button = [DMPlusButtonSubclass buttonWithType:UIButtonTypeCustom];
//
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
//
//    return button;
//}

#pragma mark - Event Response
- (void)clickPublish {
    NSLog(@"点击了按钮");
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//        imagePicker.allowsEditing = YES;
        imagePicker.allowsEditing = NO;
        imagePicker.delegate = self;
        [viewController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *fromCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
//            imagePicker.allowsEditing = YES;
            imagePicker.allowsEditing = NO;
            imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [viewController presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromCameraAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
    
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取",@"淘宝一键转卖", nil];
//    [actionSheet showInView:viewController.view];
//}
//
//#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    NSLog(@"buttonIndex = %@",@(buttonIndex));
}

#pragma mark - DMPlusButtonSubclassing
//+ (UIViewController *)plusChildViewController {
//    UIViewController *plusChildViewController = [[UIViewController alloc] init];
//    plusChildViewController.view.backgroundColor = [UIColor yellowColor];
//    plusChildViewController.navigationItem.title = @"PlusChildViewController";
//    UIViewController *plusChildNavigationController = [[UINavigationController alloc] initWithRootViewController:plusChildViewController];
//    return plusChildNavigationController;
//}

//+ (NSUInteger)indexOfPlusButtonInTabBar {
//    return 2;
//}

+ (CGFloat)multiplerInCenterY {
    return 0.17;
}


















@end
