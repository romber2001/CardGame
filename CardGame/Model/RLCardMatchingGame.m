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
@property (nonatomic, strong) NSMutableArray *otherCards; //waiting for to be matched
@property (nonatomic, strong) NSString *message;

@end

@implementation RLCardMatchingGame

- (NSMutableArray *)cards
{
    if (! _cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    
    return _cards;
}

- (NSMutableArray *)otherCards
{
    if (!_otherCards) _otherCards = [[NSMutableArray alloc] init];
    
    return _otherCards;
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
            self.message = [NSString stringWithFormat:@"unchoose card %@", card.contents];
        } else {
            //match against another card
            for (RLCard *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score +=matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
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

- (void)chooseCardAtIndex:(NSUInteger)index withMode:(NSInteger)mode
{
    if (mode == 0) {
        [self chooseCardAtIndex:index];
    } else {
        RLCard *card = [self cardAtIndex:index];
        
        if (!card.isChosen) {
            self.message = [NSString stringWithFormat:@"choose card %@", card.contents];
        }
        
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
                card.added = NO;
                [self.otherCards removeObject:card];
                self.message = [NSString stringWithFormat:@"unchoose card %@", card.contents];
            } else {
                //match against other cards
                for (RLCard *otherCard in self.cards) {
                    //preprare card arrays that need to be matched
                    if (otherCard.isChosen && !otherCard.isMatched && !otherCard.isAdded) {
                        [self.otherCards addObject:otherCard];
                        otherCard.Added = YES;
                    }
                }
                
                if ([self.otherCards count] > mode) {
                    int matchScore = [card match:self.otherCards];
                    if (matchScore) {
                        self.score +=matchScore * MATCH_BONUS;
                        
                        while ([self.otherCards count]) {
                            RLCard *matchedCard = self.otherCards[0];
                            matchedCard.matched = YES;
                            NSString *messageString = [messageString stringByAppendingFormat:@" %@", matchedCard.contents];
                            [self.otherCards removeObject:matchedCard];
                        }
                        
                        card.matched = YES;
                        NSString *messageString = [messageString stringByAppendingFormat:@" %@", card.contents];
                        
                        
                        
                    } else {
                        self.score -= MISMATCH_PENALTY * (pow(mode, 2) > 1 ? pow(mode, 2) : 1);
                        RLCard *firstCard = [self.otherCards firstObject];
                        firstCard.chosen = NO;
                        firstCard.added = NO;
                        [self.otherCards removeObject:firstCard];
                    }
                }
            
                self.score -= COST_TO_CHOOSE + mode;
                card.chosen = YES;
                
            }
        }
    }
}

- (RLCard *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
