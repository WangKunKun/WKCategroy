//
//  ViewController.m
//  WKButtonCategroyDemo
//
//  Created by wangkun on 2017/11/2.
//  Copyright © 2017年 wangkun. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+WKTouchDown.h"
#import "UIButton+AddCornerRadiusLayer.h"
@interface ViewController ()

@property (nonatomic, strong) UIButton * crTextBtn;
@property (nonatomic, strong) UIButton * crImageBtn;
@property (nonatomic, strong) UIButton * crTextImageBtn;

@property (nonatomic, strong) UIButton * controlBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.crTextBtn];
    [self.view addSubview:self.crImageBtn];
    [self.view addSubview:self.crTextImageBtn];
    [self.view addSubview:self.controlBtn];
    
    self.view.backgroundColor = [UIColor grayColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)crTextBtn
{
    if (!_crTextBtn) {
        _crTextBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _crTextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_crTextBtn setTitle:@"一个字" forState:(UIControlStateNormal)];
        [_crTextBtn setTitle:@"很多个字" forState:(UIControlStateSelected)];
        _crTextBtn.isVaildDownModel = YES;
        _crTextBtn.isAddCornerRadiusLayer = YES;
        _crTextBtn.tag = 100;
        [_crTextBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _crTextBtn.center = CGPointMake( self.view.center.x, 100);
        _crTextBtn.bounds = CGRectMake(0, 0, 200, 40);
        _crTextBtn.backgroundColor = RGBCOLOR(224, 117, 102);
        
    }
    return _crTextBtn;
}

- (UIButton *)crImageBtn
{
    if (!_crImageBtn) {
        _crImageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _crImageBtn.isVaildDownModel = YES;
        _crImageBtn.wkCRLayerArea = WKBtnCRLayerArea_JustImageView;
        _crImageBtn.isAddCornerRadiusLayer = YES;
        _crImageBtn.tag = 101;
        [_crImageBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_crImageBtn setImage:[UIImage imageNamed:@"7"] forState:(UIControlStateNormal)];
        _crImageBtn.center = CGPointMake( self.view.center.x, 180);
        _crImageBtn.bounds = CGRectMake(0, 0, 100, 40);
    }
    return _crImageBtn;
}

- (UIButton *)crTextImageBtn
{
    if (!_crTextImageBtn) {
        _crTextImageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _crTextImageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_crTextImageBtn setImage:[UIImage imageNamed:@"7"] forState:(UIControlStateNormal)];
        [_crTextImageBtn setTitle:@"一个字" forState:(UIControlStateNormal)];

        _crTextImageBtn.isVaildDownModel = YES;
        _crTextImageBtn.wkCRLayerArea = WKBtnCRLayerArea_LabelAndImageView;
        _crTextImageBtn.isAddCornerRadiusLayer = YES;
        [_crTextImageBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _crTextImageBtn.tag = 102;
        _crTextImageBtn.center = CGPointMake( self.view.center.x, 260);
        _crTextImageBtn.bounds = CGRectMake(0, 0, 200, 40);

    }
    return _crTextImageBtn;
}

- (UIButton *)controlBtn
{
    if (!_controlBtn) {
        _controlBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _controlBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _controlBtn.isVaildDownModel = YES;
        _controlBtn.isAddCornerRadiusLayer = YES;
        [_controlBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _controlBtn.tag = 102;
        _controlBtn.center = CGPointMake( self.view.center.x, 340);
        _controlBtn.bounds = CGRectMake(0, 0, 100, 40);
        
    }
    return _controlBtn;
}

- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag - 100) {
        case 0:
            btn.selected = !btn.selected;
            break;
            
        default:
            break;
    }
}

@end
