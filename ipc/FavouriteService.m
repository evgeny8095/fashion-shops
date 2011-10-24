//
//  FavouriteService.m
//  ipc
//
//  Created by Mahmood1 on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FavouriteService.h"


@implementation FavouriteService

-(id) init
{
	if (self == [super init]) {
        _favourite = [[NSMutableDictionary alloc] init];
        _favouriteProducts = [[NSMutableArray alloc] init];
	} 
	return self;	
}

-(void)dealloc
{
    [_favourite release];
    [_favouriteProducts release];
    [_favouriteProductString release];
    [super dealloc];
}

-(NSMutableArray*) favouriteProducts
{
    return _favouriteProducts;
}

-(NSString*) favouriteProductStringFormat
{
    return _favouriteProductString;
}

-(void) loadFavouriteProducts
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingFormat:@"Data.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *temp = (NSDictionary*)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    _favourite = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"Favourite"]];
    if ([[_favourite objectForKey:@"Products"] count] != 0) {
        for (NSInteger i = 0; i < [[_favourite objectForKey:@"Products"] count]; i++)
        {
            [_favouriteProducts addObject:[[_favourite objectForKey:@"Products"] objectAtIndex:i]];
        }
    }
    NSLog(@"number of favourite product: %i", [_favouriteProducts count]);
    [_favouriteProductString release];
    _favouriteProductString = [self generateFavouriteString];
}

-(void) saveFavouriteProducts
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingFormat:@"Data.plist"];
    
    NSString *errorDesc = nil;
    NSArray *products = _favouriteProducts;
    NSDictionary *favourite = [NSDictionary dictionaryWithObject:products forKey:@"Products"];
    
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:favourite forKey:@"Favourite"];
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDesc];
    
    if (plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
    {
        NSLog(@"Error in save: %@", errorDesc);
        [errorDesc release];
    }
}

-(void) addFavouriteProduct:(NSInteger)pid
{
    if (_favouriteProducts != nil)
    {
        NSString *temp = [[NSString alloc] initWithFormat:@"%i", pid];
        [_favouriteProducts addObject:temp];
        [temp release];
        [_favouriteProductString release];
        _favouriteProductString = [self generateFavouriteString];
        [self saveFavouriteProducts];
    }
}

-(void) removeFavouriteProduct:(NSInteger)pid
{
    if (_favouriteProducts != nil) {
        NSUInteger indexToRemove;
        BOOL removeIndicator = NO;
        for ( NSString* temp in _favouriteProducts )
        {
            if ([temp isEqualToString:[NSString stringWithFormat:@"%i", pid]]) {
                indexToRemove = [_favouriteProducts indexOfObject:temp];
                removeIndicator = YES;
            }
        }
        if (removeIndicator){
             [_favouriteProducts removeObjectAtIndex:indexToRemove];
            [_favouriteProductString release];
            _favouriteProductString = [self generateFavouriteString];
            [self saveFavouriteProducts];
        }
    }
}

-(NSMutableString*) generateFavouriteString
{
    
    NSMutableString* str = [[NSMutableString alloc] initWithString:@""];
    NSInteger count = [_favouriteProducts count];
    for (NSInteger i = 0; i < count; i++) {
        if (i == count-1)
            [str appendString:[NSString stringWithFormat:@"%@", [_favouriteProducts objectAtIndex:i]]];
        else
            [str appendString:[NSString stringWithFormat:@"%@,", [_favouriteProducts objectAtIndex:i]]];
    }
    return str;
}

@end
