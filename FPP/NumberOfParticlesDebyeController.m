//
//  NumberOfParticlesDebyeController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "NumberOfParticlesDebyeController.h"

@interface NumberOfParticlesDebyeController ()

@end

@implementation NumberOfParticlesDebyeController

@synthesize outputAnswer;
@synthesize tInput;
@synthesize nInput;
@synthesize VALUE_CONST;
@synthesize tInputExponent;
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
    self.title = @"No. Particles Debye Sphere";
    
    self.VALUE_CONST = 1.72 * pow(10, 9);
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInputExponent.clearButtonMode = true;
    
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

- (float) calculateWithInput:(float)t with:(float)n{
    return self.VALUE_CONST * pow(t, 1.5) * pow(n, -.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.nInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1
       || [self.tInputExponent.text isEqualToString:@""] || [self.nInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", t, n);
        
        //do calculations
        float l = [self calculateWithInput:t with:n];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}

@end
