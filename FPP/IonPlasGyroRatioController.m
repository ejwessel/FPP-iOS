//
//  IonPlasGyroRatioController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonPlasGyroRatioController.h"

@interface IonPlasGyroRatioController ()

@end

@implementation IonPlasGyroRatioController
@synthesize muInput;
@synthesize nInput;
@synthesize bInput;
@synthesize VALUE_CONST;
@synthesize muLabel;
@synthesize muInputExponent;
@synthesize nInputExponent;
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
    self.title = @"Ion Plas./Gyrofreq. Ratio";
    
    self.VALUE_CONST = 0.137;
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInputExponent.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInputExponent.clearButtonMode = true;
    
    self.outputAnswer.text = @"0";
    self.outputAnswer.layer.borderWidth = 1.0;
    self.outputAnswer.layer.cornerRadius = 5;
    self.outputAnswer.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float) calculateWithInput:(float)m with:(float)n with:(float)b{
    return self.VALUE_CONST * pow(m, .5) * pow(n, .5) * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.bInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.muInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.nInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.bInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1
       || [self.muInputExponent.text isEqualToString:@""] || [self.nInputExponent.text isEqualToString:@""] || [self.bInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", m, n, b);
        
        //do calculations
        float l = [self calculateWithInput:m with:n with:b];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
