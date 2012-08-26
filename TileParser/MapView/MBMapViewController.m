//
//  MBMapViewController.m
//  TileParser
//
//  Created by Moshe Berman on 8/17/12.
//
//

#import "MBMapViewController.h"

#import "MBTileParser.h"

#import "MBMap.h"

#import "MBTileParser.h"

@interface MBMapViewController ()

@property (nonatomic, strong) MBTileParser *parser;
@property (nonatomic, strong) MBMap *map;

@end

@implementation MBMapViewController

- (id)initMapName:(NSString *)name{
    self = [super init];
    if (self) {
        
        _mapView = [[MBMapView alloc] init];
        
        [self loadMap:name];
    }
    return self;
}

- (void)loadView{
    [self setView:self.mapView];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    CGRect frame = [[[self view] superview] frame];
    [[self view] setFrame:frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Loading a Game Map

- (void) loadMap:(NSString *)mapName{
    
    [self setParser: [[MBTileParser alloc] initWithMapName:mapName]];
    
    //
    //  Keep a weak reference to self to
    //  avoid retain cycle
    //
    
    __weak MBMapViewController *weakSelf = self;
    
    MBTileParserCompletionBlock block = ^(MBMap *map){
        
        __strong MBMapViewController *strongSelf = weakSelf;
        
        [[strongSelf mapView] loadMap:map];
        
    };
    
    [_parser setCompletionHandler:block];
    
    [_parser start];
}

@end