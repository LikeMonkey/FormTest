//
//  FormModel.m
//  FormText
//
//  Created by ios 001 on 2019/11/25.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "FormModel.h"
#import <objc/runtime.h>

#define kEncodedObjectPath_User ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"user"])

static FormModel *_singleton = nil;
@implementation FormModel



+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([FormModel isLogIn]) {
           _singleton =  [NSKeyedUnarchiver unarchiveObjectWithFile:kEncodedObjectPath_User];
            
        }else{
             _singleton = [[FormModel alloc] init];
        }
       
    });
    return _singleton;
}
- (BOOL)submitCheck:(NSArray*)dataArr
{
    BOOL isSubmit=YES;
    
    if(self.groupName.length==0){
        if (dataArr.count>0) {
            CellDataModel*cellObj=dataArr[0];
            cellObj.errText=@"网店名不能为空";
            NSLog(@"请完善信心");
        }
        isSubmit=NO;
    }
    
    if(self.mainName.length>0){
        if(dataArr.count>0){
            if(self.groupName.length>30){
                CellDataModel *cellObj=dataArr[0];
                cellObj.errText=@"最多30个字";
                isSubmit=NO;
                 NSLog(@"请完善信心");
            }
        }
    }
    
    if(self.thirdName==0){
        if (dataArr.count>1) {
            CellDataModel *cellObj=dataArr[1];
            cellObj.errText=@"标签不能为空";
             NSLog(@"请完善信心");
        }
        isSubmit=NO;
    }
    if(!self.loginOne){
       
             NSLog(@"请完善照片1");
      
        isSubmit=NO;
    }
    if(!self.loginTwo){
          
                NSLog(@"请完善照片2");
         
           isSubmit=NO;
       }
    return isSubmit;
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([FormModel class], &count);
        for (NSInteger index = 0; index<count; index++) {
            Ivar iva = ivar[index];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:strName];
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([FormModel class], &count);
    for (NSInteger index = 0; index <count; index++) {
        Ivar iv = ivar[index];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
}
+ (BOOL)isLogIn
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:kEncodedObjectPath_User];
}


+ (BOOL)logout
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager removeItemAtPath:kEncodedObjectPath_User error:&error];
    if(result==YES){
        NSLog(@"移除成功");
    }
    return result;
}


- (NSMutableArray *)fifthModelArray {
    if (!_fifthModelArray) {
        _fifthModelArray = [NSMutableArray array];
    }
    return _fifthModelArray;
}
@end
