//
//  HYScanterDeviceCaptureVC.m
//  HYScanter_Tests
//
//  Created by 邱弘宇 on 2018/11/12.
//  Copyright © 2018年 YHQiu@github.com. All rights reserved.
//

#import "HYScanterDeviceCaptureVC.h"

#import <AVKit/AVKit.h>

@interface HYScanterDeviceCaptureVC ()

@property (nonatomic, strong)   AVCaptureSession *session;

@property (nonatomic, strong)   AVCaptureDevice *captureDevice;

@property (nonatomic, strong)   AVPlayerLayer *playerLayer;

@property (nonatomic, strong)   AVCaptureDeviceInput *captureInput;

@property (nonatomic, strong)   AVCaptureStillImageOutput *captureOutput;

@property (nonatomic, strong)   AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong)   UIImage *cameraImage;

@end

@implementation HYScanterDeviceCaptureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UI

- (void)initUI{
    
    _session = [[AVCaptureSession alloc] init];
    
    // Device
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (_captureDevice==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // Input
    [self addInput];
    
    // Output
    [self addOutput];
    
}

/**
 添加输入设备
 */
-(void)addInput{
    _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:nil];
    // -- 焦点 - 曝光 - 黑白色 -- 自动 --
    NSError *error = nil;
    if ([_captureDevice lockForConfiguration:&error]) {
        if ([_captureDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
            _captureDevice.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        if ([_captureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
            _captureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        if ([_captureDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance])
            _captureDevice.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
        [_captureDevice unlockForConfiguration];
    }
    
    [_session beginConfiguration];
    [_session commitConfiguration];
    
    if(self.captureInput){
        [_session addInput:self.captureInput];
    }else
    {
        [[[UIAlertView alloc]
           initWithTitle:nil
           message:@"打开设备失败"
           delegate:nil
           cancelButtonTitle:@"好"
           otherButtonTitles:nil, nil] show];
    }
}

/**
 添加输出设备
 */
- (void)addOutput{
    //添加输出设备
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    _captureOutput.outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                     AVVideoCodecJPEG, AVVideoCodecKey,
                     nil
                     ];
    [_session addOutput:_captureOutput];
    
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.frame = self.view.bounds;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_previewLayer];//self 是一个UIImageView；
    [_session beginConfiguration];
    [_session commitConfiguration];
    if (_captureInput)
    {
        if (!_session.running)
        {
            [_session startRunning];
        }
    }
    
}

/**
 拍照获取图片
 */
- (void)captureImage:(void (^)(BOOL, UIImage *))cameraFinished
{
    //获取连接
    __block AVCaptureConnection * videoConnection = nil;
    [self.captureOutput.connections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         AVCaptureConnection * connection = (AVCaptureConnection *)obj;
         [[connection inputPorts] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
          {
              AVCaptureInputPort * port = (AVCaptureInputPort *)obj;
              if ([[port mediaType] isEqualToString:AVMediaTypeVideo])
              {
                  *stop = YES;
              }
          }];
         if (videoConnection)
         {
             *stop = YES;
         }
     }];
    __block UIImage * image = nil;
    if (videoConnection)
    {
        //  -- 获取图片 - 为一个异步操作 --
        
        [self.captureOutput captureStillImageAsynchronouslyFromConnection:videoConnection
                                                   completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
         {
             if(_session.running){
                 [_session stopRunning];
             }
             @autoreleasepool
             {
                 NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                 image = [UIImage imageWithData:imageData];
                 self.cameraImage = image;
                 if (cameraFinished)
                 {
                     cameraFinished(YES,image);
                 }
             }
         }];
        
    }
    
}

@end
