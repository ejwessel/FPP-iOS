//
//  IonInertialLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "IonInertialLengthController.h"

@interface IonInertialLengthController ()

@end

@implementation IonInertialLengthController
@synthesize outputAnswer;
@synthesize muInput;
@synthesize nInput;
@synthesize CONST_VALUE;
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
    self.title = @"Ion Inertial Length";
    
    self.CONST_VALUE = 2.28 * pow(10, 7);
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInput.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.muInputExponent.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInputExponent.clearButtonMode = true;
    
    self.outputAnswer.text = @"0";
    self.outputAnswer.layer.borderWidth = 1.0;
    self.outputAnswer.layer.cornerRadius = 5;
    self.outputAnswer.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
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

- (float)calculateWithInput:(float)m with:(float)n{
    return self.CONST_VALUE * pow(m/n, .5);
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

    if(mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound
       && n_base.location != NSNotFound
       && n_exp.location != NSNotFound){
        float m = [self.muInput.text floatValue] * pow(10, [self.muInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", m, n);
        
        //do calculations
        float r = [self calculateWithInput:m with:n];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
