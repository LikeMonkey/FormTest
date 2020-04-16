//
//  SecondSectionCell.m
//  FormText
//
//  Created by ios 001 on 2019/11/26.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "SecondSectionCell.h"
#import "CollectionCell.h"
#import "Masonry.h"
#import "CellDataModel.h"
#import "TZImagePickerController.h"
@implementation SecondSectionCell

/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    SecondSectionCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}
-(void)congingCellWithArray:(NSMutableArray *)array AndDadaSourch:(FormModel *)formodel{
    _array = array;
    _formmodel = formodel;
    [self.collectionView reloadData];
}
#pragma mark ——— collectiondelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    CollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionCell class]) forIndexPath:indexPath];
  
         CellDataModel*dataModel =self.array[indexPath.row];
        [cell refreshContent:dataModel formModel:_formmodel];
    return cell;
}

//列
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
    
}
//行
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _formmodel.indexPath = indexPath;
        if (self.openlibrary) {
            self.openlibrary();
        }
}


#pragma mark ——— collcetion
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/3, 100);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.scrollEnabled=YES;
       
        _collectionView.pagingEnabled = YES;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        _collectionView.showsHorizontalScrollIndicator=NO;
        //注册
        [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}
@end
