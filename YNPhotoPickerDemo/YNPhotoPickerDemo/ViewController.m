//
//  ViewController.m
//  YNPhotoPickerDemo
//
//  Created by liyangly on 2018/12/26.
//  Copyright © 2018 liyang. All rights reserved.
//

#import "ViewController.h"

#import "YNPhotoPickerManager.h"

@interface ViewController ()

@property (nonatomic, strong) YNPhotoPickerManager *photoPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 300, 200, 50);
    [btn1 setTitle:@"Open Caream" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(openCarema) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 400, 200, 50);
    [btn2 setTitle:@"Open Album" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)photoAuth {
    [YNPhotoPickerManager checkPhotoAuthorizationForVC:self camera:NO photoRead:YES completion:^{
        
    } cancel:^{
        
    }];
}

- (void)openCarema {
    __weak typeof(self) weakSelf = self;
//    [YNPhotoPickerManager checkPhotoAuthorizationForVC:self camera:NO photoRead:YES completion:^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [YNPhotoPickerManager.share openCaremaPresentFrom:strongSelf];
//    }];
}

- (void)openAlbum {
    __weak typeof(self) weakSelf = self;
//    [YNPhotoPickerManager checkPhotoAuthorizationForVC:self camera:NO photoRead:YES completion:^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [YNPhotoPickerManager.share openAlbumPresentFrom:strongSelf];
//    }];
}

#pragma mark - Getters

- (YNPhotoPickerManager *)photoPicker {
    if (!_photoPicker) {
        _photoPicker = [YNPhotoPickerManager new];
    }
    return _photoPicker;
}


@end
