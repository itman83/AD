//
//  CNFACityCell.m
//  CNFANews App
//
//  Created by Dex on 10/11/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFACityCell.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation CNFACityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#define inset 1.0f

- (void)setFrame:(CGRect)frame
{
    // To bring about the rounded corner radius in iOS7
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        frame.origin.x += inset;
        
        frame.size.width -= 1 * inset;
        [super setFrame:frame];
        
        super.layer.cornerRadius = 5.0f;
        [super setClipsToBounds:YES];
    }
    else
    {
        
        [super setFrame:frame];
        
        
    }
}
@end
