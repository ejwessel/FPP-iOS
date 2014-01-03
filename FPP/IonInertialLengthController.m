//
//  IonInertialLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonInertialLengthController.h"

@interface IonInertialLengthController ()

@end

@implementation IonInertialLengthController
@synthesize outputAnswer;
@synthesize muInput;
@synthesize nInput;
@synthesize CONST_VALUE;

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
    self.title = @"Ion Intertial Length";
    
    self.CONST_VALUE = 2.28 * pow(10, 7);
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    
    self.outputAnswer.text = @"0";
    self.outputAnswer.layer.borderWidth = 1.0;
    self.outputAnswer.layer.cornerRadius = 5;
    self.outputAnswer.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float)calculateWithInput:(float)m with:(float)n{
    return self.CONST_VALUE * pow(m/n, .5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.nInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float m = [self.muInput.text floatValue];
        float n = [self.nInput.text floatValue];
        NSLog(@"number: %g, %g", m, n);
        
        //do calculations
        float r = [self calculateWithInput:m with:n];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
