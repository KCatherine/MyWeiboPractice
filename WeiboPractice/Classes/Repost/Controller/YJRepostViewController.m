//
//  YJRepostViewController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/2/14.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "YJRepostViewController.h"
#import "YJAccountTool.h"
#import "YJEmotionTextView.h"
#import "YJComposeToolBar.h"
#import "YJEmotionKeyBoard.h"
#import "YJEmotion.h"
#import "YJStatusModel.h"
#import "YJUserModel.h"

#import "YJHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface YJRepostViewController ()<UITextViewDelegate, YJComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**
 *  文字输入框
 */
@property (nonatomic, weak) YJEmotionTextView *textView;
/**
 *  键盘工具条
 */
@property (nonatomic, weak) YJComposeToolBar *composeToolBar;
/**
 *  表情键盘
 */
@property (nonatomic, strong) YJEmotionKeyBoard *emotionKeyBoard;

@property (nonatomic, assign) BOOL switchingKeyBoard;
/**
 *  需要转发的微博
 */
@property (nonatomic, strong) YJStatusModel *status;

@end

@implementation YJRepostViewController

- (instancetype)initWithStatusModel:(YJStatusModel *)status {
    if (self = [super init]) {
        _status = status;
    }
    return self;
}

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
    
    [self setUpRepostStatus];
}

- (void)viewWillAppear:(BOOL)animated {
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
    
    NSString *prefix = @"转发微博";
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
    textView.placeHolder = @"说说分享心得...";
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;

    if (self.status.retweeted_status) {
        textView.text = [NSString stringWithFormat:@" //@%@:%@",self.status.user.name , self.status.text];
    }
    textView.selectedRange = NSMakeRange(0, 0);
    
    self.textView = textView;
    [self.view addSubview:textView];
    //键盘改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //表情输入通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:YJEmotionDidSelectNotification object:nil];
    //删除文字通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textWillDelete) name:YJTextWillDeleteNotification object:nil];
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
    [self repost];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  发送纯文字微博
 */
- (void)repost {
    //    转发微博
    //    access_token 采用OAuth授权方式为必填参数，OAuth授权后获得。
    //    id 要转发的微博ID。
    //    status 添加的转发文本，必须做URLencode，内容不超过140个汉字，不填则默认为“转发微博”。
    //    is_comment 是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0 。
    
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"access_token"] = [YJAccountTool loadAccount].access_token;
    paras[@"id"] = self.status.idstr;
    paras[@"status"] = self.textView.fullText;
    
    [YJHttpTool POST:@"https://api.weibo.com/2/statuses/repost.json" parameters:paras success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"转发成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"转发失败"];
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
}
#pragma mark - 设置被转发微博的显示
- (void)setUpRepostStatus {
    
}

#pragma mark - TextView代理协议
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - ComposeToolBar代理协议
- (void)composeToolBar:(YJComposeToolBar *)toolBar didClickButton:(YJComposeToolBtnType)index {
    switch (index) {
        case YJComposeToolBtnTypeCamera:
            NSLog(@"打开相机");
            break;
            
        case YJComposeToolBtnTypePhoto:
            NSLog(@"打开相册");
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
