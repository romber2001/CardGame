//
//  RLCardMatchingGame.h
//  CardGame
//
//  Created by Romber Li on 9/14/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLCard.h"
#import "RLDeck.h"

@interface RLCardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(RLDeck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (RLCard *)cardAtIndex:(NSUInteger)index;

- (void)chooseCardAtIndex:(NSUInteger)index withMode:(NSUInteger)mode;

@end
