//
//  ElectronTrappingRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronTrappingRateController.h"

@interface ElectronTrappingRateController ()

@end

@implementation ElectronTrappingRateController

@synthesize kInput;
@synthesize eInput;
@synthesize outputVelocity;
@synthesize velocityLabel;
@synthesize VEL_CONST;
@synthesize kInputExponent;
@synthesize eInputExponent;

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
    self.title = @"Electron Trapping Rate";
    
    self.VEL_CONST = 7.26 * pow(10, 8);
    
    self.kInput.text = @"";
    self.kInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.kInput.clearButtonMode = true;
    [self.kInput becomeFirstResponder];
    
    self.eInput.text = @"";
    self.eInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.eInput.clearButtonMode = true;
    
    self.kInputExponent.text = @"0";
    self.kInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.kInputExponent.clearButtonMode = true;
    
    self.eInputExponent.text = @"0";
    self.eInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.eInputExponent.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float) calculateFrequencyWithInput:(float)k with:(float)e{
    return self.VEL_CONST * pow(k, .5) * pow(e, .5);
}

- (void) textChanged:(NSNotification *)note{
    
    NSLog(@"text changed");
    NSError *regError = NULL;
    NSRegularExpression *regexBase = [NSRegularExpression regularExpressionWithPattern:BASE_REGEX
                                                                               options:0
                                                                                 error:&regError];
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:EXP_REGEX
                                                                              options:0
                                                                                error:&regError];
    NSRange k_base = [regexBase rangeOfFirstMatchInString:kInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[kInput.text length])];
    NSRange k_exp = [regexExp rangeOfFirstMatchInString:kInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[kInputExponent.text length])];
    NSRange e_base = [regexBase rangeOfFirstMatchInString:eInput.text
                                                   options:0
                                                     range:NSMakeRange(0,[eInput.text length])];
    NSRange e_exp = [regexExp rangeOfFirstMatchInString:eInputExponent.text
                                                 options:0
                                                   range:NSMakeRange(0,[eInputExponent.text length])];
    
    if(k_base.location != NSNotFound
       && k_exp.location != NSNotFound
       && e_base.location != NSNotFound
       && e_exp.location != NSNotFound){
        float k = [self.kInput.text floatValue] * pow(10, [self.kInputExponent.text floatValue]);
        float e = [self.eInput.text floatValue] * pow(10, [self.eInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", k, e);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:k with:e];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
 }


@end
