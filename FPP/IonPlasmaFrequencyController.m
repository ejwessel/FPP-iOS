//
//  IonPlasmaFrequencyController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonPlasmaFrequencyController.h"

@interface IonPlasmaFrequencyController ()

@end

@implementation IonPlasmaFrequencyController

@synthesize zInput;
@synthesize muInput;
@synthesize nInput;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize muLabel;
@synthesize zInputExponent;
@synthesize muInputExponent;
@synthesize nInputExponent;

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
    self.title = @"Ion Plasma Freq.";
    
    self.FREQ_CONST = 2.10 * pow(10, 2);
    self.OMEGA_CONST = 1.32 * pow(10, 3);
    
    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInputExponent.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInputExponent.clearButtonMode = true;
    
    self.outputFrequency.text = @"0";
    self.outputFrequency.layer.borderWidth = 1.0;
    self.outputFrequency.layer.cornerRadius = 5;
    self.outputFrequency.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.outputOmega.text = @"0";
    self.outputOmega.layer.borderWidth = 1.0;
    self.outputOmega.layer.cornerRadius = 5;
    self.outputOmega.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.frequencyLabel.text = @"\u0192 =";
    self.omegaLabel.text = @"\u03C9 =";
    self.muLabel.text = @"\u03BC =";
    
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

- (float) calculateFrequencyWithInput:(float)z with:(float)m with:(float)n{
    return self.FREQ_CONST * z * pow(m, -.5) * pow(n, .5);
}

- (float) calculateOmegaWithInput:(float)z with:(float)m with:(float)n{
    return self.OMEGA_CONST * z * pow(m, -.5) * pow(n, .5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.zInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.muInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.nInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1
       || [self.zInputExponent.text isEqualToString:@""] || [self.muInputExponent.text isEqualToString:@""] || [self.nInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", z, m, n);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:z with:m with:n];
        float w = [self calculateOmegaWithInput:z with:m with:n];
        
        self.outputFrequency.text = [[NSString alloc] initWithFormat:@"%.3e", f];
        self.outputOmega.text = [[NSString alloc] initWithFormat:@"%.3e", w];
    }
    else{
        self.outputFrequency.text = @"Error with input";
        self.outputOmega.text = @"Error with input";
    }
}

@end
