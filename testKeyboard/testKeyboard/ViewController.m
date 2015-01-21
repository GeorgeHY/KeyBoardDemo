//
//  ViewController.m
//  testKeyboard
//
//  Created by iwind on 15/1/20.
//  Copyright (c) 2015年 iwind. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGRect _originFrame;
}
@property (nonatomic, strong) UIView * v;
@property (nonatomic, strong) UITextView * tv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tv = [[UITextView alloc]initWithFrame:CGRectMake(50,50, [[UIScreen mainScreen] bounds].size.width * 0.5, 44)];
    self.tv.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tv];
   self.v = [[UIView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-50, [[UIScreen  mainScreen]bounds].size.width, 50)];
    _originFrame = self.v.frame;
    self.v.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.v];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardhide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 50, 40)];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview: btn];
    
}

-(void)btnAction{
    [self.tv resignFirstResponder];
}

-(void)keyboardWillChangeFrame:(NSNotification *)notif{
    NSDictionary * info = [notif userInfo];
    CGFloat duration = [[info objectForKeyedSubscript:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue * value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [value CGRectValue];
    NSLog(@"------- frame = %@",NSStringFromCGRect(frame));
    CGRect frame1 = self.v.frame;
    frame1.origin.y = frame.origin.y-frame1.size.height;
//    frame1.origin = CGPointMake(0, 300);
    NSLog(@"frame1 = %@",NSStringFromCGRect(frame1));
    [UIView animateWithDuration:duration animations:^{
        self.v.frame = frame1;
    }];
    
    NSLog(@"------- self.v.frame = %@",NSStringFromCGRect(self.v.frame));
    
//    NSLog(@"------ frame = %@",NSStringFromCGRect(frame));
    
    

}
-(void)keyboardhide:(NSNotification*)notif{
    NSDictionary * info = [notif userInfo];
    CGFloat duration = [[info objectForKeyedSubscript:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    NSValue * value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
//    CGRect frame = [value CGRectValue];
//    NSLog(@"------- frame = %@",NSStringFromCGRect(frame));
//    CGRect frame1 = self.v.frame;
//    frame1.origin.y = frame.origin.y-frame1.size.height;
//    //    frame1.origin = CGPointMake(0, 300);
//    NSLog(@"frame1 = %@",NSStringFromCGRect(frame1));
    [UIView animateWithDuration:duration animations:^{
        self.v.frame = _originFrame;
    }];
    
    NSLog(@"------- self.v.frame = %@",NSStringFromCGRect(self.v.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
