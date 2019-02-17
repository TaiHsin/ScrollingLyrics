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
    
    [NSTimer scheduledTimerWithTimeInterval: 5 target: self selector: @selector(scrollLyrics:) userInfo: nil repeats: YES];
}

- (void)scrollLyrics: (NSTimer *)timer {
    
    [self.lyricsView lyricsWillScroll];
}

@end
