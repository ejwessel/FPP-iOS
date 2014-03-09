//
//  IonTrappingRateController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonTrappingRateController.h"

@interface IonTrappingRateController ()

@end

@implementation IonTrappingRateController

@synthesize zInput;
@synthesize kInput;
@synthesize eInput;
@synthesize muInput;
@synthesize outputVelocity;
@synthesize velocityLabel;
@synthesize VEL_CONST;
@synthesize muLabel;
@synthesize zInputExponent;
@synthesize kInputExponent;
@synthesize eInputExponent;
@synthesize muInputExponent;

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
    self.title = @"Ion Trapping Rate";
    
    self.VEL_CONST = 1.69 * pow(10, 7);
    
    self.zInput.text = @"";
    self.zInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.kInput.text = @"";
    self.kInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.kInput.clearButtonMode = true;
    
    self.eInput.text = @"";
    self.eInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.eInput.clearButtonMode = true;
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInput.clearButtonMode = true;

    self.zInputExponent.text = @"0";
    self.zInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInputExponent.clearButtonMode = true;
    
    self.kInputExponent.text = @"0";
    self.kInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.kInputExponent.clearButtonMode = true;
    
    self.eInputExponent.text = @"0";
    self.eInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.eInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInputExponent.clearButtonMode = true;
    
    self.outputVelocity.text = @"0";
    self.outputVelocity.layer.borderWidth = 1.0;
    self.outputVelocity.layer.cornerRadius = 5;
    self.outputVelocity.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.muLabel.text = @"\u03BC";
    
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

- (float) calculateFrequencyWithInput:(float)z with:(float)k with:(float)e with:(float)m{
    return self.VEL_CONST * pow(z, .5) * pow(k, .5) * pow(e, .5) * pow(m, -.5);
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
    NSRange mu_base = [regexBase rangeOfFirstMatchInString:muInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[muInput.text length])];
    NSRange mu_exp = [regexExp rangeOfFirstMatchInString:muInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[muInputExponent.text length])];
    
    if(k_base.location != NSNotFound
       && k_exp.location != NSNotFound
       && z_base.location != NSNotFound
       && z_exp.location != NSNotFound
       && mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound
       && e_base.location != NSNotFound
       && e_exp.location != NSNotFound){
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float k = [self.kInput.text floatValue] * pow(10, [self.kInputExponent.text floatValue]);
        float e = [self.eInput.text floatValue] * pow(10, [self.eInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g, %g", z, k, e, m);
        
        //do calculations
        float f = [self calculateFrequencyWithInput:z with:k with:e with:m];
        
        self.outputVelocity.text = [[NSString alloc] initWithFormat:@"%.3e", f];
    }
    else{
        self.outputVelocity.text = @"Error with input";
    }
}

@end
