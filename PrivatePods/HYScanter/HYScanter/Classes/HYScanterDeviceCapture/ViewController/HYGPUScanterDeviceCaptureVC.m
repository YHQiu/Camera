//
//  HYGPUScanterDeviceCaptureVC.m
//  HYScanter_Tests
//
//  Created by 邱弘宇 on 2018/11/12.
//  Copyright © 2018年 YHQiu@github.com. All rights reserved.
//

#import "HYGPUScanterDeviceCaptureVC.h"

#import <GPUImage.h>
#import <Photos/Photos.h>

@interface HYGPUScanterDeviceCaptureVC ()

@property (nonatomic, strong) GPUImageStillCamera *myCamera;

@property (nonatomic, strong) GPUImageView *myGPUImageView;

//@property (nonatomic, strong) GPUImageFilter *myFilter;

@property (nonatomic, strong) GPUImageFilterGroup *myFilterGroup;

@property (nonatomic, strong) UIButton *captureBtn;

@property (nonatomic, strong) UIImageView *capturePreview;

@property (nonatomic, assign) CGFloat foucus;

@property (nonatomic, assign) CGPoint forcusLockPoint0;

@property (nonatomic, assign) CGPoint forcusLockPoint1;

@end

@implementation HYGPUScanterDeviceCaptureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(adjustForcus:)];
    [self.view addGestureRecognizer:pinch];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

- (void)initUI{
    @weakify(self)
    [self initGPUImage];
    
    self.captureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.captureBtn.layer.cornerRadius = 60;
    self.captureBtn.layer.borderWidth = 5;
    self.captureBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.captureBtn.backgroundColor = [UIColor whiteColor];
    self.captureBtn.alpha = 0.8;
    [self.captureBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:self.captureBtn];
    [self.captureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.width.height.mas_equalTo(120);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.captureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self)
        [self capturePhoto];
    }];
    
    
}

- (void)initGPUImage{
    //步骤一：初始化相机，第一个参数表示相册的尺寸，第二个参数表示前后摄像头
    self.myCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
    
    //竖屏方向
    self.myCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    //步骤二：初始化滤镜
    //GPUImageSketchFilters素描滤镜
//    GPUImageSketchFilter *stretchDistortionFilter = [[GPUImageSketchFilter alloc] init];
//    self.myFilter = stretchDistortionFilter;
    
    GPUImageSaturationFilter *invertFilter = [[GPUImageSaturationFilter alloc] init];
    invertFilter.saturation = 1.5;
    
    GPUImageContrastFilter *exposureFilter = [[GPUImageContrastFilter alloc]init];
    exposureFilter.contrast = 1.5;
    
    //sketchFilter
    GPUImageSketchFilter *sketchFilter = [[GPUImageSketchFilter alloc] init];
    
    /*
     *FilterGroup的方式混合滤镜
     */
    //初始化GPUImageFilterGroup
    self.myFilterGroup = [[GPUImageFilterGroup alloc] init];
    
    //将滤镜加在FilterGroup中
    [self addGPUImageFilter:sketchFilter];
    [self addGPUImageFilter:invertFilter];
    //[self addGPUImageFilter:exposureFilter];
    
    //步骤三：初始化GPUImageView
    self.myGPUImageView = [[GPUImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    //步骤四：将初始化过的相机加到目标滤镜上
    [self.myCamera addTarget:self.myFilterGroup];
    
    //步骤五：将滤镜加在目标GPUImage上
    [self.myFilterGroup addTarget:self.myGPUImageView];
    
    //步骤六：GPUImage加在控制器视图上
    
    [self.view addSubview:self.myGPUImageView];
    
    //步骤七：相机开始捕捉画面
    [self.myCamera startCameraCapture];
    
}

- (void)initFilter{
    
    
    
}

#pragma mark 将滤镜加在FilterGroup中并且设置初始滤镜和末尾滤镜
- (void)addGPUImageFilter:(GPUImageFilter *)filter{
    
    [self.myFilterGroup addFilter:filter];
    
    GPUImageOutput<GPUImageInput> *newTerminalFilter = filter;
    
    NSInteger count = self.myFilterGroup.filterCount;
    
    if (count == 1)
    {
        //设置初始滤镜
        self.myFilterGroup.initialFilters = @[newTerminalFilter];
        //设置末尾滤镜
        self.myFilterGroup.terminalFilter = newTerminalFilter;
        
    } else
    {
        GPUImageOutput<GPUImageInput> *terminalFilter    = self.myFilterGroup.terminalFilter;
        NSArray *initialFilters                          = self.myFilterGroup.initialFilters;
        
        [terminalFilter addTarget:newTerminalFilter];
        
        //设置初始滤镜
        self.myFilterGroup.initialFilters = @[initialFilters[0]];
        //设置末尾滤镜
        self.myFilterGroup.terminalFilter = newTerminalFilter;
    }
}

/**
 截图
 */
- (void)capturePhoto{
    @weakify(self);
    if (self.capturePreview) {
        UIImage *temporyImg = self.capturePreview.image;
        [self.capturePreview removeFromSuperview];
        self.capturePreview = nil;
        [self.captureBtn setTitle:nil forState:UIControlStateNormal];
        
        //拿到相册，需要引入Photo Kit
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //写入图片到相册
            if (temporyImg) {
                PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:temporyImg];
            }
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                NSLog(@"success = %d, error = %@", success, error);
        }];
        return;
    }
    else{
        [self.captureBtn setTitle:@"SAVE" forState:UIControlStateNormal];
    }
    //定格一张图片
    [self.myCamera capturePhotoAsPNGProcessedUpToFilter:self.myFilterGroup withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        @strongify(self);
        self.capturePreview = [[UIImageView alloc]initWithImage:[UIImage imageWithData:processedPNG]];
        [self.view insertSubview:self.capturePreview belowSubview:self.captureBtn];
        self.capturePreview.frame = self.view.bounds;
    }];
}

- (void)adjustForcus:(UIPinchGestureRecognizer *)pinch{
    
    CGPoint p0 = [pinch locationOfTouch:0 inView:self.view];
    if (pinch.numberOfTouches <= 1) {
        return;
    }
    CGPoint p1 = [pinch locationOfTouch:1 inView:self.view];
    CGFloat currentWidth = pow(p0.x - p1.x,2);
    CGFloat currentHeight = pow(p0.y - p1.y,2);
    
    CGFloat lastWidth = pow(self.forcusLockPoint0.x - self.forcusLockPoint1.x,2);
    CGFloat lastHeight = pow(self.forcusLockPoint0.y - self.forcusLockPoint1.y,2);
    
    if ((currentWidth+currentHeight) > (lastWidth+lastHeight)) {
        self.foucus += pinch.scale;
        self.foucus = MIN(self.foucus, 67.5);
    }
    else{
        self.foucus -= pinch.scale;
        self.foucus = MAX(self.foucus, 0);
    }
    self.forcusLockPoint0 = p0;
    self.forcusLockPoint1 = p1;

    dispatch_async(dispatch_get_main_queue(), ^{
        NSError *error = nil;
        
        [self.myCamera.inputCamera lockForConfiguration:&error];
        self.myCamera.inputCamera.videoZoomFactor = MIN(67.5,MAX(1,self.foucus/10.f));
        //[self.myCamera.inputCamera setFocusPointOfInterest:[pinch locationInView:self.view]];
        [self.myCamera.inputCamera unlockForConfiguration];
        
    });

    
}


@end
