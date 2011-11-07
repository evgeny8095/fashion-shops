//
//  InfoCollectorViewController.h
//  ipc
//
//  Created by Mahmood1 on 10/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ipcGlobal.h"

@protocol InfoCollectorViewControllerDelegate
-(void) didSaveAndSentSuccessfuly;
@end

@interface InfoCollectorViewController : UIViewController {
    id<InfoCollectorViewControllerDelegate> _delegate;
}

@property (nonatomic,assign) id<InfoCollectorViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *fullName;
@property (nonatomic, retain) IBOutlet UITextField *phone;
@property (nonatomic, retain) IBOutlet UITextField *email;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, retain) IBOutlet UIButton *button;

-(BOOL) validateTextField;
-(IBAction) saveInfoOrSentRequest;
-(BOOL) isEmailValidated:(NSString*)checkString;

@end
