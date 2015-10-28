//
//  SPClock.m
//  SPCoreAnimationClock
//
//  Created by popovychs on 28.10.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import "SPClock.h"

@implementation SPClock

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setUpClock];
    }
    return self;
}

- (void) setUpClock
{
    CAShapeLayer *face = [CAShapeLayer layer];
    
    //clock face
    
    face.bounds = self.bounds;
    face.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    face.fillColor = [[UIColor greenColor]CGColor];
    face.strokeColor = [[UIColor blackColor]CGColor];
    face.lineWidth = 4.f;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, self.bounds);
    face.path = path;
    
    [self.layer addSublayer:face];
    
    //clock numbers
    
    for (NSInteger i = 1; i <= 12; i++) {
        CATextLayer *number = [CATextLayer layer];
        number.string = [NSString stringWithFormat:@"%i",i];
        number.alignmentMode = @"center";
        number.fontSize = 18.f;
        number.foregroundColor = [[UIColor blackColor]CGColor];
        number.bounds = CGRectMake(0.f, 0.f, 25.f, self.bounds.size.height / 2.f - 10.f);
        number.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        number.anchorPoint = CGPointMake(0.5f, 1.f);
        number.transform = CATransform3DMakeRotation((M_PI * 2) / 12.f * i, 0, 0, 1);
        
        [self.layer addSublayer:number];
    }
    
    //clock second arrow
    
    secondArrow = [CAShapeLayer layer];
    
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 1.f, 0.f);
    CGPathAddLineToPoint(path, nil, 1.f, self.bounds.size.height / 2.f + 8.f);
    
    secondArrow.bounds = CGRectMake(0.f, 0.f, 3.f, self.bounds.size.height / 2.f + 8.f);
    secondArrow.anchorPoint = CGPointMake(0.5, 0.8);
    secondArrow.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    secondArrow.lineWidth = 3.f;
    secondArrow.strokeColor = [[UIColor redColor]CGColor];
    secondArrow.path = path;
    secondArrow.shadowOffset = CGSizeMake(0.f, 3.f);
    secondArrow.shadowOpacity = 0.6f;
    secondArrow.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:secondArrow];
    
    //clock minute arrow
    
    minuteArrow = [CAShapeLayer layer];
}

@end
