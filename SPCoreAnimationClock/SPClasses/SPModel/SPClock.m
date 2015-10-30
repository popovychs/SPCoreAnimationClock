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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 2.f, 2.f);
    CGPathAddLineToPoint(path, nil, 2.f, self.bounds.size.height / 2.f);
    
    minuteArrow.bounds = CGRectMake(0.f, 0.f, 5.f, self.bounds.size.height / 2.f);
    minuteArrow.anchorPoint = CGPointMake(0.5f, 0.8f);
    minuteArrow.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    minuteArrow.lineWidth = 5.f;
    minuteArrow.strokeColor = [[UIColor blackColor]CGColor];
    minuteArrow.path = path;
    minuteArrow.shadowOffset = CGSizeMake(0.f, 3.f);
    minuteArrow.shadowOpacity = 0.3f;
    minuteArrow.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:minuteArrow];
    
    //clock hour arrow
    
    hourArrow = [CAShapeLayer layer];
    path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 3.f, 0.f);
    CGPathAddLineToPoint(path, nil, 3.f, self.bounds.size.height / 3.f);
    
    hourArrow.bounds = CGRectMake(0.f, 0.f, 7.f, self.bounds.size.height / 2.f);
    hourArrow.anchorPoint = CGPointMake(0.5f, 0.8f);
    hourArrow.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    hourArrow.lineWidth = 7.f;
    hourArrow.strokeColor = [[UIColor blackColor]CGColor];
    hourArrow.path = path;
    hourArrow.shadowOffset = CGSizeMake(0.f, 3.f);
    hourArrow.shadowOpacity = 0.3f;
    hourArrow.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:hourArrow];
    
    //clock mid point
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    
    path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake(0.f, 0.f, 11.f, 11.f));
    
    circle.fillColor = [[UIColor yellowColor]CGColor];
    circle.bounds = CGRectMake(0.f, 0.f, 11.f, 11.f);
    circle.path = path;
    circle.shadowOffset = CGSizeMake(0.f, 5.f);
    circle.shadowOpacity = 0.3f;
    circle.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    [self.layer addSublayer:hourArrow];
    
    [self updateHands];
}

#pragma mark - settings methods

- (void) startUpdates
{
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                   target:self
                                                 selector:@selector(updateHands)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void) stopUpdates
{
    [updateTimer invalidate];
    updateTimer = nil;
}

- (void) updateHands
{
    NSDate * now = [NSDate date];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:now];
    
    NSInteger minutesIntoDay = [components hour] * 60 + [components minute];
    CGFloat percentageMinutesIntoDay = minutesIntoDay / (12.f * 60.f);
    CGFloat percentageMinutesIntoHour = (CGFloat)[components minute] / 60.f;
    CGFloat percentageSecondsIntoMinute = (CGFloat)[components second] / 60.f;
    
    secondArrow.transform = CATransform3DMakeRotation((M_PI * 2) * percentageSecondsIntoMinute, 0.f, 0.f, 1.f);
    minuteArrow.transform = CATransform3DMakeRotation((M_PI * 2) * percentageMinutesIntoHour, 0.f, 0.f, 1.f);
    hourArrow.transform = CATransform3DMakeRotation((M_PI * 2) * percentageMinutesIntoDay, 0.f, 0.f, 1.f);
}

@end
