//
//  ElectronGyrofrequencyController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronGyrofrequencyController.h"
#import "Constants.h"

@interface ElectronGyrofrequencyController ()

@end

@implementation ElectronGyrofrequencyController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.name.text = @"hi";
    self.someNumber = BoltzmannConstant;
    
    NSLog(@"%f", self.someNumber);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
