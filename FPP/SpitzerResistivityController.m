//
//  TransverseSpitzerController.m
//  FPP
//
//  Created by Ethan Wessel on 1/1/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "SpitzerResistivityController.h"

@interface SpitzerResistivityController ()

@end

@implementation SpitzerResistivityController
@synthesize outputNPerpendicular;
@synthesize zInput;
@synthesize lamdaInput;
@synthesize tInput;
@synthesize VALUE_CONST;
@synthesize lambaLabel;
@synthesize zInputExponent;
@synthesize lamdaInputExponent;
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
    self.title = @"Spitzer Resistivity";
    
    self.VALUE_CONST = 1.03 * pow(10, -2);
    
    self.zInput.text = @"";
    self.zInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInput.clearButtonMode = true;
    [self.zInput becomeFirstResponder];
    
    self.lamdaInput.text = @"";
    self.lamdaInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.lamdaInput.clearButtonMode = true;
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    
    self.zInputExponent.text = @"0";
    self.zInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.zInputExponent.clearButtonMode = true;
    
    self.lamdaInputExponent.text = @"0";
    self.lamdaInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.lamdaInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInputExponent.clearButtonMode = true;
    
    self.outputNPerpendicular.text = @"0";
    self.outputNPerpendicular.layer.borderWidth = 1.0;
    self.outputNPerpendicular.layer.cornerRadius = 5;
    self.outputNPerpendicular.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.outputNParallel.text = @"0";
    self.outputNParallel.layer.borderWidth = 1.0;
    self.outputNParallel.layer.cornerRadius = 5;
    self.outputNParallel.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.lambaLabel.text = @"ln\u039B =";
    
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

- (float) calculateWithInput:(float)z with:(float)l with:(float)t{
    return self.VALUE_CONST * z * l * pow(t, -1.5);
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
    NSRange lamda_base = [regexBase rangeOfFirstMatchInString:lamdaInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[lamdaInput.text length])];
    NSRange lamda_exp = [regexExp rangeOfFirstMatchInString:lamdaInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[lamdaInputExponent.text length])];
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[tInputExponent.text length])];
   
    if(t_base.location != NSNotFound
       && t_exp.location != NSNotFound
       && z_base.location != NSNotFound
       && z_exp.location != NSNotFound
       && lamda_base.location != NSNotFound
       && lamda_exp.location != NSNotFound){
        float z = [self.zInput.text floatValue] * pow(10, [self.zInputExponent.text floatValue]);
        float l = [self.lamdaInput.text floatValue] * pow(10, [self.lamdaInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", z, l, t);
        
        //do calculations
        float nPerp = [self calculateWithInput:z with:l with:t];
        float nParallel = nPerp / 2.0;
        
        self.outputNPerpendicular.text = [[NSString alloc] initWithFormat:@"%.3e", nPerp];
        self.outputNParallel.text = [[NSString alloc] initWithFormat:@"%.3e", nParallel];
    }
    else{
        self.outputNPerpendicular.text = @"Error with input";
    }
}


@end
