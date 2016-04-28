//
//  ZCComposeViewController.m
//  OrangeStatus
//
//  Created by ZhangCheng on 16/4/28.
//  Copyright © 2016年 ZhangCheng. All rights reserved.
//

#import "ZCComposeViewController.h"
#import "ZCAccountTool.h"
#import "ZCTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "ZCComposeToolBar.h"
#import "ZCComposePhotosView.h"

@interface ZCComposeViewController () <UITextViewDelegate, ZCComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) ZCTextView *textView;
@property (nonatomic, weak) ZCComposeToolBar *toolBar;
/** 存放从拍照或相册中选择的图片*/
@property (nonatomic, weak) ZCComposePhotosView *photosView;
@end

@implementation ZCComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setupTextView];
    
    [self setupToolBar];
    
    [self setupPhotos];
    
    
    
}

- (void)setupPhotos
{
    ZCComposePhotosView *photosView = [[ZCComposePhotosView alloc] init];
    photosView.x = 0;
    photosView.y = 300;
    photosView.width = self.view.width;
    photosView.height  = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

- (void)setupToolBar
{
    ZCComposeToolBar *toolBar = [[ZCComposeToolBar alloc] init];
    toolBar.delegate = self;
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.x = 0;
    toolBar.y = self.view.height;
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
}
- (void)setupTextView
{
    ZCTextView *textView = [[ZCTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    //垂直方向上有弹簧效果
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderColor = [UIColor grayColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    //能输入文字的空间成为第一响应者就会弹出键盘
    [textView becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardFrameChange:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    CGRect keyboardFrame =  [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];;
    
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.y = keyboardFrame.origin.y - self.toolBar.height;
    }];
}



- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNavigation
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.leftBarButtonItem.enabled = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [ZCAccountTool account].name;
    NSString *prefix = @"发微博";
    
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        
        NSString *string = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:[string rangeOfString:prefix]];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[string rangeOfString:name]];
        titleView.attributedText = attributeString;
        self.navigationItem.titleView = titleView;
    }else{
        self.title = prefix;
    }
    
    
}

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    /*https://api.weibo.com/2/statuses/update.json
     access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
     status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [ZCAccountTool account].access_token ;
    parameters[@"status"] = self.textView.text;
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD showError:@"发送失败"];
        ZCLog(@"%@", error);
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - ComposeToolBarDelegate
- (void)composeToolBar:(ZCComposeToolBar *)toolBar didButtonType:(ZCComposeToolBarType)type
{
    switch (type) {
        case ZCComposeToolBarTypeCamere:
            [self openCamera];
            break;
        case ZCComposeToolBarTypePicture:
            [self openAlbum];
            break;
        case ZCComposeToolBarTypeMention:
            
            break;
        case ZCComposeToolBarTypeTrend:
            
            break;
        case ZCComposeToolBarTypeEmotion:
            
            break;
            
        default:
            break;
    }
}

#pragma mark- 其他方法
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
}

@end
