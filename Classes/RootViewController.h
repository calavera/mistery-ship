//
//  RootViewController.h
//  MisteryShip
//
//  Created by David Calavera on 12/12/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "GDataXMLNode.h"

@interface RootViewController : UIViewController {
	IBOutlet UITableView *tableView;
	IBOutlet UILabel *loadingLabel;
	IBOutlet UILabel *noMatchesLabel;
	IBOutlet UIActivityIndicatorView *activityIndicatorView;
	
	NSMutableArray *resultsArray;
	BOOL localization;
}

@property(nonatomic, retain) UITableView *tableView;
@property(nonatomic, retain) NSMutableArray *resultsArray;
@property(nonatomic, retain) UILabel *loadingLabel;
@property(nonatomic, retain) UILabel *noMatchesLabel;
@property(nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (void) setBackgroundColor:(UITableViewCell *) cell color:(UIColor *) color;
- (NSMutableArray *) search:(NSString *)text;
-(NSMutableDictionary *) getEntry:(GDataXMLElement *) element;
- (void) loadPrefs;

@end
