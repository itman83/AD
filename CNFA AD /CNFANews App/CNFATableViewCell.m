//
//  CNFATableViewCell.m
//  CNFANews App
//
//  Created by iMac Apple on 06/11/13.
//  Copyright (c) 2013 CNFA. All rights reserved.
//

#import "CNFATableViewCell.h"
#import "CNFAGlobalDataClass.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@implementation CNFATableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      
//        _crossLabel = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [ _crossLabel.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
//        [ _crossLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [ _crossLabel setTitle:@"DELETE" forState:UIControlStateNormal];
//      
//        [_crossLabel setBackgroundColor:[UIColor redColor]];
//        //[ _crossLabel setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"menubuttonbase" ofType:@"png"]] forState:UIControlStateNormal];
//        //[ _crossLabel addTarget:self action:@selector(thedragon_btnAction) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_crossLabel];
        if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
            UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
            
            recognizer.delegate = self;
            [self addGestureRecognizer:recognizer];
        }
       
    }
    return self;
}
//- (void)panRecognized:(UIPanGestureRecognizer *)rec
//{
//    CGPoint vel = [rec velocityInView:self.view];
//    if (vel.x > 0)
//    {
//        // user dragged towards the right
//       
//    }
//    else
//    {
//        // user dragged towards the left
//        counter--;
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:YES animated:YES];

    // Configure the view for the selected state
}
#define inset 1.0f

- (void)setFrame:(CGRect)frame
{
    // To bring about the rounded corner radius in iOS7
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        frame.origin.x += inset;
        frame.size.width -= 2 * inset;
        [super setFrame:frame];
        
        super.layer.cornerRadius = 5.0f;
        [super setClipsToBounds:YES];
    }
    else
    {
        
        [super setFrame:frame];
        
        
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
     NSLog(@"\n\n%@\n\n",[self subviews]);
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        [[self.subviews objectAtIndex:2] setFrame:CGRectMake(220 , 0,
                                                             70.0f, self.bounds.size.height-2)];
    }
    
//
//    [[[self.superview subviews] objectAtIndex:9 ] setHidden:NO];

}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
   if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
   {
    CGPoint translation = [gestureRecognizer translationInView:[self superview]];
    
    if (fabsf(translation.x) > fabsf(translation.y) ) {
        return YES;
    }
   }
    return NO;
}
BOOL _deleteOnDragRelease;
CGPoint _originalCenter;
CGPoint _originalCenter1;


-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    
        
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
       
            UITableView *tv=(UITableView *)[self superview];
            NSIndexPath *indexPath = [(UITableView *)[self superview] indexPathForCell:(UITableViewCell *)self];
            CNFAGlobalDataClass *obj=[CNFAGlobalDataClass getInstance];
            
            if (indexPath.row !=obj.indPath.row) {
                NSLog(@"ROWWW:%d",obj.indPath.row);
                UITableViewCell *c=(UITableViewCell *)[tv cellForRowAtIndexPath:obj.indPath];
                CGRect originalFrame = CGRectMake(c.frame.origin.x, c.frame.origin.y,
                                                  c.bounds.size.width, c.bounds.size.height);
                dragged=0;
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     c.backgroundView.frame = originalFrame;
                                     [UIView animateWithDuration:1.0
                                                      animations:^{
                                                          [[c.subviews objectAtIndex:2] setAlpha:0.0f];
                                                      }
                                                      completion:^(BOOL finished){
                                                          // Do other things
                                                      }];
                                 }
                 ];
            }
        
            //            NSUInteger row =[indexPath row];
          
        
       
            
        _originalCenter =  self.backgroundView.center;
        _originalCenter1 =  [[self.subviews objectAtIndex:3] center];
        
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        NSLog(@"UIGestureRecognizerStateChanged");
         CGPoint translation = [recognizer translationInView:self];
        if (dragged==0 && translation.x<0 ) {
            _deleteOnDragRelease=0;
            NSLog(@"x--->%f\n y---->%f",translation.x,translation.y);
            
            [[self.subviews objectAtIndex:2] setHidden:NO];
            [[self.subviews objectAtIndex:2] setAlpha:1.0f];
            self.backgroundView.center = CGPointMake(_originalCenter.x +(-70.0f), _originalCenter.y);
            [[self.subviews objectAtIndex:3] setCenter:CGPointMake(_originalCenter1.x-70 , _originalCenter1.y)];


        }
        else if(translation.x>0)
        {
            _deleteOnDragRelease=1;
        }
           }
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CNFAGlobalDataClass *obj=[CNFAGlobalDataClass getInstance];
        obj.indPath= [(UITableView *)[self superview] indexPathForCell:(UITableViewCell *)self];
        //NSLog(@"%d",obj.indPath.row);
        tagg=self.tag;
        dragged=1;
       
        CGRect originalFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                          self.bounds.size.width, self.bounds.size.height);
        if (_deleteOnDragRelease==1) {
             dragged=0;
            
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.backgroundView.frame = originalFrame;
                                 [UIView animateWithDuration:1.0
                                                  animations:^{
                                                      [[self.subviews objectAtIndex:2] setAlpha:0.0f];
                                                  }
                                                  completion:^(BOOL finished){
                                                      // Do other things
                                                  }];
                             }
             ];
        }
		    }
}

@end
