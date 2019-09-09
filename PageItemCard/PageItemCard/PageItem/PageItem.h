//
//  PageItem.h
//  LiveMall
//
//  Created by BaoBaoDaRen on 2019/9/9.
//  Copyright © 2019 Boris. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageItem : UICollectionViewCell

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imgV;
@property (nonatomic, strong) UILabel *titLab;

- (void)doPageSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
