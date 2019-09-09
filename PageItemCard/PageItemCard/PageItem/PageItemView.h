//
//  PageItemView.h
//  LiveMall
//
//  Created by BaoBaoDaRen on 2019/9/9.
//  Copyright © 2019 Boris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageItemHeader : UICollectionReusableView

@property (nonatomic, strong) UIButton *themeBtn;

@end

@interface PageItemView : UIView

@property (nonatomic, strong) UICollectionView *pageCollectionView;

@property (nonatomic, assign) NSInteger pageSectionNum;

@property (nonatomic, strong) NSArray *sourceData;

typedef void (^SelectPageItem)(NSIndexPath *currentIndexPath);

/**
 数据列表
 @param frame 数据显示区域
 @param superView 数据和阴影的父视图
 @param data 数据
 @param columnCount 显示几列
 @param complete 点击某个数据
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame fromSuperView:(UIView *)superView sourceDatas:(NSArray *)data columnCount:(NSInteger)columnCount complete:(SelectPageItem)complete;

@end

NS_ASSUME_NONNULL_END
