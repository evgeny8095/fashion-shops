//
//  PurchaseService.m
//  ipc
//
//  Created by Mahmood1 on 11/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PurchaseService.h"


@implementation PurchaseService

-(id) init
{
	if (self = [super init]) {
        _purchased = [[NSMutableDictionary alloc] init];
        _purchasedProducts = [[NSMutableArray alloc] init];
	} 
	return self;	
}

-(void)dealloc
{
    [_purchased release];
    [_purchasedProducts release];
    [_purchasedProductString release];
    [super dealloc];
}

-(NSMutableArray*) purchasedProducts
{
    return _purchasedProducts;
}

-(NSString*) purchasedProductStringFormat
{
    return _purchasedProductString;
}

-(void) loadPurchasedProducts
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingPathComponent:@"Purchased.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"Purchased" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:bundle toPath:plistPath error:&error];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *temp = (NSDictionary*)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    _purchased = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"Purchased"]];
    if ([[_purchased objectForKey:@"Products"] count] != 0) {
        for (NSInteger i = 0; i < [[_purchased objectForKey:@"Products"] count]; i++)
        {
            [_purchasedProducts addObject:[[_purchased objectForKey:@"Products"] objectAtIndex:i]];
        }
    }
    NSLog(@"number of purchased product: %i", [_purchasedProducts count]);
    [_purchasedProductString release];
    _purchasedProductString = [self generatePurchasedString];
}

-(void) savePurchasedProducts
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingPathComponent:@"Purchased.plist"];
    
    NSArray *products = _purchasedProducts;
    NSDictionary *purchased = [NSDictionary dictionaryWithObject:products forKey:@"Products"];
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:purchased forKey:@"Purchased"];
    [plistDict writeToFile:plistPath atomically:YES];
}

-(void) addPurchasedProduct:(NSInteger)pid
{
    if (_purchasedProducts != nil)
    {
        NSString *temp = [[NSString alloc] initWithFormat:@"%i", pid];
        [_purchasedProducts addObject:temp];
        [temp release];
        [_purchasedProductString release];
        _purchasedProductString = [self generatePurchasedString];
        [self savePurchasedProducts];
    }
}

-(void) clearAllPurchasedProducs
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingPathComponent:@"Purchased.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:plistPath error:&error];
//        [_purchased release];
//        _purchased = nil;
//        [_purchasedProducts release];
//        _purchasedProducts = nil;
        _purchased = [[NSMutableDictionary alloc] init];
        _purchasedProducts = [[NSMutableArray alloc] init];
        [self loadPurchasedProducts];
    }
}

-(NSMutableString*) generatePurchasedString
{
    NSMutableString* str = [[NSMutableString alloc] initWithString:@""];
    NSInteger count = [_purchasedProducts count];
    for (NSInteger i = 0; i < count; i++) {
        if (i == count-1)
            [str appendString:[NSString stringWithFormat:@"%@", [_purchasedProducts objectAtIndex:i]]];
        else
            [str appendString:[NSString stringWithFormat:@"%@,", [_purchasedProducts objectAtIndex:i]]];
    }
    return str;
}


@end
