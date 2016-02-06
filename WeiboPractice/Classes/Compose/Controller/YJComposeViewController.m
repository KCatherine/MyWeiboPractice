//
//  YJComposeViewController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/2.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJComposeViewController.h"
#import "YJAccountTool.h"
#import "YJEmotionTextView.h"
#import "YJComposeToolBar.h"
#import "YJComposePhotosView.h"
#import "YJEmotionKeyBoard.h"
#import "YJEmotion.h"

#import "YJHttpTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface YJComposeViewController ()<UITextViewDelegate, YJComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**
 *  文字输入框
 */
@property (nonatomic, weak) YJEmotionTextView *textView;
/**
 *  键盘工具条
 */
@property (nonatomic, weak) YJComposeToolBar *composeToolBar;
/**
 *  输入框下方配图
 */
@property (nonatomic, weak) YJComposePhotosView *photosView;
/**
 *  表情键盘
 */
@property (nonatomic, strong) YJEmotionKeyBoard *emotionKeyBoard;

@property (nonatomic, assign) BOOL switchingKeyBoard;

@end

@implementation YJComposeViewController

- (YJEmotionKeyBoard *)emotionKeyBoard {
    if (!_emotionKeyBoard) {
        _emotionKeyBoard = [[YJEmotionKeyBoard alloc] init];
        _emotionKeyBoard.width = self.view.width;
        _emotionKeyBoard.height = 216;
    }
    return _emotionKeyBoard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNavi];
    
    [self setUptextView];
    
    [self setUpToolBar];
    
    [self setUpPhotosView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.textView resignFirstResponder];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 设置导航栏
- (void)setUpNavi {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    NSString *prefix = @"发微博";
    NSString *name = [YJAccountTool loadAccount].username;
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.numberOfLines = 0;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        
        titleView.attributedText = attrStr;
        
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}
#pragma mark - 设置输入TextView
- (void)setUptextView {
    YJEmotionTextView *textView = [[YJEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeHolder = @"分享你的新鲜事...";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    
    self.textView = textView;
    [self.view addSubview:textView];
    //文字改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //键盘改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //表情输入通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:YJEmotionDidSelectNotification object:nil];
    //删除文字通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textWillDelete) name:YJTextWillDeleteNotification object:nil];
}

- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

- (void)keyBoardWillChange:(NSNotification *)notification {
    if (self.switchingKeyBoard) return;
    
    NSDictionary *info = notification.userInfo;
    CGRect endFrame = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    NSUInteger animationType = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        if (endFrame.origin.y > self.view.height) {
            self.composeToolBar.y = self.view.height - self.composeToolBar.height;
        } else {
            self.composeToolBar.y = endFrame.origin.y - self.composeToolBar.height;
        }
    }];
}

- (void)emotionDidSelect:(NSNotification *)notification {
    YJEmotion *oneEmotion = notification.userInfo[YJSelectedEmotion];
    [self.textView insertEmotion:oneEmotion];
}

- (void)textWillDelete {
    [self.textView deleteBackward];
}
#pragma mark - 导航栏『取消』按钮点击事件
- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 导航栏『发送』按钮点击事件
- (void)send {
    if (self.photosView.photos.count) {
        [self sendWithPhotos];
    } else {
        [self sendWithoutPhotos];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送带图片的微博
 */
- (void)sendWithPhotos {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //    带图片的微博
    //    access_token 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    //    status 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
    //    pic 要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。（开放API一次只能传一张图片）
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = [YJAccountTool loadAccount].access_token;
    paras[@"status"] = self.textView.fullText;
    NSLog(@"%@", paras);
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:paras constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //拼接文件数据
        UIImage *firstImage = [self.photosView.photos firstObject];
        NSData *imgData = UIImageJPEGRepresentation(firstImage, 1.0);
        
        [formData appendPartWithFileData:imgData name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}
/**
 *  发送纯文字微博
 */
- (void)sendWithoutPhotos {
    //    纯文字微博
    //    access_token 采用OAuth授权方式为必填参数，OAuth授权后获得。
    //    status 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = [YJAccountTool loadAccount].access_token;
    paras[@"status"] = self.textView.fullText;
    
    [YJHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:paras success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        NSLog(@"send text status error : %@", error);
    }];
}

#pragma mark - 设置键盘的工具条
- (void)setUpToolBar {
    YJComposeToolBar *toolBar = [YJComposeToolBar composeToolBar];
    toolBar.width = self.view.width;
    toolBar.height = 44;
    toolBar.y = self.view.height - toolBar.height;
    toolBar.delegate = self;
    
    self.composeToolBar = toolBar;
    [self.view addSubview:toolBar];
//    self.textView.inputAccessoryView = toolBar;
}
#pragma mark - 设置备选照片显示
- (void)setUpPhotosView {
    YJComposePhotosView *photosView = [[YJComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

#pragma mark - TextView代理协议
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - ComposeToolBar代理协议
- (void)composeToolBar:(YJComposeToolBar *)toolBar didClickButton:(YJComposeToolBtnType)index {
    switch (index) {
        case YJComposeToolBtnTypeCamera:
            [self openCamera];
            break;
            
        case YJComposeToolBtnTypePhoto:
            [self openAlbum];
            break;
            
        case YJComposeToolBtnTypeMention:
            NSLog(@"@");
            break;
            
        case YJComposeToolBtnTypeTrend:
            NSLog(@"#");
            break;
            
        case YJComposeToolBtnTypeEmotion:
            [self switchKeyBoard];
            break;
    }
}
/**
 *  打开相机
 */
- (void)openCamera {
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
/**
 *  打开相册
 */
- (void)openAlbum {
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
/**
 *  打开UIImagePickerController
 *
 *  @param type 要打开的UIImagePickerController类型
 */
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark UIImagePickerController
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *oneImage = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:oneImage];
}
#pragma mark - 切换键盘(重构ComposeToolBar后使用)
- (void)switchKeyBoard {
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyBoard;
        self.composeToolBar.showKeyBoardButton = YES;
    } else {
        self.textView.inputView = nil;
        self.composeToolBar.showKeyBoardButton = NO;
    }
    self.switchingKeyBoard = YES;
    [self.textView resignFirstResponder];
    self.switchingKeyBoard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}

@end
