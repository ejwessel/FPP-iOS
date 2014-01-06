//
//  ElectronInertialLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronInertialLengthController.h"

@interface ElectronInertialLengthController ()

@end

@implementation ElectronInertialLengthController
@synthesize outputAnswer;
@synthesize nInput;
@synthesize CONST_VALUE;
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
    self.title = @"Electron Inertial Length";
    
    self.CONST_VALUE = 5.31 * pow(10, 5);
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];

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

- (float) calculateWithInput:(float)n{
    return self.CONST_VALUE * pow(n, -.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunksExponent = [self.nInputExponent.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks.count > 2
       || chunksExponent.count > 1
       || [self.nInputExponent.text isEqualToString:@""]){
        //display error message
        error = true;
    }
    
    if(!error){
        float n = [self.nInput.text floatValue] * pow(10,[self.nInputExponent.text floatValue]);
        NSLog(@"number: %g", n);
        
        //do calculations
        float r = [self calculateWithInput:n];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}

@end
