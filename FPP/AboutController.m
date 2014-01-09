//
//  AboutController.m
//  FPP
//
//  Created by Ethan Wessel on 1/8/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController
@synthesize messageButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.messageButton addTarget:self action:@selector(messageButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.messageButton.layer setCornerRadius:5];
    [self.messageButton.layer setBorderWidth:1];
    
    UIColor *navColor = self.navigationController.navigationBar.tintColor;
    [self.messageButton.layer setBorderColor:navColor.CGColor];
    [self.messageButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)messageButtonClicked{
    NSLog(@"Message Button is clicked");
    
    NSString *url = [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
    
    
}

@end
