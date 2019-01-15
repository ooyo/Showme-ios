//
//  YSLScrollMenuView.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLScrollMenuView.h"



static const CGFloat kYSLScrollMenuViewMargin = 2;
static const CGFloat kYSLIndicatorHeight = 3;

@interface YSLScrollMenuView ()


@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation YSLScrollMenuView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default
        _viewbackgroudColor = [UIColor whiteColor];
        _itemfont = [UIFont fontWithName:@"Roboto-Thin" size:15.0];

        _itemTitleColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0];
        _itemSelectedTitleColor = [UIColor colorWithRed:51.0f/255.0f green:204.0f/255.0f blue:153.0f/255.0f alpha:1.0];
        _itemIndicatorColor = [UIColor colorWithRed:51.0f/255.0f green:204.0f/255.0f blue:153.0f/255.0f alpha:1.0];
        
        self.backgroundColor = _viewbackgroudColor;
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
        kYSLScrollMenuViewWidth =[[UIScreen mainScreen] bounds].size.width / 3;
    return self;
}

#pragma mark -- Setter

- (void)setViewbackgroudColor:(UIColor *)viewbackgroudColor
{
    if (!viewbackgroudColor) { return; }
    _viewbackgroudColor = viewbackgroudColor;
    self.backgroundColor = viewbackgroudColor;
}

- (void)setItemfont:(UIFont *)itemfont
{
    if (!itemfont) { return; }
    _itemfont = itemfont;
    for (UIButton *label in _itemTitleArray) {
        label.titleLabel.font = itemfont;
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    if (!itemTitleColor) { return; }
    _itemTitleColor = itemTitleColor;
    for (UIButton *label in _itemTitleArray) {
        [label setTitleColor:itemTitleColor forState:UIControlStateNormal];
    }
}

- (void)setItemIndicatorColor:(UIColor *)itemIndicatorColor
{
    if (!itemIndicatorColor) { return; }
    _itemIndicatorColor = itemIndicatorColor;
    _indicatorView.backgroundColor = itemIndicatorColor;
}

- (void)setItemTitleArray:(NSArray *)itemTitleArray
{
    
    if (_itemTitleArray != itemTitleArray) {
        _itemTitleArray = itemTitleArray;
        NSMutableArray *views = [NSMutableArray array];
        for (int i = 0; i < itemTitleArray.count; i++) {
            
            // Values are fractional -- you should take the ceilf to get equivalent values
          //  CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
            
            CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
            
            //CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
            UIButton *itemView = [[UIButton alloc] initWithFrame:frame];
              [self.scrollView addSubview:itemView];
          
            itemView.tag = i;
            [itemView setTitle:itemTitleArray[i] forState:UIControlStateNormal ];
              [itemView sizeToFit];
            itemView.userInteractionEnabled = YES;
            itemView.backgroundColor = [UIColor clearColor];
            itemView.titleLabel.textAlignment = NSTextAlignmentCenter;
            itemView.titleLabel.font = self.itemfont;
            itemView.titleLabel.adjustsFontSizeToFitWidth =YES;
            itemView.titleLabel.minimumScaleFactor = 0.5;
            [itemView setTitleColor:_itemTitleColor forState:UIControlStateNormal];
          
            [itemView  setImageEdgeInsets:UIEdgeInsetsMake(0, -15, -5, 0)];
            [itemView setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
            if([itemTitleArray[i] isEqualToString:@"Бүгд"]){
             [itemView setImage:[UIImage imageNamed:@"coupon_all"] forState:UIControlStateNormal];
            }else if([itemTitleArray[i] isEqualToString:@"GG Купон"]){
                 [itemView setImage:[UIImage imageNamed:@"coupon_gg"] forState:UIControlStateNormal];
            }else if([itemTitleArray[i] isEqualToString:@"Энгийн купон"]){
                 [itemView setImage:[UIImage imageNamed:@"coupon_simple"] forState:UIControlStateNormal];
            }else if([itemTitleArray[i] isEqualToString:@"list"]){
                [itemView setImage:[UIImage imageNamed:@"tab_list"] forState:UIControlStateNormal];
                [itemView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [itemView setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
//                [itemView setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
            }else if([itemTitleArray[i] isEqualToString:@"grid"]){
                [itemView setImage:[UIImage imageNamed:@"tab_grid"] forState:UIControlStateNormal];
                [itemView setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [itemView setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
                //                [itemView setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];

            }else{
             [itemView setImage:[UIImage imageNamed:@"tab_gg_coupon"] forState:UIControlStateNormal];
            }
            
           
            
            [views addObject:itemView];

           
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemViewTapAction:)];
            [itemView addGestureRecognizer:tapGesture];
         //   [imageView addGestureRecognizer:tapGesture];
        }
        

        self.itemViewArray = [NSArray arrayWithArray:views];
         // indicator
        _indicatorView = [[UIView alloc]init];
        _indicatorView.frame = CGRectMake(10, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
        _indicatorView.backgroundColor = self.itemIndicatorColor;
        [_scrollView addSubview:_indicatorView];
        
    }
}

#pragma mark -- public

- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex
{
    CGFloat indicatorX = 0.0;
    if (isNextItem) {
        indicatorX = ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * ratio ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    } else {
        indicatorX =  ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * (1 - ratio) ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    }
    
    if (indicatorX < kYSLScrollMenuViewMargin || indicatorX > self.scrollView.contentSize.width - (kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth)) {
        return;
    }
    _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
     // NSLog(@"retio : %f",_indicatorView.frame.origin.x);
}

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex
{
    if (itemTextColor) { _itemTitleColor = itemTextColor; }
    if (selectedItemTextColor) { _itemSelectedTitleColor = selectedItemTextColor; }
    
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UIButton *label = self.itemViewArray[i];
         if (i == currentIndex) {
            label.alpha = 0.0;
             [UIView animateWithDuration:0.75
                                  delay:0.0
                                options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 label.alpha = 1.0;
                                 [label setTitleColor:_itemSelectedTitleColor forState:UIControlStateNormal];
                                } completion:^(BOOL finished) {
                             }];
             if([label.titleLabel.text isEqualToString:@"Бүгд"]){
                 [label setImage:[UIImage imageNamed:@"coupon_all_sel"] forState:UIControlStateNormal];
             }else if([label.titleLabel.text isEqualToString:@"GG Купон"]){
                 [label setImage:[UIImage imageNamed:@"coupon_gg_sel"] forState:UIControlStateNormal];
             }else if([label.titleLabel.text isEqualToString:@"Энгийн купон"]){
                 [label setImage:[UIImage imageNamed:@"coupon_simple_sel"] forState:UIControlStateNormal];
             }else if([label.titleLabel.text isEqualToString:@"list"]){
                 [label setImage:[UIImage imageNamed:@"tab_list_sel"] forState:UIControlStateNormal];
                 [label setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                 
             }else if([label.titleLabel.text isEqualToString:@"grid"]){
                 [label setImage:[UIImage imageNamed:@"tab_grid_sel"] forState:UIControlStateNormal];
                 [label setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
             }else{
                 [label setImage:[UIImage imageNamed:@"tab_gg_coupon_sel"] forState:UIControlStateNormal];
             }
             
        } else {
            [label setTitleColor:_itemTitleColor forState:UIControlStateNormal];
            if([label.titleLabel.text isEqualToString:@"Бүгд"]){
                [label setImage:[UIImage imageNamed:@"coupon_all"] forState:UIControlStateNormal];
            }else if([label.titleLabel.text isEqualToString:@"GG Купон"]){
                [label setImage:[UIImage imageNamed:@"coupon_gg"] forState:UIControlStateNormal];
            }else if([label.titleLabel.text isEqualToString:@"Энгийн купон"]){
                [label setImage:[UIImage imageNamed:@"coupon_simple"] forState:UIControlStateNormal];
            }else if([label.titleLabel.text isEqualToString:@"list"]){
                [label setImage:[UIImage imageNamed:@"tab_list"] forState:UIControlStateNormal];
                  [label setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            }else if([label.titleLabel.text isEqualToString:@"grid"]){
                [label setImage:[UIImage imageNamed:@"tab_grid"] forState:UIControlStateNormal];
                  [label setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            }else{
                [label setImage:[UIImage imageNamed:@"tab_gg_coupon"] forState:UIControlStateNormal];
            }
         
        }
    }
}

#pragma mark -- private

// menu shadow
- (void)setShadowView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = kYSLScrollMenuViewMargin;
    for (NSUInteger i = 0; i < self.itemViewArray.count; i++) {
        CGFloat width = kYSLScrollMenuViewWidth;
        UIView *itemView = self.itemViewArray[i];
        itemView.frame = CGRectMake(x, 0, width, self.scrollView.frame.size.height);
        x += width + kYSLScrollMenuViewMargin;
    }
    
    self.scrollView.contentSize = CGSizeMake(x, self.scrollView.frame.size.height);
    
    CGRect frame = self.scrollView.frame;
    if (self.frame.size.width > x) {
        frame.origin.x = (self.frame.size.width - x) / 2;
        frame.size.width = x;
    } else {
        frame.origin.x = 0;
        frame.size.width = self.frame.size.width;
    }
    self.scrollView.frame = frame;
}

#pragma mark -- Selector --------------------------------------- //
- (void)itemViewTapAction:(UITapGestureRecognizer *)Recongnizer
{
  
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:[(UIGestureRecognizer*) Recongnizer view].tag];
    }
}

@end
