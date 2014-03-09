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
@synthesize nInputExponent;
@synthesize bInputExponent;

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
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];
    
    self.bInput.text = @"";
    self.bInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.bInput.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInputExponent.clearButtonMode = true;
    
    self.bInputExponent.text = @"0";
    self.bInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.bInputExponent.clearButtonMode = true;
    
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
    NSRange b_base = [regexBase rangeOfFirstMatchInString:bInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[bInput.text length])];
    NSRange b_exp = [regexExp rangeOfFirstMatchInString:bInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[bInputExponent.text length])];
    if(b_base.location != NSNotFound
       && b_exp.location != NSNotFound
       && n_base.location != NSNotFound
       && n_exp.location != NSNotFound){
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10, [self.bInputExponent.text floatValue]);
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
