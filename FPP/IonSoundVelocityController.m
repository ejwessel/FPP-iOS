//
//  IonSoundVelocityController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonSoundVelocityController.h"

@interface IonSoundVelocityController ()

@end

@implementation IonSoundVelocityController
@synthesize outputC;
@synthesize gammaInput;
@synthesize zInput;
@synthesize tInput;
@synthesize muInput;
@synthesize C_CONST;
@synthesize gammaLabel;
@synthesize muLabel;
@synthesize gammaInputExponent;
@synthesize zInputExponent;
@synthesize tInputExponent;
@synthesize muInputExponent;

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
    self.title = @"Ion Sound Velocity";
    
    self.C_CONST = 9.79 * pow(10, 5);
    
    self.gammaInput.text = @"";
    self.gammaInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.gammaInput.clearButtonMode = true;
    [self.gammaInput becomeFirstResponder];
    
    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    
    self.gammaInputExponent.text = @"0";
    self.gammaInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.gammaInputExponent.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInputExponent.clearButtonMode = true;
    
    self.outputC.text = @"0";
    self.outputC.layer.borderWidth = 1.0;
    self.outputC.layer.cornerRadius = 5;
    self.outputC.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC";
    self.gammaLabel.text = @"\u03B3";
    
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

- (float) calculateWithInput:(float)g with:(float)z with:(float)t with:(float)m{
    return self.C_CONST * pow(g * z * t / m, .5) ;
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.gammaInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks4 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.gammaInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.zInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.tInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks4Exponent = [self.muInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2 || chunks4.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1 || chunks4Exponent.count > 1
       || [self.gammaInputExponent.text isEqualToString:@""] || [self.zInputExponent.text isEqualToString:@""] || [self.tInputExponent.text isEqualToString:@""] || [self.muInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float g = [self.gammaInput.text floatValue] * pow(10, [self.gammaInputExponent.text floatValue]);
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", m, t);
        
        //do calculations
        float l = [self calculateWithInput:g with:z with:t with:m];
        
        self.outputC.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputC.text = @"Error with input";
    }
}

@end
