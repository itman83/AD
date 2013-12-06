//
//  CNFADummyView.m
//  CNFANews App
//
//  Created by Dex on 10/11/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFADummyView.h"

@implementation CNFADummyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event;
{
    CGPoint pointInHole = [self convertPoint:point toView:self.holeView];
    UIView *viewInHole = [self.holeView hitTest:pointInHole withEvent:event];
    
    if (viewInHole)
        return viewInHole;
    else
        return [super hitTest:point withEvent:event];
}
@end
