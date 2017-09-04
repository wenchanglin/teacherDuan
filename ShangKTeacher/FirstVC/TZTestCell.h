//
//  TZTestCell.h
//  ShangKTeacher
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 Fbw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZTestCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UIButton    *deleteBtn;
@property (nonatomic, assign) NSInteger    row;
@property (nonatomic, strong) id asset;

- (UIView *)snapshotView;

@end
