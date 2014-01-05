//
//  ElectronTrappingRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronPlasmaFrequencyController.h"

@interface ElectronPlasmaFrequencyController ()

@end

@implementation ElectronPlasmaFrequencyController

@synthesize inputValue;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize nLabel;
@synthesize FREQ_CONST;
@synthesize OMEGA_CONST;
@synthesize inputValueExponent;

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
    self.title = @"Electron Plasma Freq.";
    
    self.FREQ_CONST = 8.98 * pow(10, 3);
    self.OMEGA_CONST = 5.64 * pow(10, 4);
    
    
    self.inputValue.text = @"";
    self.inputValue.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputValue.clearButtonMode = true;
    [self.inputValue becomeFirstResponder];
    
    self.inputValueExponent.text = @"0";
    self.inputValueExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputValueExponent.clearButtonMode = true;
    
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

- (float) calculateFrequencyWithInput:(float)n{
    return self.FREQ_CONST * pow(n, .5);
}

- (float) calculateOmegaWithInput:(float)n{
    return self.OMEGA_CONST * pow(n, .5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks = [self.inputValue.text componentsSeparatedByString:@"."];
    NSArray *chunksExponent = [self.inputValueExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks.count > 2
       || chunksExponent.count > 1
       || [self.inputValueExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float B = [self.inputValue.text floatValue] * pow(10, [self.inputValueExponent.text floatValue]);
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
