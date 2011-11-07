//
//  UserSettingViewController.h
//  ipc
//
//  Created by Mahmood1 on 11/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingMasterViewController.h"


@interface UserSettingViewController : UIViewController <SubstitutableDetailViewController> {
    UIToolbar *toolbar;
    UILabel *titleLabel;
}
@property (nonatomic, retain) IBOutlet UITextField *fullName;
@property (nonatomic, retain) IBOutlet UITextField *phone;
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIButton *button;

-(IBAction) changeUserInformation;
-(BOOL) validateTextField;
-(BOOL) isEmailValidated:(NSString*)checkString;

@end
