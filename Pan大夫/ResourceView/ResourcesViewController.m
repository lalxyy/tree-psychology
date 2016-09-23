//
//  ResourcesViewController.m
//  IOS
//
//  Created by Kt on 14-8-20.
//  Copyright (c) 2014年 neu. All rights reserved.
//

#import "ResourcesViewController.h"
#import "MyScollViewController.h"
#import "SVTopScrollView.h"
#import "ScrollableTable.h"
#import "NewsDetailViewController.h"

#define kCellCount 10
@interface ResourcesViewController (){
    NSInteger count;
}
@property (strong, nonatomic) NSMutableArray *tables;
// 存储文章标题的数组
@property (strong, nonatomic) NSMutableArray *cellTitles;
@property (weak, nonatomic) UITableView *table;

@end

@implementation ResourcesViewController

@synthesize table,tables,cellTitles;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSArray *nameArray = [[NSArray alloc]initWithObjects:
                          @"抑郁症",
                          @"焦虑症",
                          @"疑病症",
                          @"强迫症",
                          @"妄想症",
                          @"恐惧症",
                          @"健忘症",
                          @"多动症",
                          nil];
    cellTitles = [[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    NSArray *diseaseArray = [[NSArray alloc]initWithObjects:
                             @"depression",
                             @"anxiety",
                             @"hypochondria",
                             @"obsession",
                             @"paranoid",
                             @"phobia",
                             @"amnesia",
                             @"ADHD",
                             nil];
    
    ScrollableTable *table1 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table2 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table3 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table4 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table5 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table6 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table7 = [[ScrollableTable alloc]initWithNavPushController:self];
    ScrollableTable *table8 = [[ScrollableTable alloc]initWithNavPushController:self];
    
    tables = [NSMutableArray arrayWithObjects:table1,table2,table3,table4,table5,table6,table7,table8,nil];
    
    table1.delegate = self;
    
    // 滚动条部分
    // 为什么要这样使用？
    MyScollViewController *myScrollViewController = [[MyScollViewController alloc]initWithNameArray:nameArray diseaseArray:diseaseArray AndTables:tables];
    [self.view addSubview:myScrollViewController.view];
//    myScrollViewController.view.hidden = YES;
    [table1 refreshTable];
    
    // 为什么父类的 viewDidLoad 方法要放在这里？
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
    backItem.title = @"返回";
    self.navigationItem.backBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellTapedWithId:(NSString*)Id{
    NewsDetailViewController *detailViewController = [[NewsDetailViewController alloc]initWithId:Id];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end