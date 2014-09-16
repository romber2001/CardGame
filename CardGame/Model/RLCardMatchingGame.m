//
//  RLCardMatchingGame.m
//  CardGame
//
//  Created by Romber Li on 9/14/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLCardMatchingGame.h"

@interface RLCardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of card

@end

@implementation RLCardMatchingGame

- (NSMutableArray *)cards
{
    if (! _cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger) count usingDeck:(RLDeck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            RLCard *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    RLCard *card = [self cardAtIndex:index];
    
    
}
- (RLCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
