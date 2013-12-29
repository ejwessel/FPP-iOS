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

@synthesize inputValue;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize magneticFieldLabel;
@synthesize scrollView;

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
