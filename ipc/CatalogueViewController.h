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
}

@property (nonatomic, retain) IBOutlet UILabel *catelogueLabel;

-(IBAction)goToCatalogue1;

@end
