//
//  ViewController.m
//  MotionOrientationDemo
//
//  Created by JasonHam on 2021/9/13.
//

#import "ViewController.h"

#import "BHMotionOrientation.h"

@interface ViewController () <BHMotionOrientationDelegate> {
    
    ///旋转图
    UIImageView *_transformImgV;
    ///方向
    UILabel *_rotationLabel;
    ///开始 / 停止
    UIButton *_beginOrStopBtn;
    
    ///陀螺仪
    BHMotionOrientation *_bhMotionOrientation;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initViews];
    
}

#pragma mark - initUIs
-(void)initViews{
    
    _transformImgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 160, 100)];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wangzhe" ofType:@"jpg"];
    _transformImgV.image = [UIImage imageWithContentsOfFile:filePath];
    _transformImgV.layer.cornerRadius = 5.0f;
    [self.view addSubview:_transformImgV];
    
    _rotationLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 160, 30)];
    _rotationLabel.text = @"方向";
    _rotationLabel.textColor = [UIColor blueColor];
    _rotationLabel.font = [UIFont systemFontOfSize:22];
    _rotationLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_rotationLabel];
    
    _beginOrStopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _beginOrStopBtn.frame = CGRectMake(100, 350, 160, 44);
    [_beginOrStopBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_beginOrStopBtn setTitle:@"停止" forState:UIControlStateSelected];
    [_beginOrStopBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_beginOrStopBtn addTarget:self action:@selector(beginOrStopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_beginOrStopBtn];
    
    _bhMotionOrientation = [[BHMotionOrientation alloc] init];
    _bhMotionOrientation.delegate = self;
    
}

#pragma mark - 开始/停止click
-(void)beginOrStopBtnClick:(UIButton *)sender{
    
    if (sender.selected) {
        //停止
        [_bhMotionOrientation stopMotion];
        
        _rotationLabel.text = @"方向";
        
    } else {
        //开始
        [_bhMotionOrientation startMotion];
    }
    
    sender.selected = !sender.selected;
    
}

#pragma mark - 代理BHMotionOrientationDelegate
-(void)motionOrientationDidChange:(BHMotionOrientation *)motionOrientation direction:(BHDirectionType)direction{
    
    switch (direction) {
        case BHDirectionType_Portrait:
        {
            _rotationLabel.text = @"Portrait";
            
            [UIView animateWithDuration:0.1 animations:^{
//                //还原
//                self->_transformImgV.transform = CGAffineTransformMakeRotation(2*M_PI);
//                self->_transformImgV.transform = CGAffineTransformMakeRotation(0);
                //还原
                self->_transformImgV.transform = CGAffineTransformIdentity;
            }];
        }
            break;
            
        case BHDirectionType_Down:
        {
            _rotationLabel.text = @"Down";
            
            [UIView animateWithDuration:0.1 animations:^{
                //顺时针旋转
                self->_transformImgV.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
            
        case BHDirectionType_Left:
        {
            _rotationLabel.text = @"Left";
            
            [UIView animateWithDuration:0.1 animations:^{
                //顺时针旋转
                self->_transformImgV.transform = CGAffineTransformMakeRotation(M_PI/2);
            }];
        }
            break;
            
        case BHDirectionType_Right:
        {
            _rotationLabel.text = @"Right";
            
            [UIView animateWithDuration:0.1 animations:^{
                //逆时针旋转
                self->_transformImgV.transform = CGAffineTransformMakeRotation(-M_PI/2);
            }];
        }
            break;
            
        default:
            break;
    }
    
    //注意：
    //进行旋转时，要判断系统是否锁屏
    //如果未锁屏状态下：当横屏时 SCREEN_HEIGHT 和 SCREEN_WIDTH 会相互切换
    /*
     // 屏幕宽度
     #define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
     // 屏幕高度
     #define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
     */
    
}


@end
