//
//  FormModel.h
//  FormText
//
//  Created by ios 001 on 2019/11/25.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellDataModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FormModel : NSObject
@property (nonatomic, copy)NSString         *groupId;
@property (nonatomic, copy)NSString         *groupName;
@property (nonatomic, copy)NSString         *mainName;
@property (nonatomic, copy)NSString         *thirdName;

@property (nonatomic, copy)NSString         *loginOne;
@property (nonatomic, copy)NSString         *loginTwo;

/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *imageArray;

/** <#assign属性注释#> */
@property (nonatomic,strong) NSIndexPath *indexPath;

/** <#copy属性注释#> */
@property (nonatomic,copy) NSString *fourthModel;

/** <#assign属性注释#> */
@property (nonatomic,strong) NSMutableArray *fifthModelArray;


-(BOOL)submitCheck:(NSArray*)dataArr;
+(instancetype)sharedManager;
+ (BOOL)logout;
+ (BOOL)isLogIn;

@end


NS_ASSUME_NONNULL_END
