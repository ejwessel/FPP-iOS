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
    Boolean error = false;
    //check no more than 1 decimal point
    if(chunks1.count > 2 || chunks2.count > 2 || chunks3.count > 2 || chunks4.count > 2){
        //display error message
        error = true;
    }
    
    if(!error){
        float g = [self.gammaInput.text floatValue];
        float z = [self.zInput.text floatValue];
        float t = [self.tInput.text floatValue];
        float m = [self.muInput.text floatValue];
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
