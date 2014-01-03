//
//  IonTrappingRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonTrappingRateController.h"

@interface IonTrappingRateController ()

@end

@implementation IonTrappingRateController

@synthesize zInput;
@synthesize kInput;
@synthesize eInput;
@synthesize muInput;
@synthesize outputVelocity;
@synthesize velocityLabel;
@synthesize VEL_CONST;
@synthesize muLabel;

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
    self.title = @"Ion Trapping Rate";
    
    self.VEL_CONST = 1.69 * pow(10, 7);
    
    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.kInput.text = @"";
    self.kInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.kInput.clearButtonMode = true;
    
    self.eInput.text = @"";
    self.eInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.eInput.clearButtonMode = true;
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC";
    
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

- (float) calculateFrequencyWithInput:(float)z with:(float)k with:(float)e with:(float)m{
    return self.VEL_CONST * pow(z, .5) * pow(k, .5) * pow(e, .5) * pow(m, -.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.kInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.eInput.text componentsSeparatedByString:@"."];
    NSArray *chunks4 = [self.muInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count >2 || chunks4.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float z = [self.zInput.text floatValue];
        float k = [self.kInput.text floatValue];
        float e = [self.eInput.text floatValue];
        float m = [self.muInput.text floatValue];
        NSLog(@"number: %g, %g, %g, %g", z, k, e, m);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:z with:k with:e with:m];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
}

@end
