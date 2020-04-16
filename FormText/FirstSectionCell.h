//
//  FirstSectionCell.h
//  FormText
//
//  Created by ios 001 on 2019/11/25.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDataModel.h"
#import "FormModel.h"
#import "PrefixHeader.pch"
#import "WXZPickTimeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface FirstSectionCell : UITableViewCell<PickTimeViewDelegate>
/** celltypoe */
@property (nonatomic,assign) cellType cellType;
/** labe; */
@property (nonatomic,strong) UILabel *titleLabel;
/** deletaLanbel */
@property (nonatomic,strong) UILabel *detaliLabel;
/**  箭头*/
@property (nonatomic,strong)  UIImageView*arrow;
/** textfile */
@property (nonatomic,strong) UITextField *textfild;
/** <#assign属性注释#> */

@property (nonatomic,strong) CellDataModel *cellDataModel;
/** <#assign属性注释#> */
@property (nonatomic,strong) FormModel *forModel;
/** <#assign属性注释#> */
@property (nonatomic,strong) WXZPickTimeView *pickView;
/** 快速创建Cell */

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath;

-(void)refreshContent:(CellDataModel*)DataModel formModel:(FormModel *)forModel;
@end

NS_ASSUME_NONNULL_END
