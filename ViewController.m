//
//  ViewController.m
//  ZZRAuthCodeEnterTextView
//
//  Created by 张忠瑞 on 2018/4/12.
//  Copyright © 2018年 张忠瑞. All rights reserved.
//

#import "ViewController.h"
#import "ZZRTextView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<ZZRTextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    ZZRTextView *textView = [[ZZRTextView alloc] initWithFrame:CGRectMake(10, 100, WIDTH-20, 50) CodeSize:CGSizeMake(50, 50) MaxCount:6];
    
    [textView setUpBorderWithNormalBorderColor:[UIColor lightGrayColor]
                          HighlightBorderColor:[UIColor darkGrayColor]
                                   BorderWidth:1.0
                            BorderCornerRadius:5.0];
    
    [textView setUpTextWithNormalTextColor:[UIColor blackColor]
                        HighlightTextColor:[UIColor blackColor]
                                  TextFont:[UIFont systemFontOfSize:20]
                             TextAlignment:NSTextAlignmentCenter
                              KeyboardType:UIKeyboardTypeNumberPad];
    
    
    textView.delegate = self;
    textView.textFinished = ^(NSString *codeStr){
      
        NSLog(@"block out -- %@",codeStr);
    };
    
    
    [self.view addSubview:textView];
}

- (void)ZZRTextViewDidFinishedEdit:(NSString *)codeStr
{
    NSLog(@"delegate out -- %@",codeStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
