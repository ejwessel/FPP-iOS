//
//  ElectronTrappingRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronTrappingRateController.h"

@interface ElectronTrappingRateController ()

@end

@implementation ElectronTrappingRateController

@synthesize kInput;
@synthesize eInput;
@synthesize outputVelocity;
@synthesize velocityLabel;
@synthesize VEL_CONST;
@synthesize kInputExponent;
@synthesize eInputExponent;

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
    self.title = @"Electron Trapping Rate";
    
    self.VEL_CONST = 7.26 * pow(10, 8);
    
    self.kInput.text = @"";
    self.kInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.kInput.clearButtonMode = true;
    [self.kInput becomeFirstResponder];
    
    self.eInput.text = @"";
    self.eInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.eInput.clearButtonMode = true;
    
    self.kInputExponent.text = @"0";
    self.kInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.kInputExponent.clearButtonMode = true;
    
    self.eInputExponent.text = @"0";
    self.eInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.eInputExponent.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float) calculateFrequencyWithInput:(float)k with:(float)e{
    return self.VEL_CONST * pow(k, .5) * pow(e, .5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.kInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.eInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.kInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.eInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1
       || [self.kInputExponent.text isEqualToString:@""] || [self.eInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float k = [self.kInput.text floatValue] * pow(10, [self.kInputExponent.text floatValue]);
        float e = [self.eInput.text floatValue] * pow(10, [self.eInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", k, e);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:k with:e];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
}


@end
