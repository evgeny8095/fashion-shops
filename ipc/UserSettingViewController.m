//
//  UserSettingViewController.m
//  ipc
//
//  Created by Mahmood1 on 11/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserSettingViewController.h"
#import "ipcGlobal.h"


@implementation UserSettingViewController

@synthesize toolbar;
@synthesize fullName, phone, email;

#pragma mark -
#pragma mark View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:spacer];
    [spacer release];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 0.0f, self.view.frame.size.width, 28.0f)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:@"Thông Tin Cá Nhân"];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
    
    UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:spacer2];
    [spacer2 release];
    
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    [items addObject:title];
    [title release];
    
    [self.toolbar setItems:items animated:YES];
    [items release];
    
    REQ_SERVICE(reqSrv);
    [fullName setText:[reqSrv fullName]];
    [phone setText:[reqSrv phone]];
    [email setText:[reqSrv email]];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	
	self.toolbar = nil;
}

- (BOOL) validateTextField
{
    Boolean flag = YES;
    if ([[fullName text] isEqualToString:@""]) {
        [fullName setPlaceholder:@"Họ và Tên đang bỏ trống"];
        [fullName setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:0.1]];
        flag = NO;
    }
    if ([[phone text] isEqualToString:@""]) {
        [phone setPlaceholder:@"Số điện thoại đang bỏ trống"];
        flag = NO;
    }
    if (![self isEmailValidated:[email text]]){
        [email setText:@""];
        [email setPlaceholder:@"Email không đúng định dạng"];
        flag = NO;
    }
    return flag;
}

-(BOOL) isEmailValidated:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *filterString = @"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? filterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(IBAction) changeUserInformation
{
    if ([self validateTextField]) {
        REQ_SERVICE(reqSrv);
        [reqSrv setFullName:fullName.text];
        [reqSrv setPhone:phone.text];
        [reqSrv setEmail:email.text];
        [reqSrv saveUserInformation];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông Báo" message:@"Quy khách đã thay đổi thành công thông tin cá nhân." delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark -
#pragma mark Managing the popover

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Add the popover button to the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray insertObject:barButtonItem atIndex:0];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Remove the popover button from the toolbar.
    NSMutableArray *itemsArray = [toolbar.items mutableCopy];
    [itemsArray removeObject:barButtonItem];
    [toolbar setItems:itemsArray animated:NO];
    [itemsArray release];
}


#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [toolbar release];
    [super dealloc];
}	


@end