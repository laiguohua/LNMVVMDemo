//
//  LNTabelDemoDelegateModel.m
//  LNMVVMDemo
//
//  Created by Mr.lai on 2018/9/26.
//  Copyright © 2018年 Mr.lai. All rights reserved.
//

#import "LNTabelDemoDelegateModel.h"

#import <Masonry/Masonry.h>

#import "YYFPSLabel.h"


@interface LNTabelDemoDelegateModel()

@property (nonatomic,strong)YYFPSLabel *fpsLabel;

@end

@implementation LNTabelDemoDelegateModel

- (void)ln_delegateConfig{
    _fpsLabel = [YYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.alpha = 0;
    [self.weakTableView.superview addSubview:_fpsLabel];
    [_fpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weakTableView.superview.mas_left).offset(15);
        make.bottom.equalTo(self.weakTableView.superview.mas_bottom).offset(-20);
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
}


@end
