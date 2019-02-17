//
//  LyricsView.m
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/15.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LyricsView.h"

@interface LyricsView()

@property (nonatomic, strong) NSArray * lyricsArray;

@end


@implementation LyricsView

- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        [self addLyricsContentView];

        [self importlyricsFile];
        [self addLyricsLayers];
    }
    return self;
}

- (void)addBlurView {
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleDark];
        UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
        blurEffectView.frame = self.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview: blurEffectView];
    } else {
        self.backgroundColor = [UIColor blackColor];
    }
}

- (void)addLyricsContentView {
    
    self.lyricsContentView = [UIView new];
    [self.lyricsContentView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.lyricsContentView setBackgroundColor: [UIColor grayColor]];
    [self addSubview: self.lyricsContentView];

    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                                 attribute: NSLayoutAttributeTop
                                                                 relatedBy: NSLayoutRelationEqual
                                                                    toItem: self
                                                                 attribute: NSLayoutAttributeTop
                                                                multiplier: 1
                                                                  constant: 50]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                                 attribute: NSLayoutAttributeBottom
                                                                 relatedBy: NSLayoutRelationEqual
                                                                    toItem: self
                                                                 attribute: NSLayoutAttributeBottom
                                                                multiplier: 1
                                                                  constant: -50]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                      attribute: NSLayoutAttributeLeadingMargin
                                                      relatedBy: NSLayoutRelationEqual
                                                         toItem: self
                                                      attribute: NSLayoutAttributeLeadingMargin
                                                     multiplier: 1
                                                       constant: 0]];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem: self.lyricsContentView
                                                      attribute: NSLayoutAttributeTrailingMargin
                                                      relatedBy: NSLayoutRelationEqual
                                                         toItem: self
                                                      attribute: NSLayoutAttributeTrailingMargin
                                                     multiplier: 1
                                                       constant: 0]];
    [self layoutIfNeeded];
}

- (void)addLyricsLayers {
    
    NSMutableArray * array = [NSMutableArray arrayWithArray: self.lyricsArray];
    
    CGSize lyricsLayerSize = self.lyricsContentView.frame.size;
    CGFloat totalHight = lyricsLayerSize.height;
    CGFloat totalWidth = lyricsLayerSize.width;
    
    int i = 0;
    CGFloat textLayerHeight = 35.0;
    
//    while (totalHight > 0)  {
    
    while (array.count) {
        
        CATextLayer * textLayer = [CATextLayer new];
        [textLayer setFrame: CGRectMake(0, textLayerHeight * i, totalWidth, textLayerHeight)];
        [textLayer setBackgroundColor: [UIColor darkGrayColor].CGColor];
//        [textLayer setBorderColor: [UIColor blackColor].CGColor];
//        [textLayer setBorderWidth: 1.0];
        [textLayer setString: array[0]];
        [textLayer setFontSize: 18];
        [textLayer setAlignmentMode: kCAAlignmentCenter];
        
        [self.lyricsContentView.layer addSublayer: textLayer];
        [array removeObjectAtIndex: 0];
        
        i += 1;
        totalHight -= 35.0;
    }
    
    self.lyricsContentView.clipsToBounds = YES;
}

- (void)highlightText: (CATextLayer *)lyrics {
    
    [lyrics setBackgroundColor: [UIColor whiteColor].CGColor];
    [lyrics setForegroundColor: [UIColor blackColor].CGColor];
}

- (void)lyricsWillScroll {
    
    
}

// Import Lyrics file (should move to VC or model)
- (void)importlyricsFile {
    
    // TODO: Modified to return NSArray rather than stored in global property.
    
    NSString * filePath = [[NSBundle mainBundle] pathForResource: @"Lyrics" ofType: @"txt"];
    NSError * error;
    NSString * fileContents = [NSString stringWithContentsOfFile: filePath encoding: NSUTF8StringEncoding error: &error];
    
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    }
    
    // TODO: Modified NSMutableArray
    self.lyricsArray = [fileContents componentsSeparatedByString: @"\n"];
    
    NSLog(@"items = %lu", (unsigned long)[self.lyricsArray count]);
}

@end
