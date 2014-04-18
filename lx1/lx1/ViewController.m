//
//  ViewController.m
//  lx1
//
//  Created by teluor on 14-2-22.
//  Copyright (c) 2014年 teluor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *b =[[UIButton alloc] init];
    b.frame = CGRectMake(110.0f, 200.0f, 100.0f, 30.0f);
    
    [b setTitle:@"ok" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(bClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(90, 150, 75, 40)];
    l.shadowColor = [UIColor whiteColor];
 //   l.text=@"你好";
    [self.view addSubview:l];
    
    UITextField *t=[[UITextField alloc] initWithFrame:CGRectMake(150,150,100,30) ];
    
//    t.text=@"请输入姓名";
    // 边框
    t.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:t ];
    
/*    UIActionSheet *ac = [[UIActionSheet alloc]
                         initWithTitle:@"确认删除?" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:@"确认"
                         otherButtonTitles:@"", nil];
    [ac showInView:self.view];
*/
/*
    UIAlertView *al = [[UIAlertView alloc]
                       initWithTitle:@"真的是IOS？" message:@"是的，我确认！" delegate:nil
                       cancelButtonTitle:@"取消"otherButtonTitles:nil];
    [al show];
*/
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) bClick:(id) sender
{
    NSLog(@"click to %@", self.button1.titleLabel.text);
    
}

- (IBAction)lx1:(id)sender
{
    NSLog(@"to one");
//    self.label1.text = @"你是不是点击了它?！";
    self.label1.text = self.text1.text;
}
- (IBAction)exit1:(id)sender
{
    self.label1.text = self.text1.text;
}

@end
