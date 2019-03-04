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
    
    [self.view setBackgroundColor: [UIColor blackColor]];
    [self setupLyrics];
    [self setupLyricsView];
    [NSTimer scheduledTimerWithTimeInterval: 2 target: self
                                   selector: @selector(scrollLyrics:)
                                   userInfo: nil
                                    repeats: YES];
}

- (void)setupLyrics {
    self.lyrics = [[Lyrics alloc] init];
}

- (void)setupLyricsView {
    
    NSArray * lyricsArray = [self.lyrics lyricsArray];
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.lyricsView = [[LyricsView alloc] initWithFrame: rect];
    [self.view addSubview: self.lyricsView];
    
    [self.lyricsView addLyricsLayersWith: lyricsArray];
    [self.lyricsView startLyrics];
}

- (void)scrollLyrics: (NSTimer *)timer {
    
    BOOL isLastLyrics = [self.lyricsView scrollLyrics];
    
    if (isLastLyrics) {
        [timer invalidate];
        timer = nil;
    }
}

@end
