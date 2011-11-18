//
//  FilterDetailsViewController.m
//  ipc
//
//  Created on 10/25/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import "FilterDetailsViewController.h"


@implementation FilterDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithArray:(NSArray*)array forArray:(NSMutableArray *)ref_array
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        optionArray = [array retain];
        chossenArray = ref_array;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary*)dictionary forArray:(NSMutableArray *)ref_array
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        convertedArray = [[NSMutableArray alloc] init];
        optionDictionary = [dictionary retain];
        for (id key in optionDictionary)
            [convertedArray addObject:[optionDictionary objectForKey:key]];
        chossenArray = ref_array;
    }
    return self;
}

- (void)dealloc
{
    [optionArray release];
    [optionDictionary release];
    [convertedArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar.backItem setTitle:@"ALL"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark UITableView delegates
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (optionArray != nil)
        return [optionArray count];
    else
        return [optionDictionary count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[optionArray objectAtIndex:indexPath.row] isKindOfClass:[Type class]]){
        if ([chossenArray containsObject:[optionArray objectAtIndex:indexPath.row]])
        {
            [chossenArray removeObject:[optionArray objectAtIndex:indexPath.row]];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else
        {
            [chossenArray addObject:[optionArray objectAtIndex:indexPath.row]];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
    if ([[convertedArray objectAtIndex:indexPath.row] isKindOfClass:[Brand class]] || [[convertedArray objectAtIndex:indexPath.row] isKindOfClass:[Category class]] || [[convertedArray objectAtIndex:indexPath.row] isKindOfClass:[Store class]]){
        if ([chossenArray containsObject:[convertedArray objectAtIndex:indexPath.row]])
        {
            [chossenArray removeObject:[convertedArray objectAtIndex:indexPath.row]];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        else
        {
            [chossenArray addObject:[convertedArray objectAtIndex:indexPath.row]];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionrow"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionrow"];
    }
    if ([[optionArray objectAtIndex:indexPath.row] isKindOfClass:[Type class]]) {
        cell.textLabel.text = [((Type*)[optionArray objectAtIndex:indexPath.row]) name];
    }
    if ([[convertedArray objectAtIndex:indexPath.row] isKindOfClass:[Brand class]]) {
        cell.textLabel.text = [((Brand*)[convertedArray objectAtIndex:indexPath.row]) name];
    }
    if ([[convertedArray objectAtIndex:indexPath.row] isKindOfClass:[Store class]]) {
        cell.textLabel.text = [((Store*)[convertedArray objectAtIndex:indexPath.row]) name];
    }
    if ([[convertedArray objectAtIndex:indexPath.row] isKindOfClass:[Category class]]) {
        cell.textLabel.text = [((Category*)[convertedArray objectAtIndex:indexPath.row]) name];
    }
    if ([chossenArray containsObject:[optionArray objectAtIndex:indexPath.row]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    if ([chossenArray containsObject:[convertedArray objectAtIndex:indexPath.row]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
}

@end
