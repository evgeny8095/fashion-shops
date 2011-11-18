//
//  FavouriteService.h
//  ipc
//
//  Created on 9/27/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"


@interface FavouriteService : NSObject {
    NSMutableDictionary *_favourite;
    NSMutableArray *_favouriteProducts;
    NSMutableString *_favouriteProductString;
}

-(NSMutableArray*) favouriteProducts;
-(void) loadFavouriteProducts;
-(void) saveFavouriteProducts;
-(void) addFavouriteProduct:(NSInteger)pid;
-(void) removeFavouriteProduct:(NSInteger)pid;
-(void) clearAllFavoriteProducts;
-(NSString*) favouriteProductStringFormat;
-(NSMutableString*) generateFavouriteString;

@end
