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
    
    SPClock * myClock;
    
    [myClock startUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
