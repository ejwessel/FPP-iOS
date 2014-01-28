//
//  TransverseSpitzerController.m
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "SpitzerResistivityController.h"

@interface SpitzerResistivityController ()

@end

@implementation SpitzerResistivityController
@synthesize outputNPerpendicular;
@synthesize zInput;
@synthesize lamdaInput;
@synthesize tInput;
@synthesize VALUE_CONST;
@synthesize lambaLabel;
@synthesize zInputExponent;
@synthesize lambdaInputExponent;
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
    self.title = @"Spitzer Resistivity";
    
    self.VALUE_CONST = 1.03 * pow(10, -2);
    
    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.lamdaInput.text = @"";
    self.lamdaInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.lamdaInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInputExponent.clearButtonMode = true;
    
    self.lambdaInputExponent.text = @"0";
    self.lambdaInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.lambdaInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.outputNPerpendicular.text = @"0";
    self.outputNPerpendicular.layer.borderWidth = 1.0;
    self.outputNPerpendicular.layer.cornerRadius = 5;
    self.outputNPerpendicular.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.outputNParallel.text = @"0";
    self.outputNParallel.layer.borderWidth = 1.0;
    self.outputNParallel.layer.cornerRadius = 5;
    self.outputNParallel.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.lambaLabel.text = @"ln\u039B =";
    
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

- (float) calculateWithInput:(float)z with:(float)l with:(float)t{
    return self.VALUE_CONST * z * l * pow(t, -1.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.lamdaInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.zInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.lambdaInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.tInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1
       || [self.zInputExponent.text isEqualToString:@""] || [self.lambdaInputExponent.text isEqualToString:@""] || [self.tInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float l = [self.lamdaInput.text floatValue] * pow(10, [self.lambdaInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", z, l, t);
        
        //do calculations
        float nPerp = [self calculateWithInput:z with:l with:t];
        float nParallel = nPerp / 2.0;
        
        self.outputNPerpendicular.text = [[NSString alloc] initWithFormat:@"%.3e", nPerp];
        self.outputNParallel.text = [[NSString alloc] initWithFormat:@"%.3e", nParallel];
    }
    else{
        self.outputNPerpendicular.text = @"Error with input";
    }
}


@end