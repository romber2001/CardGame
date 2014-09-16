//
//  RLDeck.m
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLDeck.h"

@interface RLDeck()

@end

@implementation RLDeck

- (NSMutableArray *)cards {
    if (! _cards) {
        _cards = [[NSMutableArray alloc]init];
    }
    
    return _cards;
}

- (void)addCard:(RLCard *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(RLCard *)card {
    [self addCard:card atTop:NO];
}

- (RLCard *)drawRandomCard {
    RLCard *randomCard = nil;
    
    if ([self.cards count]) {
        NSUInteger index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
