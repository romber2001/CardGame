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

- (instancetype)initWithCardCount:(NSUInteger) count
                        usingDeck:(RLDeck *)deck
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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    RLCard *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            //match against another card
            for (RLCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score +=matchScore * MATCH_BONUS;
                        card.mactched = YES;
                        otherCard.mactched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)chooseCardAtIndex:(NSUInteger)index withMode:(NSUInteger)mode
{
    if (mode == 0) {
        [self chooseCardAtIndex:index];
    } else {
        
    }
}

- (RLCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
