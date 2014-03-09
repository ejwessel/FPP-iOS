//
//  DebyeLengthController.m
//  FPP
//
//  Created by Ethan Wessel on 12/27/13.
//  Copyright (c) 2013 test. All rights reserved.
//

#import "DebyeLengthController.h"

@interface DebyeLengthController ()

@end

@implementation DebyeLengthController
@synthesize outputLamda;
@synthesize tInput;
@synthesize nInput;
@synthesize lamdaLabel;
@synthesize LAMDA_CONST;
@synthesize tInputExponent;
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
    self.title = @"Debye Length";
    
    self.LAMDA_CONST = 7.43 * pow(10, 2);
    
    self.tInput.text = @"";
    self.tInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInput.clearButtonMode = true;
    [self.tInput becomeFirstResponder];
    
    self.nInput.text = @"";
    self.nInput.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInput.clearButtonMode = true;
    
    self.tInputExponent.text = @"0";
    self.tInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.tInputExponent.clearButtonMode = true;
    
    self.nInputExponent.text = @"0";
    self.nInputExponent.inputView = [LNNumberpad defaultLNNumberpad];;
    self.nInputExponent.clearButtonMode = true;
    
    self.outputLamda.text = @"0";
    self.outputLamda.layer.borderWidth = 1.0;
    self.outputLamda.layer.cornerRadius = 5;
    self.outputLamda.layer.borderColor = self.navigationController.toolbar.tintColor.CGColor;
    
    self.lamdaLabel.text = @"\u03BB =";
    
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
    return self.LAMDA_CONST * pow(m, 0.5) * pow(n, -0.5);
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
    NSRange t_base = [regexBase rangeOfFirstMatchInString:tInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[tInput.text length])];
    NSRange t_exp = [regexExp rangeOfFirstMatchInString:tInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[tInputExponent.text length])];
    NSRange n_base = [regexBase rangeOfFirstMatchInString:nInput.text
                                                  options:0
                                                    range:NSMakeRange(0,[nInput.text length])];
    NSRange n_exp = [regexExp rangeOfFirstMatchInString:nInputExponent.text
                                                options:0
                                                  range:NSMakeRange(0,[nInputExponent.text length])];
    
    if(t_base.location != NSNotFound
       && t_exp.location != NSNotFound
       && n_base.location != NSNotFound
       && n_exp.location != NSNotFound){
        float t = [self.tInput.text floatValue] * pow(10, [self.tInputExponent.text floatValue]);
        float n = [self.nInput.text floatValue] * pow(10, [self.nInputExponent.text floatValue]);
        NSLog(@"number: %g, %g", t, n);
        
        //do calculations
        float r = [self calculateWithInput:t with:n];
        
        self.outputLamda.text = [[NSString alloc] initWithFormat:@"%.3e", r];
    }
    else{
        self.outputLamda.text = @"Error with input";
    }
}


@end
