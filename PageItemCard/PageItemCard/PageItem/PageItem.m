//
//  PageItem.m
//  LiveMall
//
//  Created by BaoBaoDaRen on 2019/9/9.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "PageItem.h"

@interface PageItem ()
{
    UIColor *unselectedColor;
    UIColor *selectedColor;
}
@end

@implementation PageItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        unselectedColor = [UIColor whiteColor];
        selectedColor   = [UIColor redColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setPageItemSubs];
    }
    return self;
}

- (void)setPageItemSubs
{
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:self.bgView];
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = unselectedColor.CGColor;

    self.imgV = [[UIImageView alloc] init];
    [self.bgView addSubview:self.imgV];
    self.imgV.backgroundColor = [UIColor lightGrayColor];
    
    self.titLab = [[UILabel alloc] init];
    [self.bgView addSubview:self.titLab];
    self.titLab.textAlignment = NSTextAlignmentCenter;
    self.titLab.textColor = [UIColor lightGrayColor];
    self.titLab.font = [UIFont systemFontOfSize:14];
    self.titLab.text = @"写个标题";
    self.titLab.adjustsFontSizeToFitWidth = YES;
    
}
- (void)doPageSelected:(BOOL)isSelected
{
    if (isSelected) {
        self.bgView.layer.borderColor = selectedColor.CGColor;
    } else {
        self.bgView.layer.borderColor = unselectedColor.CGColor;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imgWH = 30;
    CGFloat topM = 5;
    CGFloat leftM = 15;
    CGFloat labH = 25;
    self.bgView.frame = CGRectMake(leftM, topM, self.contentView.frame.size.width - leftM * 2, self.contentView.frame.size.height - topM * 2);
    self.bgView.center = self.contentView.center;
    self.imgV.frame = CGRectMake(self.bgView.frame.size.width / 2 - imgWH / 2, topM, imgWH, imgWH);
    self.titLab.frame = CGRectMake(0, imgWH + topM + 5, self.bgView.frame.size.width, labH);
}

@end
