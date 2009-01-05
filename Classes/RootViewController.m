//
//  RootViewController.m
//  MisteryShip
//
//  Created by David Calavera on 12/12/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "MisteryShipAppDelegate.h"
#import "SearchCellViewController.h"
#import "ShowServiceViewController.h"


@implementation RootViewController

@synthesize tableView, resultsArray, loadingLabel, noMatchesLabel, activityIndicatorView;

- (void)viewDidLoad {
    [super viewDidLoad];
	[self loadPrefs];
	//self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	//self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	//self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	//self.navigationController.navigationBarHidden = YES;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SearchCellViewController *cell = (SearchCellViewController *)[self.tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[[SearchCellViewController alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if (indexPath.row % 2 == 0) {
		[self setBackgroundColor: cell color: UIColorFromRGB(0x98979c)];
	} else {
		[self setBackgroundColor: cell color: UIColorFromRGB(0xadadad)];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	NSMutableDictionary *entry = [resultsArray objectAtIndex:indexPath.row];
	[cell setData: entry];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ShowServiceViewController *showServiceViewController = [[ShowServiceViewController alloc] 
															initWithNibName:@"ShowServiceViewController" bundle: [NSBundle mainBundle]];
	
	[showServiceViewController setData: [resultsArray objectAtIndex:indexPath.row]];
	[[self navigationController] pushViewController: showServiceViewController animated:YES];
	[showServiceViewController release];
}

- (void) setBackgroundColor:(UITableViewCell *) cell color:(UIColor *) color {
	UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
	backgroundView.backgroundColor = color;
	cell.backgroundView = backgroundView;
	for ( UIView* view in cell.contentView.subviews ) {
		view.backgroundColor = [ UIColor clearColor ];
	}
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[searchBar resignFirstResponder];
	self.tableView.hidden = YES;
	noMatchesLabel.hidden = YES;
	if (nil != searchBar.text && [searchBar.text length] > 0) {
		loadingLabel.hidden = NO;
		activityIndicatorView.hidden = NO;
		
		resultsArray = [self search: searchBar.text];
		
		if ([resultsArray count] > 0) {
			loadingLabel.hidden = YES;
			activityIndicatorView.hidden = YES;
			self.tableView.hidden = NO;
			self.tableView.separatorColor = UIColorFromRGB(0x7a7b7f);
			[[self tableView] reloadData];
		} else {
			loadingLabel.hidden = YES;
			activityIndicatorView.hidden = YES;
			noMatchesLabel.hidden = NO;
		}
	}
}

- (NSMutableArray *) search:(NSString *)text {
	NSString *apiURL = [[SearchApi11870 stringByAppendingString: text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(apiURL);
	
	NSURL *xmlURL = [NSURL URLWithString: apiURL];
	NSError *error;
	NSData *data = [[[NSData alloc] initWithContentsOfURL:xmlURL options: 0 error: &error] autorelease];
	
	NSMutableArray *entries;
	
	if (nil != data) {
		GDataXMLDocument *doc = [[[GDataXMLDocument alloc] initWithData: data options: 0 error: &error] autorelease];
		
		NSArray *nodes = [[doc rootElement] elementsForName: @"entry"];
		
		entries = [[NSMutableArray alloc] init];
		for (GDataXMLElement *element in nodes) {
			[entries addObject: [self getEntry: element]];
		}
	}
	
	return entries;
}

-(NSMutableDictionary *) getEntry:(GDataXMLElement *) element {
	NSMutableDictionary *entry = [[NSMutableDictionary alloc] init];
	
	NSString *identifier = [[element elementForName: Api11870Id] stringValue];
	[entry setObject: identifier forKey: Api11870Id];
	
	NSString *title = [[element elementForName: Api11870Title] stringValue];
	[entry setObject:title forKey: Api11870Title];
	
	NSString *summary = [[element elementForName: Api11870Summary] stringValue];
	if (nil != summary) {
		[entry setObject: summary forKey: Api11870Summary];
	}
	
	GDataXMLElement *address = [element elementForName: Api11870Address];
	if (nil != address) {
		[entry setObject: [address stringValue] forKey: Api11870Address];
	}
	
	GDataXMLElement *telephone = [element elementForName: Api11870Telephone];
	if (nil != telephone) {
		[entry setObject: [telephone stringValue] forKey: Api11870Telephone];
	}
	
	GDataXMLElement *locality = [element elementForName: Api11870Locality];
	if (nil != locality) {
		[entry setObject: [locality stringValue] forKey: Api11870Locality];
	}
	
	NSArray *links = [element elementsForName: Api11870Link];
	for (GDataXMLElement *link in links) {
		if ([Api11870Media isEqualToString: [[link attributeForName: Api11870Rel] stringValue]]) {
			NSString *thumbnail = [[link attributeForName: Api11870Href] stringValue];
			[entry setObject: thumbnail forKey: Api11870Thumbnail];
			break;
		}
	}
	 
	GDataXMLElement *position = [element elementForName: Api11870GeoWhere];
	if (position != nil) {
		NSString *pos = [[[position childAtIndex: 0] childAtIndex: 0] stringValue];
		[entry setObject: [pos stringByReplacingOccurrencesOfString:@" " withString: @","] forKey: Api11870Position];
	}
	
	return entry;
}

- (void) loadPrefs { 
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//localization = [defaults boolForKey: @"localization"];
	//NSString *local = [defaults stringForKey: @"localization"];
	//ocalization = (char)[local isEqual: @"1"];
	//NSLog(@"%@", localization);
} 


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[loadingLabel release];
	[noMatchesLabel release];
	[activityIndicatorView release];
	[resultsArray release];
    [super dealloc];
}


@end