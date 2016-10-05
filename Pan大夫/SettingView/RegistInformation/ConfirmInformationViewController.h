//
//  ComfirmInformationViewController.h
//  Pan大夫
//
//  Created by Tom on 15/9/2.
//  Copyright (c) 2015年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmInformationViewController : UIViewController

@property (nonatomic, copy) NSString *phone;

@property (nonatomic) NSString *nickname;

@property (nonatomic) BOOL isRoot;

//初始化试图控制器，通过字典传值
-(id)initWithInformationDictionary:(NSDictionary *)informationDictionary;

- (void)commitUserInformation;

@end
