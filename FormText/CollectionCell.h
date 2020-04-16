//
//  CollectionCell.h
//  FormText
//
//  Created by ios 001 on 2019/11/26.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataModel.h"
#import "FormModel.h"
typedef void(^deleteBlcok)(CellDataModel * _Nonnull dataModel);
NS_ASSUME_NONNULL_BEGIN

@interface CollectionCell : UICollectionViewCell
/** <#assign属性注释#> */
@property (nonatomic,strong) UIImageView *backImage;
/** <#assign属性注释#> */
@property (nonatomic,strong) UIButton *deleteBtn;
/** <#assign属性注释#> */
@property (nonatomic,strong) CellDataModel *dataModel;
/** <#assign属性注释#> */
@property (nonatomic,strong) FormModel *formodel;
/** <#assign属性注释#> */
@property (nonatomic,strong) NSIndexPath *index;

-(void)refreshContent:(CellDataModel*)DataModel formModel:(FormModel *)forModel ;
@end

NS_ASSUME_NONNULL_END
