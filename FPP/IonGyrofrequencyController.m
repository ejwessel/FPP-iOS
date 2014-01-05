//
//  IonGyrofrequencyController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonGyrofrequencyController.h"

@interface IonGyrofrequencyController ()

@end

@implementation IonGyrofrequencyController

@synthesize zInput;
@synthesize muInput;
@synthesize bInput;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize magneticFieldLabel;
@synthesize muLabel;
@synthesize zetaLabel;
@synthesize FREQ_CONST;
@synthesize OMEGA_CONST;
@synthesize bInputExponent;
@synthesize muInputExponent;
@synthesize zInputExponent;

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
    self.title = @"Ion Gyrofreq.";

    self.FREQ_CONST = 1.52 * pow(10, 3);
    self.OMEGA_CONST = 9.58 * pow(10, 3);

    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];

    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInputExponent.clearButtonMode = true;
    
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

- (float) calculateFrequencyWithInput:(float)B with:(float)m with:(float)z{
    return self.FREQ_CONST * z * pow(m, -1) * B;
}

- (float) calculateOmegaWithInput:(float)B with:(float)m with:(float)z{
    return self.OMEGA_CONST * z * pow(m, -1) 	* B;
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.bInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.zInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.muInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.bInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1
       || [self.zInputExponent.text isEqualToString:@""] || [self.muInputExponent.text isEqualToString:@""] || [self.bInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float B = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float z = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", B, m, z);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:B with:m with:z];
        float w = [self calculateOmegaWithInput:B with:m with:z];
        
        self.outputFrequency.text = [[NSString alloc] initWithFormat:@"%.3e", f];
        self.outputOmega.text = [[NSString alloc] initWithFormat:@"%.3e", w];
    }
    else{
        self.outputFrequency.text = @"Error with input";
        self.outputOmega.text = @"Error with input";
    }
}

@end
