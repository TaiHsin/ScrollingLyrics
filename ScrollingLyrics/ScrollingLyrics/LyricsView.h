//
//  LyricsView.h
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/15.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LyricsView: UIView

@property (strong, nonatomic) UIView * lyricsContentView;
@property (strong, nonatomic) UIAccessibilityElement * accessbilityElement;
@property BOOL isLastLyrics;

- (void)startLyrics;
- (BOOL)scrollLyrics;
- (void)addLyricsLayersWith: (NSArray *)lyricsArray;
- (BOOL)isLastLayer: (CATextLayer *)layer;

@end


