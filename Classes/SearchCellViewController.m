//
//  SearchCellViewController.m
//  MisteryShip
//
//  Created by David Calavera on 09/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SearchCellViewController.h"


@implementation SearchCellViewController

@synthesize titleLabel, addressLabel, localityLabel, imageView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		self.titleLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:16.0 bold:YES];

		[self.contentView addSubview:self.titleLabel];
		[self.titleLabel release];
		
        self.addressLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		[self.contentView addSubview:self.addressLabel];
		[self.addressLabel release];
		
		self.localityLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:14.0 bold:NO];
		[self.contentView addSubview:self.localityLabel];
		[self.localityLabel release];
		
		self.imageView = [[UIImageView alloc] init];
	}
	
	return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setData:(NSDictionary *)dict {
	self.titleLabel.text = [dict objectForKey: Api11870Title];
	self.addressLabel.text = [dict objectForKey: Api11870Address];
	self.localityLabel.text = [dict objectForKey: Api11870Locality];
	
	if (nil != [dict objectForKey: Api11870Thumbnail]) {
		NSURL *url = [NSURL URLWithString: [dict objectForKey: Api11870Thumbnail]];
		UIImage *thumbnail = [UIImage imageWithData: [NSData dataWithContentsOfURL: url]];
		self.imageView = [[UIImageView alloc] initWithImage: thumbnail];
		[self.contentView addSubview: self.imageView];
		[self.imageView release];
	}
	
}

- (void)layoutSubviews {
    [super layoutSubviews];
	
    CGRect contentRect = self.contentView.bounds;
	
    if (!self.editing) {
        CGFloat boundsX = contentRect.origin.x;
		
		self.imageView.frame = CGRectMake(boundsX + 10, 10, 50, 50);
		self.titleLabel.frame = CGRectMake(boundsX + 70, 7, 200, 20);
		self.addressLabel.frame = CGRectMake(boundsX + 70, 28, 200, 14);
		self.localityLabel.frame = CGRectMake(boundsX + 70, 45, 200, 14);
	}
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold {
	UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	
	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

- (void)dealloc {
	[titleLabel dealloc];
	[addressLabel dealloc];
	[imageView dealloc];
    [super dealloc];
}


@end
