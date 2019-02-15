//
//  ViewController.m
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/15.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    self.lyricsView = [[LyricsView alloc] initWithFrame: rect];
    [self.view addSubview: self.lyricsView];
}


@end
