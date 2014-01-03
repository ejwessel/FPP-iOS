//
//  TESTViewController.m
//  FPP
//
//  Created by Ethan Wessel on 1/3/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "TESTViewController.h"

@interface TESTViewController ()

@end

@implementation TESTViewController
@synthesize outputAnswer;
@synthesize tInput;
@synthesize tInputExponent;
@synthesize bInput;
@synthesize bInputExponent;
@synthesize D_CONST;

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
    
    self.D_CONST = 6.25 * pow(10, 6);
    
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInputExponent.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
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

- (float) calculateWithValue:(float)t with:(float)b{
    return self.D_CONST * t * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.bInput.text componentsSeparatedByString:@"."];
    NSArray *chunks1Exponent = [self.tInputExponent.text componentsSeparatedByString:@"."];
    NSArray *chunks2Exponent = [self.bInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2
       || chunks1Exponent.count > 1 || chunks2Exponent.count > 1
       || chunks1Exponent.count == 0 || chunks2Exponent.count == 0){
        //display error message
        error = true;
    }
    
    if(!error){
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", t, b);
        
        //do calculations
        float f = [self calculateWithValue:t with:b];

        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
