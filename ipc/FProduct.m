//
//  FProduct.m
//  ipc
//
//  Created by Mahmood1 on 9/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FProduct.h"
#import "FBrand.h"
#import "FCategory.h"
#import "FStore.h"
#import "FType.h"


@implementation FProduct
@dynamic price;
@dynamic name;
@dynamic desc;
@dynamic pid;
@dynamic image;
@dynamic rating;
@dynamic url;
@dynamic categories;
@dynamic typies;
@dynamic store;
@dynamic brand;

- (void)addCategoriesObject:(FCategory *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"categories" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"categories"] addObject:value];
    [self didChangeValueForKey:@"categories" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeCategoriesObject:(FCategory *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"categories" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"categories"] removeObject:value];
    [self didChangeValueForKey:@"categories" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addCategories:(NSSet *)value {    
    [self willChangeValueForKey:@"categories" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"categories"] unionSet:value];
    [self didChangeValueForKey:@"categories" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeCategories:(NSSet *)value {
    [self willChangeValueForKey:@"categories" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"categories"] minusSet:value];
    [self didChangeValueForKey:@"categories" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addTypiesObject:(FType *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"typies" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"typies"] addObject:value];
    [self didChangeValueForKey:@"typies" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeTypiesObject:(FType *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"typies" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"typies"] removeObject:value];
    [self didChangeValueForKey:@"typies" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addTypies:(NSSet *)value {    
    [self willChangeValueForKey:@"typies" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"typies"] unionSet:value];
    [self didChangeValueForKey:@"typies" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeTypies:(NSSet *)value {
    [self willChangeValueForKey:@"typies" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"typies"] minusSet:value];
    [self didChangeValueForKey:@"typies" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}

-(void) copyFromProduct:(Product *)product
{
    [self setPid:[product pid]];
    [self setName:[product name]];
    [self setDesc:[product desc]];
    [self setPrice:[NSString stringWithFormat:@"%i", [product price]]];
    [self setRating:[NSNumber numberWithInteger:[product rating]]];
    [self setImage:[product image]];
    [self setUrl:[product url]];
}

-(Product*) toProduct
{
    Product* product = [[Product alloc] init];
    product.pid = self.pid;
    product.name = self.name;
    product.desc = self.desc;
    product.price = [self.price intValue];
    product.rating = [self.rating intValue];
    product.image = self.image;
    product.url = self.url;
    product.store = [[self store] toStore];
    product.brand = [[self brand] toBrand];
    for (FType* ftype in [self typies]){
        Type* type = [ftype toType];
        [product.types setObject:type forKey:[type tid]];
        [type release];
    }
    for (FCategory* fcategory in [self categories]) {
        Category* category = [fcategory toCategory];
        [product.categories setObject:category forKey:[category cid]];
        [category release];
    }
    return product;
}

@end
