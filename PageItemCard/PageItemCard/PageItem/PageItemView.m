//
//  PageItemView.m
//  LiveMall
//
//  Created by BaoBaoDaRen on 2019/9/9.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "PageItemView.h"
#import "PageItem.h"

@interface PageItemView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger columnCount;
    CGFloat headerHeight;
    CGFloat rowHeight;
}
@property (nonatomic, strong) UIView *bgImgView;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, assign) CGRect shownFrame;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy)   SelectPageItem itemSelected;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

static NSString *const cellRes = @"pageItemCellId";

@implementation PageItemView

- (instancetype)initWithFrame:(CGRect)frame fromSuperView:(UIView *)superView sourceDatas:(NSArray *)data columnCount:(NSInteger)columnCount complete:(SelectPageItem)complete
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.itemSelected = complete;
        self.dataArr = data;
        self.pageSectionNum = 3;
        headerHeight = 50;
        columnCount = columnCount;
        self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        rowHeight = 75;
        self.originFrame = CGRectMake(0, -self.frame.size.height-10, self.frame.size.width, self.frame.size.height);
        self.shownFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);

        [self setPageItemViewSubsWithSuperView:superView];
    }
    return self;
}

- (NSArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)setPageItemViewSubsWithSuperView:(UIView *)superView;
{
    self.bgImgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [superView addSubview:self.bgImgView];
    self.bgImgView.backgroundColor = [UIColor blackColor];
    self.bgImgView.alpha = 0.4;
    
    [superView addSubview:self];

    self.pageCollectionView.backgroundColor = [UIColor whiteColor];

    //单击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapsAction:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.bgImgView addGestureRecognizer:tapGesture];
    
    [self showPageItem:YES];

}
- (void)showPageItem:(BOOL)isVisible
{
    if (isVisible == YES) {
        
        self.bgImgView.hidden = NO;
        self.hidden = NO;
        self.pageCollectionView.frame = self.originFrame;
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.pageCollectionView.frame = self.shownFrame;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            self.pageCollectionView.frame = self.originFrame;
        } completion:^(BOOL finished) {
            self.bgImgView.hidden = YES;
            self.hidden = YES;// 或者remove...
        }];
    }
}
- (void)TapsAction:(UIGestureRecognizer *)ges
{
    [self showPageItem:NO];
}

- (UICollectionView *)pageCollectionView
{
    if (!_pageCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.headerReferenceSize = CGSizeMake(self.frame.size.width, headerHeight);
        layout.footerReferenceSize = CGSizeMake(0, 0);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _pageCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _pageCollectionView.showsVerticalScrollIndicator = NO;
        
        [_pageCollectionView registerClass:[PageItem class] forCellWithReuseIdentifier:cellRes];
        [_pageCollectionView registerClass:[PageItemHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];

        _pageCollectionView.dataSource = self;
        _pageCollectionView.delegate = self;
        
        [self addSubview:self.pageCollectionView];

    }
    return _pageCollectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.pageSectionNum;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PageItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellRes forIndexPath:indexPath];
    
    if (self.dataArr.count > 0) {
        
        if (self.selectIndexPath == indexPath) {
            
            [cell doPageSelected:YES];
        } else {
            [cell doPageSelected:NO];
        }
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {
        
        NSArray *headerTitles = @[@"标题一",@"标题二",@"标题三"];
        PageItemHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        if (view == nil) {
            
            view = [[PageItemHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, headerHeight)];
        }
        [view.themeBtn setTitle:[NSString stringWithFormat:@"%@",headerTitles[indexPath.section]] forState:UIControlStateNormal];
        view.backgroundColor = [UIColor whiteColor];
        
        return view;
    } else {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.frame = CGRectZero;
        return view;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/4, rowHeight);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexPath = indexPath;
    [self.pageCollectionView reloadData];
    
    if (self.itemSelected) {
        self.itemSelected(indexPath);
    }
}
- (void)setSourceData:(NSArray *)sourceData{
    
    self.dataArr = sourceData;
    [self.pageCollectionView reloadData];
}
@end


@implementation PageItemHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self PateItemHeaderSubs];
    }
    return self;
}

- (void)PateItemHeaderSubs
{
    self.themeBtn = [[UIButton alloc] init];
    [self addSubview:self.themeBtn];
    [self.themeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.themeBtn.titleLabel.font = CUFont(16);
    [self.themeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.themeBtn.frame = CGRectMake(15, 0, self.frame.size.width - 30, self.frame.size.height);
}
@end



