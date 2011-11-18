//
//  PurchaseService.h
//  ipc
//
//  Created on 11/2/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PurchaseService : NSObject {
    NSMutableDictionary *_purchased;
    NSMutableArray *_purchasedProducts;
    NSMutableString *_purchasedProductString;
}

-(NSMutableArray*) purchasedProducts;
-(void) loadPurchasedProducts;
-(void) savePurchasedProducts;
-(void) addPurchasedProduct:(NSInteger)pid;
-(void) clearAllPurchasedProducs;
-(NSString*) purchasedProductStringFormat;
-(NSMutableString*) generatePurchasedString;

@end
