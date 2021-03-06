//
//  RequestService.m
//  ipc
//
//  Created on 10/21/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "RequestService.h"
#import "ipcGlobal.h"


@implementation RequestService
@synthesize isInfoNull = _isInfoNull, fullName = _fullName, phone = _phone, email = _email, pid = _pid;

-(id) init
{
	if (self = [super init]) {
        _isInfoNull = YES;
	} 
	return self;	
}

-(void)dealloc
{
    [_information release];
    [_fullName release];
    [_phone release];
    [_email release];
    [_pid release];
    [super dealloc];
}

-(void) loadUserInformation
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingPathComponent:@"User.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"User" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    }
    
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    _information = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"Information"]];
    if ([_information count] != 0) {
        _fullName = [[NSString alloc] initWithString:[_information objectForKey:@"Fullname"]];
        _phone = [[NSString alloc] initWithString:[_information objectForKey:@"Phone"]];
        _email = [[NSString alloc] initWithString:[_information objectForKey:@"Email"]];
    }
    //NSLog(@"User info: %@,%@,%@", _fullName, _phone, _email);
    if ([_fullName isEqualToString:@""] || _fullName == NULL || [_phone isEqualToString:@""] || _phone == NULL || [_email isEqualToString:@""] || _email == NULL)
        _isInfoNull = YES;
    else
        _isInfoNull = NO;
    [temp release];
}

- (void)saveUserInformation
{
    if (_isInfoNull) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentPath stringByAppendingPathComponent:@"User.plist"];
        
        NSMutableDictionary *information = [[NSMutableDictionary alloc] init];
        [information setObject:_fullName forKey:@"Fullname"];
        [information setObject:_phone forKey:@"Phone"];
        [information setObject:_email forKey:@"Email"];
        
        NSDictionary *plistDict = [NSDictionary dictionaryWithObject:information forKey:@"Information"];
        [information release];
        [plistDict writeToFile:plistPath atomically:YES];
        _isInfoNull = NO;
    }
}

- (void) sentSingleProductRequest
{
    HttpRequest* req = [[HttpRequest alloc] initWithFinishTarget:self
													   andAction:@selector(gotResponse: byRequest:)];
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"udid"];
    [dictionary setObject:_pid forKey:@"ids"];
    [dictionary setObject:_fullName forKey:@"name"];
    [dictionary setObject:_phone forKey:@"phone"];
    [dictionary setObject:_email forKey:@"email"];
    [req call:[NSString stringWithFormat:@"%@%@", BASE_URL, REQUEST_PRODUCT_URL] params:dictionary];
    [dictionary release];
	[req release];
}

-(void) gotResponse:(NSData*)data byRequest:(HttpRequest*)req
{
    //NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        NSArray* subviews = window.subviews;
        if ([subviews count] > 0)
            if ([[subviews objectAtIndex:0] isKindOfClass:[UIAlertView class]])
                [(UIAlertView *)[subviews objectAtIndex:0] dismissWithClickedButtonIndex:[(UIAlertView *)[subviews objectAtIndex:0] cancelButtonIndex] animated:NO];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thông Báo" message:@"Yêu cầu của quý khách đã được gửi thành công" delegate:nil cancelButtonTitle:@"Đóng" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}
@end
