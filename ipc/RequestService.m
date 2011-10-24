//
//  RequestService.m
//  ipc
//
//  Created by Mahmood1 on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RequestService.h"
#import "ipcGlobal.h"


@implementation RequestService
@synthesize isInfoNull = _isInfoNull, fullName = _fullName, phone = _phone, email = _email, pid = _pid, cart = _cart;

-(id) init
{
	if (self == [super init]) {
        _isInfoNull = YES;
	} 
	return self;	
}

-(void)dealloc
{
    [super dealloc];
}

-(void) loadUserInformation
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingFormat:@"User.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"User" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *temp = (NSDictionary*)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    _information = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"Information"]];
    if ([_information count] != 0) {
        _fullName = [[NSString alloc] initWithString:[_information objectForKey:@"Fullname"]];;
        _phone = [[NSString alloc] initWithString:[_information objectForKey:@"Phone"]];
        _email = [[NSString alloc] initWithString:[_information objectForKey:@"Email"]];
    }
    NSLog(@"User info: %@,%@,%@", _fullName, _phone, _email);
    if ([_fullName isEqualToString:@""] || _fullName == NULL || [_phone isEqualToString:@""] || _phone == NULL || [_email isEqualToString:@""] || _email == NULL)
        _isInfoNull = YES;
    else
        _isInfoNull = NO;
}

- (void)saveUserInformation
{
    if (_isInfoNull) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentPath stringByAppendingFormat:@"User.plist"];
        
        NSString *errorDesc = nil;
        
        NSMutableDictionary *information = [[NSMutableDictionary alloc] init];
        [information setObject:_fullName forKey:@"Fullname"];
        [information setObject:_phone forKey:@"Phone"];
        [information setObject:_email forKey:@"Email"];
        
        NSDictionary *plistDict = [NSDictionary dictionaryWithObject:information forKey:@"Information"];
        [information release];
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDesc];
        
        if (plistData) {
            [plistData writeToFile:plistPath atomically:YES];
        }
        else
        {
            NSLog(@"Error in save: %@", errorDesc);
            [errorDesc release];
        }
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
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", response);
}
@end
