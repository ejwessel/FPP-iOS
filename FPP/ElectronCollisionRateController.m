//
//  ElectronCollisionRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/29/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronCollisionRateController.h"

@interface ElectronCollisionRateController ()

@end

@implementation ElectronCollisionRateController
@synthesize nInput;
@synthesize coulombInput;
@synthesize outputVelocity;
@synthesize tInput;
@synthesize VEL_CONST;
@synthesize coulombLabel;
@synthesize nInputExponent;
@synthesize coulombInputExponent;
@synthesize tInputExponent;

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
    self.title = @"Electron Collision Rate";
    
    self.VEL_CONST = 2.91 * pow(10, -6);
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];
    
    self.coulombInput.text = @"";
    self.coulombInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.coulombInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInputExponent.clearButtonMode = true;
    
    self.coulombInputExponent.text = @"0";
    self.coulombInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.coulombInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInputExponent.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.coulombLabel.text = @"ln\u039B =";
    
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

- (float) calculateFrequencyWithInput:(float)n with:(float)c with:(float)t{
    return self.VEL_CONST * n * c * pow(t, -1.5);
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
    NSRange n_base = [regexBase rangeOfFirstMatchInString:nInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[nInput.text length])];
    NSRange n_exp = [regexExp rangeOfFirstMatchInString:nInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[nInputExponent.text length])];
    NSRange coulomb_base = [regexBase rangeOfFirstMatchInString:coulombInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[coulombInput.text length])];
    NSRange coulomb_exp = [regexExp rangeOfFirstMatchInString:coulombInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[coulombInputExponent.text length])];
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[tInputExponent.text length])];
    
    if(n_base.location != NSNotFound
       && n_exp.location != NSNotFound
       && t_base.location != NSNotFound
       && t_exp.location != NSNotFound
       && coulomb_base.location != NSNotFound
       && coulomb_exp.location != NSNotFound){
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float c = [self.coulombInput.text floatValue] * pow(10, [self.coulombInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", n, c, t);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:n with:c with:t];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];

    }
    else{
         self.outputVelocity.text = @"Error with input";
    }
}


@end
