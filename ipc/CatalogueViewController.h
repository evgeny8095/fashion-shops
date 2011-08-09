//
//  CatalogueViewController.h
//  ipc
//
//  Created by SaRy on 7/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogueViewController : UIViewController{
    IBOutlet UILabel *catelogueLabel;
    NSDictionary *catelogueDict;
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UILabel *catelogueLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

-(IBAction)gotoCatalogue:(id)sender;

@end
