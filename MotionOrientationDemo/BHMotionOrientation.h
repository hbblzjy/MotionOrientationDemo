//
//  BHMotionOrientation.h
//  MotionOrientationDemo
//
//  Created by JasonHam on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BHDirectionType) {
    ///未知
    BHDirectionType_Unknow = 0,
    ///竖直
    BHDirectionType_Portrait = 1,
    ///倒转
    BHDirectionType_Down = 2,
    ///左
    BHDirectionType_Left = 3,
    ///右
    BHDirectionType_Right = 4,
};

//自定义delegate
@class BHMotionOrientation;
@protocol BHMotionOrientationDelegate <NSObject>

///方向改变
- (void)motionOrientationDidChange:(BHMotionOrientation * _Nullable)motionOrientation direction:(BHDirectionType)direction;

@end

@interface BHMotionOrientation : NSObject

///代理
@property (nonatomic, weak)id <BHMotionOrientationDelegate>delegate;

///开启陀螺仪
-(void)startMotion;

///停止陀螺仪
-(void)stopMotion;

@end

NS_ASSUME_NONNULL_END
