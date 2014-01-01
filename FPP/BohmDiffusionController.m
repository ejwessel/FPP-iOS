//
//  BohmDiffusionController.m
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "BohmDiffusionController.h"

@interface BohmDiffusionController ()

@end

@implementation BohmDiffusionController
@synthesize outputD;
@synthesize tInput;
@synthesize bInput;
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
    
    self.VALUE_CONST = 6.25 * pow(10, 6);
    
    self.tInput.text = @"";
    self.tInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
    self.outputD.text = @"0";
    self.outputD.layer.borderWidth = 1.0;
    self.outputD.layer.cornerRadius = 5;
    self.outputD.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float) calculateWithInput:(float)t with:(float)b{
    return self.VALUE_CONST * t * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.tInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.bInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float t = [self.tInput.text floatValue];
        float b = [self.bInput.text floatValue];
        NSLog(@"number: %g, %g", t, b);
        
        //do calculations
        float l = [self calculateWithInput:t with:b];
        
        self.outputD.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputD.text = @"Error with input";
    }
}

@end
