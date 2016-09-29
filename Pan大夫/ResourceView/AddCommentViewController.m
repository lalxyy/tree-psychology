//
//  AddCommentViewController.m
//  Pan大夫
//
//  Created by Carl Lee on 6/19/16.
//  Copyright © 2016 Neil. All rights reserved.
//

#import "AddCommentViewController.h"

@interface AddCommentViewController ()

@property (nonatomic) NSString *articleId;
@property (nonatomic) NSString *userId;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *submitButton;

@end

@implementation AddCommentViewController

- (instancetype)initWithArticleId:(NSString *)articleId userId:(NSString *)userId {
    self = [super init];
    if (self) {
        _articleId = articleId;
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加评论";
    
    _textView = [[UITextView alloc] initWithFrame:self.view.frame];
    _textView.editable = YES;
    [self.view addSubview:_textView];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _submitButton.frame = CGRectMake(0, 0, 34, 17);
    _submitButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [_submitButton setTitle:@"OK" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submitComment) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_submitButton];
    
    [_textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submitComment {
    NSString *commentText = _textView.text;
    NSString *bodyStr = [NSString stringWithFormat:@"articleId=%@&userId=%@&content=%@", _articleId, _userId, [commentText mk_urlEncodedString]];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://1.pandoctor.sinaapp.com/Community/Comment/addComment.php?%@", bodyStr]]];
//    [req setHTTPMethod:@"POST"];
//    [req setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
        } else {
            NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
            NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HttpResponseCode:%ld", responseCode);
            NSLog(@"HttpResponseBody %@",responseString);
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([dic objectForKey:@"error"]) {
                NSLog(@"%@", [dic objectForKey:@"error"]);
                return;
            }
            if (!(BOOL)[dic objectForKey:@"Succeed"]) {
                [[[UIAlertView alloc] initWithTitle:@"操作失败" message:@"遇到未知错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                return;
            }
            [self performSelectorOnMainThread:@selector(goBack) withObject:nil waitUntilDone:NO];
        }
    }];
    [dataTask resume];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
