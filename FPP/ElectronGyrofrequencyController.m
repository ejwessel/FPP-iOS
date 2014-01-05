//
//  ElectronGyrofrequencyController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronGyrofrequencyController.h"

@interface ElectronGyrofrequencyController ()

@end

@implementation ElectronGyrofrequencyController

@synthesize bInput;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize bInputExponent;
@synthesize FREQ_CONST;
@synthesize OMEGA_CONST;

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
    self.title = @"Electron Gyrofreq.";
    
    self.FREQ_CONST = 2.80 * pow(10, 6);
    self.OMEGA_CONST = 1.76 * pow(10, 7);

    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    [self.bInput becomeFirstResponder];
    
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

- (float) calculateFrequencyWithInput:(float)B{
    return self.FREQ_CONST * B;
}

- (float) calculateOmegaWithInput:(float)B{
    return self.OMEGA_CONST * B;
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks = [self.bInput.text componentsSeparatedByString:@"."];
    NSArray *chunksExponent = [self.bInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks.count > 2
       || chunksExponent.count > 1 || [self.bInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float B = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g", B);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:B];
        float w = [self calculateOmegaWithInput:B];
        
        self.outputFrequency.text = [[NSString alloc] initWithFormat:@"%.3e", f];
        self.outputOmega.text = [[NSString alloc] initWithFormat:@"%.3e", w];
    }
    else{
        self.outputFrequency.text = @"Error with input";
        self.outputOmega.text = @"Error with input";
    }
}

@end
