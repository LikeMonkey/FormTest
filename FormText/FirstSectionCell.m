//
//  FirstSectionCell.m
//  FormText
//
//  Created by ios 001 on 2019/11/25.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "FirstSectionCell.h"
#import "Masonry.h"
#import "WXZPickTimeView.h"

@implementation FirstSectionCell
/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    FirstSectionCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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

-(void)refreshContent:(CellDataModel*)DataModel formModel:(FormModel *)forModel{
    [self clearCellData];
    if(!DataModel){
        return;
    }
    _cellDataModel = DataModel;
    _forModel = forModel;
    _titleLabel.text = DataModel.title;
    _textfild.placeholder = DataModel.placeHolder;
    _textfild.text = [_forModel valueForKey:DataModel.key];
    _cellType = DataModel.cellType;

       switch (_cellType) {
           case 0:
               self.detaliLabel.hidden = YES;
                self.arrow.hidden = YES;
               if ([_textfild.placeholder isEqualToString:@"请输入网店名称"]) {
                   _textfild.keyboardType = UIKeyboardTypeNumberPad;
                   UIView *view = [[UIView alloc]initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
                   view.backgroundColor =[ UIColor redColor];
                   _textfild.inputAccessoryView = view;
               } else if([_textfild.placeholder isEqualToString:@"请输称"]){
                   _textfild.keyboardType = UIKeyboardTypeDefault;
               }else{
                   _textfild.keyboardType = UIKeyboardTypeEmailAddress;
               }
               break;

            case 1:
                self.textfild.hidden = YES;
                [self createPickerView]; // 创建pickView
               if (_forModel.fourthModel.length>0) {
                   _detaliLabel.text = [_forModel valueForKey:DataModel.key];
               }else{
                   _detaliLabel.text = DataModel.detailLabel;
               }
               break;
           default:
               break;
       }
    
    
}
-(void)createPickerView
{
    if (!_pickView) {
         WXZPickTimeView *pickerArea = [[WXZPickTimeView alloc]init];
          
          [pickerArea setDelegate:self];
          
          [pickerArea setDefaultHour:14 defaultMinute:20];
           _pickView = pickerArea;
    }

}
-(void)pickerTimeView:(WXZPickTimeView *)pickerTimeView selectHour:(NSInteger)hour selectMinute:(NSInteger)minute{
    NSLog(@"选择的时间：%ld %ld",hour,minute);
    [_forModel setValue:[NSString stringWithFormat:@"%ld时%ld分",hour,minute] forKey:_cellDataModel.key];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updatetableView" object:nil userInfo:nil];
}
- (void)clearCellData
{
    _detaliLabel.text = @"";
    _textfild.text = @"";
    _textfild.placeholder = @"";
}
-(void)tapClick{
    [_pickView show];
}
//-textfild
-(void)setUpView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detaliLabel];
    [self.contentView addSubview:self.arrow];
    [self.contentView addSubview:self.textfild];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.mas_offset(-15);
         make.centerY.mas_equalTo(self.contentView);
          make.height.width.mas_equalTo(12);
    }];
    [self.detaliLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.mas_equalTo(self.arrow.mas_left).mas_offset(-10);
             make.centerY.mas_equalTo(self.contentView);
    }];
    [self.textfild mas_makeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_offset(-15);
          make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(150);
    }];
    
}
#pragma mark ——— lazy


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

- (UILabel *)detaliLabel {
    if (!_detaliLabel) {
         _detaliLabel = [[UILabel alloc]init];
        _detaliLabel.textColor = [UIColor blackColor];
        _detaliLabel.font = [UIFont systemFontOfSize:13];
        _detaliLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *singalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
        [_detaliLabel addGestureRecognizer:singalTap];
    }
    return _detaliLabel;
}

- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _arrow.backgroundColor = [UIColor redColor];
    }
    return _arrow;
}
- (UITextField *)textfild{
    if (!_textfild) {
        _textfild = [[UITextField alloc]init];
        [_textfild addTarget:self action:@selector(textEditChanged:) forControlEvents:UIControlEventEditingChanged];
         _textfild.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _textfild;
}
-(void)textEditChanged:(UITextField *)textFild{
    
  [_forModel setValue:textFild.text forKey:_cellDataModel.key];
    NSString *toBeString = textFild.text;
   if(_cellDataModel.maxInputLength&&toBeString.length>0&&toBeString.length>_cellDataModel.maxInputLength){
       self.contentView.layer.borderColor = [UIColor redColor].CGColor;
       self.contentView.layer.borderWidth = 1;
       }else{
           self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
           self.contentView.layer.borderWidth = 1;
       }
       if([_cellDataModel.key isEqualToString:@"contactMail"]){
           _cellDataModel.errText = @"";
       }else{
           NSString *valueStr = [_forModel valueForKey:_cellDataModel.key];
           if(valueStr.length>0){
               _cellDataModel.errText = @"";
           }
    }
}
@end

