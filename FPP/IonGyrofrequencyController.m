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

@synthesize inputValue1;
@synthesize inputValue2;
@synthesize inputValue3;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize magneticFieldLabel;
@synthesize muLabel;
@synthesize zetaLabel;
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
    self.title = @"Ion Gyrofreq.";

    self.FREQ_CONST = 1.52 * pow(10, 3);
    self.OMEGA_CONST = 9.58 * pow(10, 3);

    self.inputValue1.text = @"";
    self.inputValue1.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputValue1.clearButtonMode = true;
    [self.inputValue1 becomeFirstResponder];

    self.inputValue2.text = @"";
    self.inputValue2.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputValue2.clearButtonMode = true;
    
    self.inputValue3.text = @"";
    self.inputValue3.keyboardType = UIKeyboardTypeDecimalPad;
    self.inputValue3.clearButtonMode = true;
    
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

- (float) calculateFrequencyWithInput:(float)B with:(float)m with:(float)z{
    return self.FREQ_CONST * z * pow(m, -1) * B;
}

- (float) calculateOmegaWithInput:(float)B with:(float)m with:(float)z{
    return self.OMEGA_CONST * z * pow(m, -1) 	* B;
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks = [self.inputValue1.text componentsSeparatedByString:@"."];
    
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
        float B = [self.inputValue1.text floatValue];
        float m = [self.inputValue2.text floatValue];
        float z = [self.inputValue3.text floatValue];
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
