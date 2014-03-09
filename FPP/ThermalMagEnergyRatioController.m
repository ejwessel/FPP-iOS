//
//  ThermalMagEnergyRatioController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ThermalMagEnergyRatioController.h"

@interface ThermalMagEnergyRatioController ()

@end

@implementation ThermalMagEnergyRatioController
@synthesize outputAnswer;
@synthesize nInput;
@synthesize tInput;
@synthesize bInput;
@synthesize VALUE_CONST;
@synthesize nInputExponent;
@synthesize tInputExponent;
@synthesize bInputExponent;
@synthesize outputLabel;

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
    self.title = @"Thermal/Mag. Energy Ratio";
    
    self.VALUE_CONST = 4.03 * pow(10, -11);
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.tInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.bInput.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInputExponent.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.tInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.bInputExponent.clearButtonMode = true;
    
    self.outputLabel.text = @"\u03B2 =";
    
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

- (float) calculateWithInput:(float)n with:(float)t with:(float)b{
    return self.VALUE_CONST * n * t * pow(b, -2);
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
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[tInputExponent.text length])];
    NSRange b_base = [regexBase rangeOfFirstMatchInString:bInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[bInput.text length])];
    NSRange b_exp = [regexExp rangeOfFirstMatchInString:bInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[bInputExponent.text length])];
    
    if(b_base.location != NSNotFound
       && b_exp.location != NSNotFound
       && n_base.location != NSNotFound
       && n_exp.location != NSNotFound
       && t_base.location != NSNotFound
       && t_exp.location != NSNotFound){
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", n, t, b);
        
        //do calculations
        float l = [self calculateWithInput:n with:t with:b];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
