//
//  CellDataModel.h
//  FormText
//
//  Created by ios 001 on 2019/11/25.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixHeader.pch"
//定义枚举类型
typedef enum cellType {
    NomalCellType  = 0,
    SelectCellType,
} cellType;
NS_ASSUME_NONNULL_BEGIN

@interface CellDataModel : NSObject
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *title;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *placeHolder;
/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *key;
/**  */
@property (nonatomic,copy) NSString *errText;
/** <#assign属性注释#> */
@property (nonatomic,assign) cellType cellType;
/** <#assign属性注释#> */
@property (nonatomic,assign) NSInteger  maxInputLength;
/** de */
@property (nonatomic,copy) NSString *detailLabel;
/** <#assign属性注释#> */

@property (nonatomic,strong) UIImage *image;

/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *fifthModelArray;

@end

NS_ASSUME_NONNULL_END
