//
//  firstViewvc.m
//  FormText
//
//  Created by ios 001 on 2019/11/26.
//  Copyright © 2019 ios 001. All rights reserved.
//

#import "firstViewvc.h"
#import "ViewController.h"
#import "Masonry.h"
#import "FormModel.h"

@interface firstViewvc ()

@end

@implementation firstViewvc

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.height.width.mas_equalTo(100);
    }];

}
-(void)btnClick:(UIButton *)sender{
    ViewController *vc =[[ViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
      
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
