//
//  ViewController.m
//  FormText
//
//  Created by ios 001 on 2019/11/25.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "ViewController.h"
#import "FirstSectionCell.h"
#import "SecondSectionCell.h"
#import "ThirdSectionCell.h"
#import "FormModel.h"
#import "Masonry.h"
#import "TZImagePickerController.h"
#import "MJExtension.h"
#define kEncodedObjectPath_User ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"user"])
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
/** tableView */
@property (nonatomic,strong) UITableView *tableView;
/** shuju */
@property (nonatomic,strong) NSMutableArray *tableViewData;

/** <#assign属性注释#> */
@property (nonatomic,strong) FormModel *formModel;

/** <#assign属性注释#> */
@property (nonatomic,assign) CGFloat CellHeight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //注册
    [center addObserver:self selector:@selector(deletaClkick) name:@"updatetableView" object:nil];
   
   
    _formModel = [FormModel sharedManager];
   
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(backbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(-100);
        make.height.width.mas_equalTo(100);
    }];
}
-(void)backbtnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([FormModel logout]) {
            NSLog(@"退出了--------");
        }
    }];
}
-(void)deletaClkick{
    [self.tableView reloadData];
}
-(void)initDataSource{
    
    _tableViewData = [NSMutableArray array];
    CellDataModel *nameModel = [[CellDataModel alloc] init];
    nameModel.title = @"网店名称";
    nameModel.placeHolder = @"请输入网店名称";
    nameModel.key = @"groupName";
    nameModel.cellType = NomalCellType;
    nameModel.maxInputLength = 10;
    nameModel.detailLabel = @"请选择";
    [_tableViewData addObject:nameModel];
    
    CellDataModel *mainModel = [[CellDataModel alloc] init];
       mainModel.title = @"主要名称";
       mainModel.placeHolder = @"请输称";
       mainModel.key = @"mainName";
       mainModel.detailLabel = @"请选择";
       mainModel.cellType = NomalCellType;
       mainModel.maxInputLength = 10;
       [_tableViewData addObject:mainModel];
    

    CellDataModel *thirdModel = [[CellDataModel alloc] init];
       thirdModel.title = @"第三名称";
       thirdModel.placeHolder = @"请输入网称";
       thirdModel.key = @"thirdName";
       thirdModel.cellType = NomalCellType;
       thirdModel.maxInputLength =10;
       [_tableViewData addObject:thirdModel];
    CellDataModel *firstModel = [[CellDataModel alloc] init];
          firstModel.title = @"第三名称";
          firstModel.key = @"loginOne";
          firstModel.image = [UIImage imageNamed:@"logo"];
     
         
    CellDataModel *secondModel = [[CellDataModel alloc] init];
          secondModel.title = @"第三名称";
          secondModel.key = @"loginTwo";
          secondModel.image = [UIImage imageNamed:@"logo"];
          NSMutableArray *array = [NSMutableArray array];
    [array addObject:firstModel];
    [array addObject:secondModel];
        [_tableViewData addObject:array];
    CellDataModel *fourthModel = [[CellDataModel alloc] init];
    fourthModel.title = @"选择器";
    fourthModel.detailLabel = @"请选择";
    fourthModel.key = @"fourthModel";
    fourthModel.cellType = SelectCellType;
    fourthModel.maxInputLength =10;
   
       [_tableViewData addObject:fourthModel];
    
    CellDataModel *fifthModel = [[CellDataModel alloc] init];
    fifthModel.key = @"fifthModelArray";
    [_tableViewData addObject:fifthModel];
    
    
    if (_tableView) {
        [_tableView reloadData];
    }
}

#pragma mark 相册 ~
-(void)openCamaraLibrary {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1  delegate:self];
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.naviBgColor = [UIColor whiteColor];
    imagePickerVc.naviTitleColor = [UIColor blackColor];
    imagePickerVc.needShowStatusBar = YES;
    imagePickerVc.barItemTextColor = [UIColor blackColor];
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.maxImagesCount = 1;
    imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    if(_formModel.indexPath.row<=4&&_formModel.indexPath){
          NSMutableArray *araay = _tableViewData[3];
            CellDataModel *model = araay[_formModel.indexPath.row];
        //    self.tableViewData valueForKey:<#(nonnull NSString *)#>
        //    NSString *key = [@(self.currentThumbIndex) stringValue];
        //    self.cerThumbsDic[key] = photos.firstObject;
        //    [self.myTableView reloadData];
             [_formModel setValue:photos.firstObject forKey:model.key];
    }else{
         CellDataModel *model = _tableViewData[5];
        [_formModel.fifthModelArray addObject:photos.firstObject];
        [_formModel setValue:_formModel.fifthModelArray forKey:model.key];
        ThirdSectionCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
//        [cell congingCellWithArray:model AndDadaSourch:_formModel];
        [cell.collectionView reloadData];
        
    }
     
     [self.tableView reloadData];
}

#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=3 && indexPath.row!=5) {
          CellDataModel *cellDataModel = _tableViewData[indexPath.row];
           
              FirstSectionCell *cell=[FirstSectionCell cellWithTableView:tableView withIdentifier:NSStringFromClass( [FirstSectionCell class]) indexPath:indexPath];
           if (!cell) {
               cell = [[FirstSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass( [FirstSectionCell class])];
           }
             [cell refreshContent:cellDataModel formModel:_formModel];
        return cell;
    }else if(indexPath.row == 3){
        NSMutableArray *araay = _tableViewData[indexPath.row];
        SecondSectionCell *cell = [SecondSectionCell cellWithTableView:tableView withIdentifier:NSStringFromClass([SecondSectionCell class]) indexPath:indexPath];
        [cell congingCellWithArray:araay AndDadaSourch:_formModel];
        cell.openlibrary = ^{
            [self openCamaraLibrary];
        
        };
        
        return cell;
    }else{
        CellDataModel *cellDataModel = _tableViewData[indexPath.row];
        ThirdSectionCell *cell  = [ThirdSectionCell cellWithTableView:tableView withIdentifier:NSStringFromClass([ThirdSectionCell class]) indexPath:indexPath];
        [cell congingCellWithArray:cellDataModel AndDadaSourch:_formModel];
        cell.openlibrary = ^{
        [self openCamaraLibrary];
            };
//        [cell.collectionView reloadData];
//        [cell.collectionView layoutIfNeeded];
//        self.CellHeight =cell.collectionView.collectionViewLayout.collectionViewContentSize.height;
//        [self tableView:tableView heightForRowAtIndexPath:indexPath];
        return cell;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        return 80;
    }else if(indexPath.row == 5) {
        return 100;
    }else{
        CellDataModel *cellDataModel = _tableViewData[indexPath.row];
          
          switch (cellDataModel.cellType) {
              case 0:
                  return 80;
                  break;
              case 1:
                  return 60;
              break;
              default:
                  break;
          }
    }
  
}
#pragma mark ——— lazy

-(UITableView *)tableView {
    
    if(!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.delegate =self;
        
        _tableView.dataSource =self;
        
        [_tableView registerClass:[FirstSectionCell class] forCellReuseIdentifier:NSStringFromClass([FirstSectionCell class])];
        [_tableView registerClass:[SecondSectionCell class] forCellReuseIdentifier:NSStringFromClass([SecondSectionCell class])];
        
        [_tableView registerClass:[ThirdSectionCell class] forCellReuseIdentifier:NSStringFromClass([ThirdSectionCell class])];
               
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.backgroundColor = [UIColor redColor];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 199, 80)];
        [view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(view);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(40);
        }];
        _tableView.tableFooterView = view;
    
  
    }
    return _tableView;
    
}
-(void)btnClick:(UIButton *)sender{
  
        if (![_formModel submitCheck:_tableViewData]) {
                return;
        }else{
            NSMutableDictionary *dic = [_formModel mj_keyValues];
            NSLog(@"++++++++++%@,",dic);
         [NSKeyedArchiver archiveRootObject:_formModel toFile:kEncodedObjectPath_User];
        }

}

@end
