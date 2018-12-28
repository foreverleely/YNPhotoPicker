//
//  YNPhotoPicker.h
//  
//
//  Created by liyangly on 2018/12/26.
//  Copyright © 2018 liyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNPhotoPicker : NSObject

// 完成图片选择的block
@property (nonatomic, copy) void(^finishPickingMediaWithInfo)(NSDictionary<NSString *,id> *);

+ (YNPhotoPicker *)share;

// auth
+ (void)checkPhotoAuthorizationForVC:(UIViewController *)vc camera:(BOOL)isCamera photoRead:(BOOL)isPhotoRead completion:(void(^)(void))completion;

// open carema
- (void)openCaremaPresentFrom:(UIViewController *)vc;
// open photo library
- (void)openAlbumPresentFrom:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
