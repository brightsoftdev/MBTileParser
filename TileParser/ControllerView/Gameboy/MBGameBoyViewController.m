//
//  MBGameBoyViewController.m
//  TileParser
//
//  Created by Moshe Berman on 8/27/12.
//
//

#import "MBGameBoyViewController.h"

#define kJoystickDiameter 72 
#define kMargin 32

@interface MBGameBoyViewController ()

@end

@implementation MBGameBoyViewController

- (id) init{

    self = [super init];
    
    if (self) {
        
        _joystick = [[MBJoystickView alloc] initWithFrame:CGRectMake(32, 224, kJoystickDiameter, kJoystickDiameter)];
        _joystick.isDPad = YES;
        
        _buttonA = [MBControllerButton buttonWithColor:[UIColor whiteColor]];
        _buttonB = [MBControllerButton buttonWithColor:[UIColor whiteColor]];
        
        _buttonStart = [MBControllerButton buttonWithColor:[UIColor whiteColor]];
        _buttonSelect = [MBControllerButton buttonWithColor:[UIColor whiteColor]];
        
    }
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self observeControls];    
    [self displayControls];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CGRect frame = [[[self view] superview] bounds];
    [[self view] setBounds:frame];
    [[self view] setFrame:frame];
    
    [self layoutControls];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Autorotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation);
    } else {
        return YES;
    }
}

- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskLandscape;
    }else{
        return UIInterfaceOrientationMaskAll;
    }
}

#pragma mark - Controler

- (void) observeControls{
    [[self joystick] addObserver:self forKeyPath:@"velocity" options:NSKeyValueObservingOptionNew context:nil];
    [[self buttonA] addObserver:self forKeyPath:@"isPressed" options:NSKeyValueObservingOptionNew context:nil];
    [[self buttonB] addObserver:self forKeyPath:@"isPressed" options:NSKeyValueObservingOptionNew context:nil];
    [[self buttonSelect] addObserver:self forKeyPath:@"isPressed" options:NSKeyValueObservingOptionNew context:nil];
    [[self buttonStart] addObserver:self forKeyPath:@"isPressed" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)hideControls{
    [[self joystick] removeFromSuperview];
    [[self buttonA] removeFromSuperview];
    [[self buttonB] removeFromSuperview];
    [[self buttonSelect] removeFromSuperview];
    [[self buttonStart] removeFromSuperview];
}

- (void)displayControls{

    MBJoystickView *joystick = [self joystick];
    
    [[self view] addSubview:joystick];
    
    [joystick setBackgroundImage:[UIImage imageNamed:@"dpad"]];
    [joystick setThumbImage:[UIImage imageNamed:@"joystick"]];

    [[self view] addSubview:[self buttonA]];
    [[self buttonA] setRadius:22];
    [[self buttonA] setTitle:@"A" forState:UIControlStateNormal];
    
    [[self view] addSubview:[self buttonB]];
    [[self buttonB] setRadius:22];
    [[self buttonB] setTitle:@"B" forState:UIControlStateNormal];
    
    /*
    [[self view] addSubview:[self buttonStart]];
    [[self view] addSubview:[self buttonSelect]];
     */
}

- (void) layoutControls{
    
    //
    //  TODO: Use Autolayout in here
    //
    
    CGRect joystickFrame = [[self joystick] frame];
    CGRect selfFrame = [[self view] frame];
    CGRect buttonAFrame = [[self buttonA] frame];
    CGRect buttonBFrame = [[self buttonB] frame];
    
    joystickFrame.origin.y = selfFrame.size.height - joystickFrame.size.height - kMargin;
    
    [[self joystick] setFrame:joystickFrame];
    [[self joystick] setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];

    buttonAFrame.origin.x = selfFrame.size.width - buttonAFrame.size.width - kMargin;
    buttonAFrame.origin.y = selfFrame.size.height - buttonAFrame.size.height * 1.75 - kMargin/2;
    
    [[self buttonA] setFrame:buttonAFrame];
    [[self buttonA] setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin];
    
    buttonBFrame.origin.x = selfFrame.size.width - buttonBFrame.size.width * 2 - kMargin;
    buttonBFrame.origin.y = selfFrame.size.height - buttonBFrame.size.height - kMargin/2;
    
    [[self buttonB] setFrame:buttonBFrame];
    [[self buttonB] setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin];
    
}

@end
