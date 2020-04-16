//
//  CollectionCell.m
//  FormText
//
//  Created by ios 001 on 2019/11/26.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "CollectionCell.h"
#import "Masonry.h"
@implementation CollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews {
    [self.contentView addSubview:self.backImage];
    [self.contentView addSubview:self.deleteBtn];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
        
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_offset(0);
        make.height.width.mas_equalTo(15);
    }];
}
-(void)refreshContent:(CellDataModel *)DataModel formModel:(FormModel *)forModel{
    _formodel = forModel;
    _dataModel = DataModel;
    if ([[_formodel valueForKey:_dataModel.key] isKindOfClass:[NSMutableArray class]]) {
        
    }else{
        if ([_formodel valueForKey:_dataModel.key]) {
             [_backImage setImage:[_formodel valueForKey:_dataModel.key]];
        }
    }
    
}
-(void)deleteImage:(UIButton *)sender event:(UIEvent*)event{
    
   
    if ([[_formodel valueForKey:_dataModel.key] isKindOfClass:[NSMutableArray class]]) {
        [_formodel.fifthModelArray removeObjectAtIndex:self.index.row];
    } else {
         [_formodel setValue:
                        [UIImage imageNamed:@"logo"]forKey:_dataModel.key];
    }
//  [[NSNotificationCenter defaultCenter] postNotificationName:@"updatetableView" object:nil userInfo:nil];
   
}
- (UIImageView *)backImage {
    if (!_backImage) {
        _backImage = [[UIImageView alloc]init];
        [_backImage setImage:[UIImage imageNamed:@"logo"]];
    }
    return _backImage;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"x" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = [UIColor redColor];
        [_deleteBtn addTarget:self action:@selector(deleteImage:event:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}
@end

