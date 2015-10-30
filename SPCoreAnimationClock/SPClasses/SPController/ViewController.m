//
//  ViewController.m
//  SPCoreAnimationClock
//
//  Created by popovychs on 28.10.15.
//  Copyright © 2015 popovychs. All rights reserved.
//

#import "ViewController.h"
#import "SPClock.h"

@interface ViewController ()

@property (weak,nonatomic) IBOutlet UIView * clockView;
@property (strong,nonatomic) SPClock * analogClock;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setClock];
}

- (void) setClock
{
    CGRect clockFrame = CGRectMake(0, 0, 250, 250);
    self.analogClock = [[SPClock alloc] initWithFrame:clockFrame];
    
    [self.clockView addSubview:self.analogClock];
    [self.analogClock startUpdates];
}

@end