//
//  AboutController.h
//  FPP
//
//  Created by Ethan Wessel on 1/8/14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
#define URLEMail @"mailto:ejwessel@gmail.com?subject=title&body=content"
@end
