//
//  ThermalMagEnergyRatioController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ThermalMagEnergyRatioController.h"

@interface ThermalMagEnergyRatioController ()

@end

@implementation ThermalMagEnergyRatioController
@synthesize outputAnswer;
@synthesize nInput;
@synthesize tInput;
@synthesize bInput;
@synthesize VALUE_CONST;
@synthesize nInputExponent;
@synthesize tInputExponent;
@synthesize bInputExponent;

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
    self.title = @"Thermal Mag. Energy Ratio";
    
    self.VALUE_CONST = 4.03 * pow(10, -11);
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInputExponent.clearButtonMode = true;
    
    self.outputAnswer.text = @"0";
    self.outputAnswer.layer.borderWidth = 1.0;
    self.outputAnswer.layer.cornerRadius = 5;
    self.outputAnswer.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float) calculateWithInput:(float)n with:(float)t with:(float)b{
    return self.VALUE_CONST * n * t * pow(b, -2);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.bInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.nInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.tInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.bInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1
       || [self.nInputExponent.text isEqualToString:@""] || [self.tInputExponent.text isEqualToString:@""] || [self.bInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", n, t, b);
        
        //do calculations
        float l = [self calculateWithInput:n with:t with:b];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
