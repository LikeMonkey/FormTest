//
//  ThirdSectionCell.m
//  FormText
//
//  Created by ios 001 on 2019/11/26.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "ThirdSectionCell.h"
#import "CollectionCell.h"
#import "Masonry.h"
#import "CellDataModel.h"
#import "TZImagePickerController.h"

@implementation ThirdSectionCell

/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    ThirdSectionCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
    
}
-(void)deletaClkick{
    [self.collectionView reloadData];
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
-(void)congingCellWithArray:(CellDataModel *)DataModel AndDadaSourch:(FormModel *)formodel{
    _dataModel = DataModel;
    _formmodel = formodel;
    _array = [formodel valueForKey:DataModel.key];
}
#pragma mark ——— collectiondelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.array.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
    CollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionCell class]) forIndexPath:indexPath];
    [cell refreshContent:_dataModel formModel:_formmodel];
    if (self.array.count>0&&indexPath.row<self.array.count) {
        [cell.backImage setImage:self.array[indexPath.row]];
    }else{
        [cell.backImage setImage:[UIImage imageNamed:@"logo"]];
    }
    cell.index = indexPath;
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
    if (indexPath.row == self.array.count) {
        if (self.openlibrary) {
            self.openlibrary();
        }
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
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        _collectionView.showsHorizontalScrollIndicator=NO;
        //注册
        [_collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}
@end
