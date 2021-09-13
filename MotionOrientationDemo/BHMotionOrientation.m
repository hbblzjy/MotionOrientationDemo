//
//  BHMotionOrientation.m
//  MotionOrientationDemo
//
//  Created by JasonHam on 2021/9/13.
//

#import "BHMotionOrientation.h"

#import <CoreMotion/CoreMotion.h>

///灵敏度
static const float  sensitive = 0.80;

@interface BHMotionOrientation ()

///陀螺仪管理者
@property (nonatomic, strong) CMMotionManager *motionManager;
///方向
@property (nonatomic, assign) BHDirectionType direction;

@end

@implementation BHMotionOrientation

#pragma mark - getter
-(CMMotionManager *)motionManager{
    
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        //更新间隔时间
        _motionManager.deviceMotionUpdateInterval = 0.025f;
    }
    return _motionManager;
}

#pragma mark - 开启陀螺仪
-(void)startMotion{
    
    if (self.motionManager.deviceMotionAvailable) {
        
        __weak typeof(self) wself = self;
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            [wself changeDirectionWithMotion:motion];
            
        }];
        
    }
}

#pragma mark - 更改方向
-(void)changeDirectionWithMotion:(CMDeviceMotion *)motion{
    
    double x = motion.gravity.x;
    double y = motion.gravity.y;
    
    if (y < 0) {
        if (fabs(y) > sensitive) {
            if (_direction != BHDirectionType_Portrait) {
                
                _direction = BHDirectionType_Portrait;
                
                if (_delegate && [_delegate respondsToSelector:@selector(motionOrientationDidChange:direction:)]) {
                    [_delegate motionOrientationDidChange:self direction:_direction];
                }
            }
        }
    } else {
        if (y > sensitive) {
            if (_direction != BHDirectionType_Down) {
                
                _direction = BHDirectionType_Down;
                
                if (_delegate && [_delegate respondsToSelector:@selector(motionOrientationDidChange:direction:)]) {
                    [_delegate motionOrientationDidChange:self direction:_direction];
                }
            }
        }
    }
    
    if (x < 0) {
        if (fabs(x) > sensitive) {
            if (_direction != BHDirectionType_Left) {
                
                _direction = BHDirectionType_Left;
                
                if (_delegate && [_delegate respondsToSelector:@selector(motionOrientationDidChange:direction:)]) {
                    [_delegate motionOrientationDidChange:self direction:_direction];
                }
            }
        }
    } else {
        if (x > sensitive) {
            if (_direction != BHDirectionType_Right) {
                
                _direction = BHDirectionType_Right;
                
                if (_delegate && [_delegate respondsToSelector:@selector(motionOrientationDidChange:direction:)]) {
                    [_delegate motionOrientationDidChange:self direction:_direction];
                }
            }
        }
    }
}

#pragma mark - 停止陀螺仪
-(void)stopMotion{
    
    [_motionManager stopDeviceMotionUpdates];
    
}


@end
