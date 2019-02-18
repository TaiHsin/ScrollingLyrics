//
//  ViewController.h
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/15.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LyricsView.h"
#import "Lyrics.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) LyricsView * lyricsView;
@property (nonatomic, strong) Lyrics * lyrics;

@end

