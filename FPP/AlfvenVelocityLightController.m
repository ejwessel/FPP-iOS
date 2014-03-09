//
//  AlfenVelocityLightController.m
//  FPP
//
//  Created by Ethan Wessel on 12/31/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "AlfvenVelocityLightController.h"

@interface AlfvenVelocityLightController ()

@end

@implementation AlfvenVelocityLightController
@synthesize muInput;
@synthesize nInput;
@synthesize bInput;
@synthesize VALUE_CONST;
@synthesize muLabel;
@synthesize muInputExponent;
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
    self.title = @"Alfv\u00E9n Velocity/c";
    
    self.VALUE_CONST = 7.28;
    
    self.muInput.text = @"";
    self.muInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.muInput.clearButtonMode = true;
    [self.muInput becomeFirstResponder];
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.nInput.clearButtonMode = true;
    
    self.bInput.text = @"";
    self.bInput.inputView = [LNNumberpad defaultLNNumberpad];
    self.bInput.clearButtonMode = true;
    
    self.muInputExponent.text = @"0";
    self.muInputExponent.inputView = [LNNumberpad defaultLNNumberpad];
    self.muInputExponent.clearButtonMode = true;
    
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

- (float) calculateWithInput:(float)m with:(float)n with:(float)b{
    return self.VALUE_CONST * pow(m, -.5) * pow(n, -.5) * b;
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
       && mu_base.location != NSNotFound
       && mu_exp.location != NSNotFound){
        float t = [self.muInput.text floatValue] * pow(10,[self.muInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10,[self.nInputExponent.text floatValue]);
        float b = [self.bInput.text floatValue] * pow(10,[self.bInputExponent.text floatValue]);
        NSLog(@"number: %g, %g, %g", t, n, b);
        
        //do calculations
        float l = [self calculateWithInput:t with:n with:b];
        
        self.outputAnswer.text = [[NSString alloc] initWithFormat:@"%.3e", l];
    }
    else{
        self.outputAnswer.text = @"Error with input";
    }
}


@end
