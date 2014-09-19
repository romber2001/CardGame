//
//  RLPlayingCard.m
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLPlayingCard.h"
@interface RLPlayingCard()

@end

@implementation RLPlayingCard

@synthesize suit = _suit;

- (NSInteger)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        RLPlayingCard *otherCard = [otherCards firstObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        } else if (self.rank == otherCard.rank) {
            score = 4;
        }
    } else {
        NSCountedSet *rankSet = [[NSCountedSet alloc] init];
        NSCountedSet *suitSet = [[NSCountedSet alloc] init];
        
        [rankSet addObject:[NSNumber numberWithInteger:self.rank]];
        [suitSet addObject:self.suit];
        
        for (RLPlayingCard *card in otherCards) {
            [rankSet addObject:[NSNumber numberWithInteger:card.rank]];
            [suitSet addObject:card.suit];
        }
        
        int suitScore = 0;
        int rankScore = 0;
        
        for (NSNumber *rankNumber in rankSet) {
            int rankCount = [rankSet countForObject:rankNumber] -1;
            if (rankCount) {
                rankScore += pow(4, rankCount);
            }
        }
        
        for (NSString *suitString in suitSet) {
            int suitCount = [suitSet countForObject:suitString] -1;
            if (suitCount) {
                rankScore += suitCount * suitCount;
            }
        }
        
        score = rankScore + suitScore > rankScore * suitScore ? rankScore + suitScore : rankScore * suitScore;
        
        rankSet = nil;
        suitSet = nil;
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [RLPlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♣️", @"♠️", @"♥️", @"♦️"];
}

- (void)setSuit:(NSString *)suit {
    if ([[RLPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxrank {
    return [[RLPlayingCard rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [RLPlayingCard maxrank]) {
        _rank = rank;
    }
}

@end
