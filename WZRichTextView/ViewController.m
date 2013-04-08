//
//  ViewController.m
//  WZRichTextView
//
//  Created by Wei on 13-4-7.
//  Copyright (c) 2013年 Wei. All rights reserved.
//

#import "ViewController.h"

#import "WZRichTextVew.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WZRichTextVew *view = [[WZRichTextVew alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
    view.content = @"asdfghjkl";
    view.content = @"asda1@23134-413-2421'fs42";
    view.content = @"@asda1@23@134-413-2421'fs42@";
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
