//
//  ViewController.m
//  PageItemCard
//
//  Created by BaoBaoDaRen on 2019/9/9.
//  Copyright © 2019 Boris. All rights reserved.
//

#import "ViewController.h"
#import "PageItemView.h"

@interface ViewController ()

@property (nonatomic, strong) PageItemView *itemsView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *showItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    showItemBtn.frame = CGRectMake(0, 0, 75, 75);
    showItemBtn.center = self.view.center;
    [self.view addSubview:showItemBtn];
    [showItemBtn setTitle:@"显示" forState:UIControlStateNormal];
    showItemBtn.backgroundColor = [UIColor redColor];
    showItemBtn.layer.masksToBounds = YES;
    showItemBtn.layer.cornerRadius = showItemBtn.frame.size.width / 2;

    [showItemBtn addTarget:self action:@selector(showItemsBegin:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)showItemsBegin:(UIButton *)sender
{
    NSArray *data = @[@"热卖",@"食饮",@"家居",@"美妆",@"服饰",@"数码",@"母婴",@"保健",@"箱包",@"户外"];

    self.itemsView = [[PageItemView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) fromSuperView:self.view sourceDatas:data columnCount:4 complete:^(NSIndexPath * _Nonnull currentIndexPath) {
        
        NSLog(@"you have clicked at IndexPath :%@",currentIndexPath);
    }];
    
}


@end
