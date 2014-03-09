//
//  IonPlasmaFrequencyController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonPlasmaFrequencyController.h"

@interface IonPlasmaFrequencyController ()

@end

@implementation IonPlasmaFrequencyController

@synthesize zInput;
@synthesize muInput;
@synthesize nInput;
@synthesize outputFrequency;
@synthesize outputOmega;
@synthesize frequencyLabel;
@synthesize omegaLabel;
@synthesize muLabel;
@synthesize zInputExponent;
@synthesize muInputExponent;
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
    self.title = @"Ion Plasma Freq.";
    
    self.FREQ_CONST = 2.10 * pow(10, 2);
    self.OMEGA_CONST = 1.32 * pow(10, 3);
    
    self.zInput.text = @"";
    self.zInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.muInput.clearButtonMode = true;
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInput.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.zInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.muInputExponent.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInputExponent.clearButtonMode = true;
    
    self.outputFrequency.text = @"0";
    self.outputFrequency.layer.borderWidth = 1.0;
    self.outputFrequency.layer.cornerRadius = 5;
    self.outputFrequency.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.outputOmega.text = @"0";
    self.outputOmega.layer.borderWidth = 1.0;
    self.outputOmega.layer.cornerRadius = 5;
    self.outputOmega.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.frequencyLabel.text = @"\u0192 =";
    self.omegaLabel.text = @"\u03C9 =";
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

- (float) calculateFrequencyWithInput:(float)z with:(float)m with:(float)n{
    return self.FREQ_CONST * z * pow(m, -.5) * pow(n, .5);
}

- (float) calculateOmegaWithInput:(float)z with:(float)m with:(float)n{
    return self.OMEGA_CONST * z * pow(m, -.5) * pow(n, .5);
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
    NSRange z_base = [regexBase rangeOfFirstMatchInString:zInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[zInput.text length])];
    NSRange z_exp = [regexExp rangeOfFirstMatchInString:zInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[zInputExponent.text length])];
    NSRange mu_base = [regexBase rangeOfFirstMatchInString:muInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[muInput.text length])];
    NSRange mu_exp = [regexExp rangeOfFirstMatchInString:muInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[muInputExponent.text length])];
    NSRange n_base = [regexBase rangeOfFirstMatchInString:nInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[nInput.text length])];
    NSRange n_exp = [regexExp rangeOfFirstMatchInString:nInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[nInputExponent.text length])];
    if(n_base.location != NSNotFound
       && n_exp.location != NSNotFound
       && z_base.location != NSNotFound
       && z_exp.location != NSNotFound
       && mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound){
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", z, m, n);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:z with:m with:n];
        float w = [self calculateOmegaWithInput:z with:m with:n];
        
        self.outputFrequency.text = [[NSString alloc] initWithFormat:@"%.3e", f];
        self.outputOmega.text = [[NSString alloc] initWithFormat:@"%.3e", w];
    }
    else{
        self.outputFrequency.text = @"Error with input";
        self.outputOmega.text = @"Error with input";
    }
}

@end
