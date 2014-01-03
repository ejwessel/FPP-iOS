//
//  IonCollisionRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonCollisionRateController.h"

@interface IonCollisionRateController ()

@end

@implementation IonCollisionRateController

@synthesize outputVelocity;
@synthesize zInput;
@synthesize muInput;
@synthesize nInput;
@synthesize coulombInput;
@synthesize tInput;
@synthesize VEL_CONST;

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
    self.title = @"Ion Collision Rate";
    
    self.VEL_CONST = 4.80 * pow(10, -8);
    
    self.zInput.text = @"";
    self.zInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.muInput.text = @"";
    self.muInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.muInput.clearButtonMode = true;
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    
    self.coulombInput.text = @"";
    self.coulombInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.coulombInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC";
    self.coulombLabel.text = @"\u039B";
    
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

- (float) calculateFrequencyWithInput:(float)z with:(float)m with:(float)n with:(float)c with:(float)t{
    return self.VEL_CONST * pow(z,4) * pow(m, -.5) * n * log(c) * pow(t, -1.5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.muInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks4 = [self.coulombInput.text componentsSeparatedByString:@"."];
    NSArray *chunks5 = [self.tInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2 || chunks4.count > 2 || chunks5.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float z = [self.zInput.text floatValue];
        float m = [self.muInput.text floatValue];
        float n = [self.nInput.text floatValue];
        float c = [self.coulombInput.text floatValue];
        float t = [self.tInput.text floatValue];
        NSLog(@"number: %g, %g, %g, %g, %g", z, m, n, c, t);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:z with:m with:n with:c with:t];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
}


@end
