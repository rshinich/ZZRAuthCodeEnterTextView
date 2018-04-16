//
//  ZZRTextView.m
//  ZZRAuthCodeEnterTextView
//
//  Created by 张忠瑞 on 2018/4/12.
//  Copyright © 2018年 张忠瑞. All rights reserved.
//

#import "ZZRTextView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZZRTextView()<UITextViewDelegate>

@property (nonatomic ,strong) UITextView            *textView;
@property (nonatomic ,strong) UIView                *backgroundView;

@property (nonatomic ,assign) NSInteger         maxCount;           //数量

@property (nonatomic ,strong) UIColor          *normalTextColor;          //字体颜色
@property (nonatomic ,strong) UIColor          *highlightTextColor;       //选中字体颜色
@property (nonatomic ,strong) UIColor          *normalBorderColor;        //边框颜色
@property (nonatomic ,strong) UIColor          *highlightBorderColor;     //边框选中颜色


@end

@implementation ZZRTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.textView = [[UITextView alloc] initWithFrame:self.bounds];
        self.textView.tintColor = [UIColor clearColor];
        self.textView.textColor = [UIColor clearColor];
        self.textView.delegate = self;
        self.textView.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:self.textView];
        
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame CodeSize:(CGSize)size MaxCount:(NSInteger)maxCount
{
    self = [self initWithFrame:frame];

    _maxCount = maxCount;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTap)];
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.backgroundView addGestureRecognizer:tapGes];
    [self addSubview:self.backgroundView];
    
    //移除所有subview
    for(UIView *subView in [self.backgroundView subviews])
    {
        [subView removeFromSuperview];
    }
    
    for(NSInteger i = 0 ; i < maxCount ; i ++)
    {
        UILabel *showLabel = [UILabel new];
        showLabel.textAlignment = NSTextAlignmentCenter;
        showLabel.backgroundColor = [UIColor whiteColor];
        showLabel.textColor = [UIColor blackColor];
        showLabel.layer.borderWidth = 1;
        showLabel.layer.borderColor =[UIColor lightGrayColor].CGColor;
        showLabel.layer.cornerRadius = 5;
        showLabel.tag = 1000 + i;
        
        CGFloat space = (frame.size.width - size.width * maxCount)/(maxCount - 1);
        
        showLabel.frame = CGRectMake(i * (size.width + space) , (frame.size.height - size.height)/2.0, size.width, size.height);
        
        [self.backgroundView addSubview:showLabel];
    }

    
    
    return self;
}

#pragma mark -
#pragma mark - setUp

- (void)setUpBorderWithNormalBorderColor:(UIColor *)normalBorderColor
                    HighlightBorderColor:(UIColor *)highlightBorderColor
                             BorderWidth:(CGFloat)borderColor
                      BorderCornerRadius:(CGFloat)borderCornerRadius
{
    self.normalBorderColor = normalBorderColor;
    self.highlightBorderColor = highlightBorderColor;
    
    for(NSInteger i = 0 ; i < _maxCount ; i++)
    {
        UILabel *showLabel = (UILabel *)[self.backgroundView viewWithTag:1000+i];
        showLabel.layer.borderColor = normalBorderColor.CGColor;
        showLabel.layer.borderWidth = borderColor;
        showLabel.layer.cornerRadius =borderCornerRadius;
    }

}

- (void)setUpTextWithNormalTextColor:(UIColor *)normalTextColor
                  HighlightTextColor:(UIColor *)highlightColor
                            TextFont:(UIFont *)textFont
                       TextAlignment:(NSTextAlignment)alignment
                        KeyboardType:(UIKeyboardType)keyboardType
{
    self.textView.keyboardType = keyboardType;
    self.normalTextColor = normalTextColor;
    self.highlightBorderColor = highlightColor;
    
    for(NSInteger i = 0 ; i < _maxCount ; i++)
    {
        UILabel *showLabel = (UILabel *)[self.backgroundView viewWithTag:1000+i];
        showLabel.textColor = normalTextColor;
        showLabel.font = textFont;
        showLabel.textAlignment = alignment;
    }
}


#pragma mark -
#pragma mark - GestureRecognizer

- (void)backgroundViewTap
{
    [self.textView becomeFirstResponder];
    
    NSInteger length = self.textView.text.length;
    UILabel *selectLabel = nil;
    
    if(length == 0)
    {
        selectLabel = (UILabel *)[self.backgroundView viewWithTag:1000];
    }
    else
    {
        selectLabel = (UILabel *)[self.backgroundView viewWithTag:1000 + length - 1];
    }
    
    selectLabel.layer.borderColor = self.highlightBorderColor.CGColor;
    selectLabel.textColor = self.highlightTextColor;

}

#pragma mark -
#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger length = textView.text.length;
    
    //当输入结束后
    if(length == _maxCount)
    {
        //收起键盘
        [self.textView resignFirstResponder];
        
        //回调block
        if(self.textFinished)
        {
            self.textFinished(textView.text);
        }
        
        //回调代理
        if(self.delegate && [self.delegate respondsToSelector:@selector(ZZRTextViewDidFinishedEdit:)])
        {
            [self.delegate ZZRTextViewDidFinishedEdit:textView.text];
        }
    }
    
    //清空状态
    for(NSInteger i = 0 ; i < _maxCount ; i++)
    {
        UILabel *showLabel = (UILabel *)[self.backgroundView viewWithTag:1000+i];
        showLabel.text = @"";
        showLabel.layer.borderColor = self.normalBorderColor.CGColor;
        showLabel.textColor = self.normalTextColor;
    }
    
    //设置当前高亮
    UILabel *selectLabel = (UILabel *)[self.backgroundView viewWithTag:1000 + length];
    selectLabel.layer.borderColor = self.highlightBorderColor.CGColor;
    selectLabel.textColor = self.highlightTextColor;
    
    //设置label内容
    for(NSInteger i = 0 ; i < length ; i++)
    {
        UILabel *showLabel = (UILabel *)[self.backgroundView viewWithTag:1000+i];
        NSString *subString = [textView.text substringWithRange:NSMakeRange(i, 1)];
        showLabel.text = subString;
    }
    
}


@end
