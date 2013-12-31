//
//  ElectronBroglieLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronBroglieLengthController.h"

@interface ElectronBroglieLengthController ()

@end

@implementation ElectronBroglieLengthController

@synthesize lambaLabel;
@synthesize outputLambda;
@synthesize tInput;
@synthesize LAMBDA_CONST;

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
    self.title = @"Electron deBroglie Length";
    
    self.LAMBDA_CONST = 2.76 * pow(10, -8);
    
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.outputLambda.text = @"0";
    self.outputLambda.layer.borderWidth = 1.0;
    self.outputLambda.layer.cornerRadius = 5;
    self.outputLambda.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.lambaLabel.text = @"\u019B =";
    
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

- (float) calculateWithInput:(float)t{
    return self.LAMBDA_CONST * pow(t, -.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks = [self.tInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float B = [self.tInput.text floatValue];
        NSLog(@"number: %g", B);
        
        //do calculations
        float l = [self calculateWithInput:B];
        
        self.outputLambda.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputLambda.text = @"Error with input";
    }
}


@end
