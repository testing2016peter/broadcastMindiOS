//
//  BMLoginViewController.m
//  broadcastMindiOS
//
//  Created by Anson Ng on 4/24/16.
//  Copyright © 2016 ap. All rights reserved.
//

#import "BMLoginViewController.h"
#import "BMService.h"

@interface BMLoginViewController ()

@end

@implementation BMLoginViewController

- (void)setupView
{

}

- (IBAction)tapLoginButton:(id)sender
{
    if ([self.emailTextField.text length] > 0 && [self.passwordTextField.text length] > 0) {
        [[BMService sharedInstance] loginUserEmail:self.emailTextField.text password:self.passwordTextField.text success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response:%@", response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            NSLog(@"error:%@", err);
        }];

    }
}
- (IBAction)tapSignUpButton:(id)sender
{
    if ([self.emailTextField.text length] > 0 && [self.passwordTextField.text length] > 0) {
        [[BMService sharedInstance] signUpUserEmail:self.emailTextField.text password:self.passwordTextField.text  success:^(AFHTTPRequestOperation *operation, id response) {
            NSLog(@"response:%@", response);
        } failure:^(AFHTTPRequestOperation *operation, NSError *err) {
            NSLog(@"error:%@", err);
        }];
    }
}

@end
