//
//  ViewController.m
//  RSA加密解密.
//
//  Created by 袁海 on 16/8/10.
//  Copyright © 2016年 北京金溪鑫网络科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "CryptorTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self start];
}

- (void)start{
    //创建加密对象
    CryptorTools *tool = [[CryptorTools alloc]init];
    //要加密的内容
    NSString *msg = @"i love you";
    //加载公钥
    NSString *pubPath = [[NSBundle mainBundle] pathForResource:@"rsacert.der" ofType:nil];
    [tool loadPublicKeyWithFilePath:pubPath];
    //使用公钥加密
    NSString *result = [tool RSAEncryptString:msg];
    NSLog(@"加密 = %@",result);
    
    
    //解密
    //加载私钥
    //密码是导出p12密码
    NSString *privatePath = [[NSBundle mainBundle] pathForResource:@"p.p12" ofType:nil];
    [tool loadPrivateKey:privatePath password:@"yuanhai88"];
    //使用私钥解密
    NSString *result2 = [tool RSADecryptString:result];
    NSLog(@"解密 = %@",result2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
