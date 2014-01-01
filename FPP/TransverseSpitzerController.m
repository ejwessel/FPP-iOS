//
//  TransverseSpitzerController.m
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "TransverseSpitzerController.h"

@interface TransverseSpitzerController ()

@end

@implementation TransverseSpitzerController
@synthesize outputN;
@synthesize zInput;
@synthesize lamdaInput;
@synthesize tInput;
@synthesize omegaInput;
@synthesize VALUE_CONST;

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
    self.title = @"Bohm Diffusion Coefficient";
    
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
    
    self.omegaInput.text = @"";
    self.omegaInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.omegaInput.clearButtonMode = true;
    
    self.outputN.text = @"0";
    self.outputN.layer.borderWidth = 1.0;
    self.outputN.layer.cornerRadius = 5;
    self.outputN.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float) calculateWithInput:(float)z with:(float)l with:(float)t with:(float)o{
    return self.VALUE_CONST * z * log(l) * pow(t, -1.5) * o;
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.zInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.lamdaInput.text componentsSeparatedByString:@"."];
    NSArray *chunks3 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks4 = [self.omegaInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2 || chunks4.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float z = [self.zInput.text floatValue];
        float l = [self.lamdaInput.text floatValue];
        float t = [self.tInput.text floatValue];
        float o = [self.omegaInput.text floatValue];
        NSLog(@"number: %g, %g, %g, %g", z, l, t, o);
        
        //do calculations
        float n = [self calculateWithInput:z with:l with:t with:o];
        
        self.outputN.text = [[NSString alloc] initWithFormat:@"%.3e", n];
    }
    else{
        self.outputN.text = @"Error with input";
    }
}


@end
