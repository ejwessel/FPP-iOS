//
//  ElectronPlasmaGyroRatioController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronPlasmaGyroRatioController.h"

@interface ElectronPlasmaGyroRatioController ()

@end

@implementation ElectronPlasmaGyroRatioController
@synthesize outputAnswer;
@synthesize nInput;
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
    self.title = @"Elect. Plas./Gyrofreq. Ratio";
    
    self.VALUE_CONST = 3.21 * pow(10, -3);
    
    self.nInput.text = @"";
    self.nInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];
    
    self.bInput.text = @"";
    self.bInput.keyboardType = UIKeyboardTypeDecimalPad;
    self.bInput.clearButtonMode = true;
    
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

- (float) calculateWithInput:(float)n with:(float)b{
    return self.VALUE_CONST * pow(n, .5) * pow(b, -1);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    
    //do checks...
    NSArray *chunks1 = [self.nInput.text componentsSeparatedByString:@"."];
    NSArray *chunks2 = [self.bInput.text componentsSeparatedByString:@"."];
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float n = [self.nInput.text floatValue];
        float b = [self.bInput.text floatValue];
        NSLog(@"number: %g, %g", n, b);
        
        //do calculations
        float l = [self calculateWithInput:n with:b];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}

@end
