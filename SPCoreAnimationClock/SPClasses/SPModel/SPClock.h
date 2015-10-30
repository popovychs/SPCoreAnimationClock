//
//  SPClock.h
//  SPCoreAnimationClock
//
//  Created by popovychs on 28.10.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SPClock : UIControl
{
    NSTimer *updateTimer;
    
    CAShapeLayer *hourArrow;
    CAShapeLayer *minuteArrow;
    CAShapeLayer *secondArrow;
}

- (void) startUpdates;
- (void) stopUpdates;

@end
