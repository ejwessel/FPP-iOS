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
@synthesize zInputExponent;
@synthesize muInputExponent;
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
    self.title = @"Ion Collision Rate";
    
    self.VEL_CONST = 4.80 * pow(10, -8);
    
    self.zInput.text = @"";
    self.zInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInput.clearButtonMode = true;
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInput.clearButtonMode = true;
    
    self.coulombInput.text = @"";
    self.coulombInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.coulombInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInputExponent.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInputExponent.clearButtonMode = true;
    
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
    
    self.muLabel.text = @"\u03BC =";
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

- (float) calculateFrequencyWithInput:(float)z with:(float)m with:(float)n with:(float)c with:(float)t{
    return self.VEL_CONST * pow(z,4) * pow(m, -.5) * n * c * pow(t, -1.5);
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
       && z_base.location != NSNotFound
       && z_exp.location != NSNotFound
       && mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound
       && coulomb_base.location != NSNotFound
       && coulomb_exp.location != NSNotFound
       && t_base.location != NSNotFound
       && t_exp.location != NSNotFound){
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float c = [self.coulombInput.text floatValue] * pow(10, [self.coulombInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
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
