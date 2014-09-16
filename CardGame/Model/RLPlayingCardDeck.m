//
//  RLPlayingCardDeck.m
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLPlayingCardDeck.h"

@implementation RLPlayingCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *suit in [RLPlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [RLPlayingCard maxrank]; rank++) {
                RLPlayingCard *card = [[RLPlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

- (void) addCard:(RLPlayingCard *)card {
    [self.cards addObject:card];
}

@end
