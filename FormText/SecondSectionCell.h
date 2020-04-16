//
//  SecondSectionCell.h
//  FormText
//
//  Created by ios 001 on 2019/11/26.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataModel.h"
#import "FormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondSectionCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
/** <#assign属性注释#> */
@property (nonatomic,strong) UICollectionView *collectionView;

/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *array;
/** <#assign属性注释#> */
@property (nonatomic,strong) FormModel *formmodel;
// <#属性block#>
@property (nonatomic, copy) void(^openlibrary)(void);
/** 快速创建Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;

-(void)congingCellWithArray:(NSMutableArray *)array AndDadaSourch:(FormModel *)formodel;

@end

NS_ASSUME_NONNULL_END
