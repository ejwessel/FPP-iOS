//
//  ElectronCollisionRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/29/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronCollisionRateController.h"

@interface ElectronCollisionRateController ()

@end

@implementation ElectronCollisionRateController
@synthesize nInput;
@synthesize coulombInput;
@synthesize outputVelocity;
@synthesize tInput;
@synthesize VEL_CONST;
@synthesize coulombLabel;
@synthesize nInputExponent;
@synthesize coulombInputExponent;
@synthesize tInputExponent;

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
    self.title = @"Electron Collision Rate";
    
    self.VEL_CONST = 2.91 * pow(10, -6);
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];
    
    self.coulombInput.text = @"";
    self.coulombInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.coulombInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInputExponent.clearButtonMode = true;
    
    self.coulombInputExponent.text = @"0";
    self.coulombInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.coulombInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.coulombLabel.text = @"ln\u039B =";
    
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

- (float) calculateFrequencyWithInput:(float)n with:(float)c with:(float)t{
    return self.VEL_CONST * n * c * pow(t, -1.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.coulombInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.nInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.coulombInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.tInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count >2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1
       || [self.nInputExponent.text isEqualToString:@""] || [self.coulombInputExponent.text isEqualToString:@""] || [self.tInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float c = [self.coulombInput.text floatValue] * pow(10, [self.coulombInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", n, c, t);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:n with:c with:t];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
}


@end
