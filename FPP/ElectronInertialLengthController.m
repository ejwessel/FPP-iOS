//
//  ElectronInertialLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "ElectronInertialLengthController.h"

@interface ElectronInertialLengthController ()

@end

@implementation ElectronInertialLengthController
@synthesize outputAnswer;
@synthesize nInput;
@synthesize CONST_VALUE;
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
    self.title = @"Electron Inertial Length";
    
    self.CONST_VALUE = 5.31 * pow(10, 5);
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInput.clearButtonMode = true;
    [self.nInput becomeFirstResponder];

    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInputExponent.clearButtonMode = true;
    
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

- (float) calculateWithInput:(float)n{
    return self.CONST_VALUE * pow(n, -.5);
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
    
    if(n_base.location != NSNotFound
       && n_exp.location != NSNotFound){
        float n = [self.nInput.text floatValue] * pow(10,[self.nInputExponent.text floatValue]);
        NSLog(@"number: %g", n);
        
        //do calculations
        float r = [self calculateWithInput:n];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}

@end
