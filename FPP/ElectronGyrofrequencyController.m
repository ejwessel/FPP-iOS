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

@synthesize inputValue;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize magneticFieldLabel;
@synthesize omegaEquation;
@synthesize frequencyEquation;

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
    self.inputValue.text = @"";
    self.inputValue.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputValue.clearButtonMode = true;
    [self.inputValue becomeFirstResponder];
    
    self.outputFrequency.text = @"0";
    self.outputFrequency.layer.borderWidth = 0.5;
    self.outputFrequency.layer.cornerRadius = 5;
    
    self.outputOmega.text = @"0";
    self.outputOmega.layer.borderWidth = 0.5;
    self.outputOmega.layer.cornerRadius = 5;
    
    self.frequencyEquation.text = @"\u0192 = \u03C9/2\u03C0 = 2.80 * 10^6B Hz";
    self.frequencyLabel.text = @"\u0192 =";
    self.omegaEquation.text = @"\u03C9 = \uFF45B/\uFF4D\uFF43 = 1.76 * 10^7B rad/sec";
    self.omegaLabel.text = @"\u03C9 =";
    
    self.title = @"Electron Gyrofreq.";
    
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
    float frequencyConst = 2.80 * pow(10, 6);
    float result = frequencyConst * B;
    return result;
}

- (float) calculateOmegaWithInput:(float)B{
    float omegaConst = 1.76 * pow(10, 7);
    float result = omegaConst * B;
    return result;
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks = [self.inputValue.text componentsSeparatedByString:@"."];
    
    Boolean error = false;
    
    //if the number has a decimal
    if(chunks.count > 1){
        //check no more than 1 decimal point
        if(chunks.count > 2){
            //display error message
            error = true;
        }
        
        //check no more than 8 decimal precision
        if([chunks[1] length] > 8){
            //display error message
            error = true;
        }
    }
    
    if(!error){
        float B = [self.inputValue.text floatValue];
        NSLog(@"number: %f", B);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:B];
        float w = [self calculateOmegaWithInput:B];

        NSString *fString = [[NSNumber numberWithFloat:f] stringValue];
        NSString *wString = [[NSNumber numberWithFloat:w] stringValue];
        
        self.outputFrequency.text = fString;
        self.outputOmega.text = wString;
    }
    else{
        self.outputFrequency.text = @"Error with input";
        self.outputOmega.text = @"Error with input";
    }
}

@end
