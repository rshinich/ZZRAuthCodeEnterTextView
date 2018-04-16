//
//  ZZRTextView.h
//  ZZRAuthCodeEnterTextView
//
//  Created by 张忠瑞 on 2018/4/12.
//  Copyright © 2018年 张忠瑞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextDidFinished)(NSString *codeStr);

@protocol ZZRTextViewDelegate <NSObject>

@optional
- (void)ZZRTextViewDidFinishedEdit:(NSString *)codeStr;

@end

@interface ZZRTextView : UIView<ZZRTextViewDelegate>

@property (nonatomic ,copy) TextDidFinished    textFinished;       //完成输入的block
@property (nonatomic ,weak) id<ZZRTextViewDelegate> delegate;      //完成输入的delegate


- (instancetype)initWithFrame:(CGRect)frame CodeSize:(CGSize)size MaxCount:(NSInteger)maxCount;

//设置边框
- (void)setUpBorderWithNormalBorderColor:(UIColor *)normalBorderColor
                    HighlightBorderColor:(UIColor *)highlightBorderColor
                             BorderWidth:(CGFloat)borderColor
                      BorderCornerRadius:(CGFloat)borderCornerRadius;

//设置字体
- (void)setUpTextWithNormalTextColor:(UIColor *)normalTextColor
                  HighlightTextColor:(UIColor *)highlightColor
                            TextFont:(UIFont *)textFont
                       TextAlignment:(NSTextAlignment)alignment
                        KeyboardType:(UIKeyboardType)keyboardType;



@end
