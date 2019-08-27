//
//  YNPhotoPickerManager.m
//
//
//  Created by liyangly on 2018/12/26.
//  Copyright © 2018 liyang. All rights reserved.
//

#import "YNPhotoPickerManager.h"

#import <Photos/Photos.h>

@interface YNPhotoPickerManager()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation YNPhotoPickerManager

+ (YNPhotoPickerManager *)share {
    static YNPhotoPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [YNPhotoPickerManager new];
    });
    return manager;
}

+ (void)checkPhotoAuthorizationForVC:(UIViewController *)vc camera:(BOOL)isCamera photoRead:(BOOL)isPhotoRead completion:(void(^)(void))completion {
    
    [self checkPhotoAuthorizationForVC:vc camera:isCamera photoRead:isPhotoRead completion:completion cancel:nil];
}

+ (void)checkPhotoAuthorizationForVC:(UIViewController *)vc camera:(BOOL)isCamera photoRead:(BOOL)isPhotoRead completion:(void(^)(void))completion cancel:(void(^)(void))cancel {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (PHAuthorizationStatusAuthorized == status) {
        
        if (completion) {
            completion();
        }
    } else if (PHAuthorizationStatusNotDetermined == status) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (completion) {
                        completion();
                    }
                });
            }
        }];
    } else {
        [self showAuthorizationAlert:isCamera photoRead:isPhotoRead forVC:vc cancel:cancel];
    }
}

+ (void)showAuthorizationAlert:(BOOL)isCamera photoRead:(BOOL)isPhotoRead forVC:(UIViewController *)vc cancel:(void(^)(void))cancelBlock {
    // don't forget the auth desc in info.plist
    NSDictionary *tempInfoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *title = isCamera ? @"We Would Like to Access Your Camera" : @"We Would Like to Access Your Photo Gallery";
    NSString *message = isCamera ? [tempInfoDict objectForKey:@"NSCameraUsageDescription"] : (isPhotoRead ? [tempInfoDict objectForKey:@"NSPhotoLibraryUsageDescription"] : [tempInfoDict objectForKey:@"NSPhotoLibraryAddUsageDescription"]);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    UIAlertAction *enable = [UIAlertAction actionWithTitle:@"Enable" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert addAction:cancel];
    [alert addAction:enable];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - open carema
- (void)openCaremaPresentFrom:(UIViewController *)vc {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [vc presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - open album
- (void)openAlbumPresentFrom:(UIViewController *)vc {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [vc presentViewController:self.imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    /*{
     UIImagePickerControllerImageURL = "file:///Users/liyangly/Library/Developer/CoreSimulator/Devices/E8D061B2-574E-42C6-88C8-BB96B9BE5253/data/Containers/Data/Application/5C0E8FD8-D083-41EA-ADD0-388E6B9069ED/tmp/43867F59-BED6-4E81-99E1-E016915D5C4E.jpeg";
     UIImagePickerControllerMediaType = "public.image";
     UIImagePickerControllerOriginalImage = "<UIImage: 0x600003487640> size {1242, 1868} orientation 0 scale 1.000000";
     UIImagePickerControllerPHAsset = "<PHAsset: 0x7ff63601a7c0> 71638F91-DF4D-4323-8934-71DA291AD09F/L0/001 mediaType=1/0, sourceType=1, (1242x1868), creationDate=2018-11-16 11:58:30 +0000, location=0, hidden=0, favorite=0 ";
     UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=71638F91-DF4D-4323-8934-71DA291AD09F&ext=JPG";
     }*/
    
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.finishPickingMediaWithInfo) {
            strongSelf.finishPickingMediaWithInfo(info);
        }
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TODO  Don't forget the write method when writing
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
//
//    if (error) {
//        // hud toast error
//    } else {
//        NSURL *interURL = (__bridge_transfer id)contextInfo;
//        if (interURL && [interURL isKindOfClass:[NSURL class]]) {
//            [[UIApplication sharedApplication] openURL:interURL];
//        } else {
//            // hud toast success
//        }
//    }
//}

#pragma mark - Getters
- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}

@end
