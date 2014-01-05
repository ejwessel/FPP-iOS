//
//  IonGyroradiusController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonGyroradiusController.h"

@interface IonGyroradiusController ()

@end

@implementation IonGyroradiusController
@synthesize outputRadius;
@synthesize muInput;
@synthesize zInput;
@synthesize tInput;
@synthesize bInput;
@synthesize muLabel;
@synthesize RADIUS_CONST;

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
    self.title = @"Ion Gyroradius";
    
    self.RADIUS_CONST = 1.02 * pow(10, 2);
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInputExponent.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInputExponent.clearButtonMode = true;
    
    self.outputRadius.text = @"0";
    self.outputRadius.layer.borderWidth = 1.0;
    self.outputRadius.layer.cornerRadius = 5;
    self.outputRadius.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC =";
    
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

- (float) calculateWithInput:(float)m with:(float)z with:(float)t with:(float)b{
    return self.RADIUS_CONST * pow(m, .5) * pow(z, -1) * pow(t, .5) * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks4 = [self.bInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.muInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.zInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks3Exponent = [self.tInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks4Exponent = [self.bInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2 || chunks4.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1 || chunks3Exponent.count > 1 || chunks4Exponent.count > 1
       || [self.muInputExponent.text isEqualToString:@""] || [self.zInputExponent.text isEqualToString:@""] || [self.tInputExponent.text isEqualToString:@""] || [self.bInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g, %g", m, z, t, b);
        
        //do calculations
        float r = [self calculateWithInput:m with:z with:t with:b];
        
        self.outputRadius.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputRadius.text = @"Error with input";
    }
}



@end
