//
//  YJOAuthController.m
//  WeiboPractice
//
//  Created by 杨璟 on 16/1/30.
//  Copyright © 2016年 杨璟. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "YJOAuthController.h"
#import "YJAccountModel.h"
#import "YJAccountTool.h"

#import "YJHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface YJOAuthController ()<UIWebViewDelegate>

@end

@implementation YJOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *OAuthView = [[UIWebView alloc] init];
    OAuthView.frame = self.view.bounds;
    OAuthView.delegate = self;
    [self.view addSubview:OAuthView];
    
//    client_id 申请应用时分配的AppKey。
//    redirect_uri 授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", YJAppKey, YJRedirectURL];
    NSURL *requestURL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    [OAuthView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    //查找授权标记的code
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code {
//    client_id 申请应用时分配的AppKey。（新注册时可调整）
//    client_secret 申请应用时分配的AppSecret。（新注册时可调整）
//    grant_type 请求的类型，填写authorization_code
//    code	true 调用authorize获得的code值。
//    redirect_uri 回调地址，需需与注册应用里的回调地址一致。
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"client_id"] = YJAppKey;
    paras[@"client_secret"] = YJAppSecret;
    paras[@"grant_type"] = @"authorization_code";
    paras[@"code"] = code;
    paras[@"redirect_uri"] = YJRedirectURL;
    
    //使用包装AFN的工具类发送HTTP请求
    [YJHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:paras success:^(id _Nullable responseObject) {
        [MBProgressHUD hideHUD];
//        access_token 用于调用access_token，接口获取授权后的access token。
//        expires_in access_token的生命周期，单位是秒数。
//        remind_in access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
//        uid 当前授权用户的UID。
        YJAccountModel *accountModel = [YJAccountModel accountModelWithDict:responseObject];
        [YJAccountTool saveAccount:accountModel];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@", error);
    }];
}

@end
