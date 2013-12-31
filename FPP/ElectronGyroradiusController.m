//
//  ElectronGyroradiusController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronGyroradiusController.h"

@interface ElectronGyroradiusController ()

@end

@implementation ElectronGyroradiusController
@synthesize outputRadius;
@synthesize tInput;
@synthesize bInput;
@synthesize RADIUS_CONST;

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
    self.title = @"Electron Gyroradius";
    
    self.RADIUS_CONST = 2.38;
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
    self.outputRadius.text = @"0";
    self.outputRadius.layer.borderWidth = 1.0;
    self.outputRadius.layer.cornerRadius = 5;
    self.outputRadius.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(textChanged:)
     name:UITextFieldTextDidChangeNotification
     object:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float) calculateWithInput:(float)t with:(float)b{
    return self.RADIUS_CONST * pow(t, .5) * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.bInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float t = [self.tInput.text floatValue];
        float b = [self.bInput.text floatValue];
        NSLog(@"number: %g, %g", t, b);
        
        //do calculations
        float r = [self calculateWithInput:t with:b];
        
        self.outputRadius.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputRadius.text = @"Error with input";
    }
}



@end
