//
//  FavouriteService.h
//  ipc
//
//  Created by Mahmood1 on 9/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
