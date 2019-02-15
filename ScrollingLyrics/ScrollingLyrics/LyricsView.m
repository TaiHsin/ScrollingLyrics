//
//  LyricsView.m
//  ScrollingLyrics
//
//  Created by Tsihsin Lee on 2019/2/15.
//  Copyright © 2019 Tsihsin Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LyricsView.h"

//@interface LyricsView()
//
//
//@end


@implementation LyricsView

- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self setBackgroundColor: [UIColor whiteColor]];
        [self addLyricsContentView];
        [self layoutIfNeeded];
        [self addLyricsLayers];
//        [self addBlurView];
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
}

- (void)addLyricsLayers {
    
    CGSize lyricsLayerSize = self.lyricsContentView.frame.size;
    CGFloat totalHight = lyricsLayerSize.height;
    CGFloat totalWidth = lyricsLayerSize.width;
    
//    CGFloat lyricsLayerHeight = lyricsViewHight / 10;
    int multiplier = 0;
    CGFloat textLayerHeight = 40.0;
    
    while (totalHight > 0)  {
        
        CALayer * textLayer = [CALayer new];
        textLayer.frame = CGRectMake(0, textLayerHeight * multiplier, totalWidth, textLayerHeight);
        textLayer.backgroundColor = [UIColor greenColor].CGColor;
        textLayer.borderColor =  [UIColor blackColor].CGColor;
        textLayer.borderWidth = 1.0;
        
        [self.lyricsContentView.layer addSublayer: textLayer];
        
        multiplier += 1;
        totalHight -= 40.0;
    }
    
    self.lyricsContentView.clipsToBounds = YES;
}

@end
