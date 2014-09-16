//
//  RLPlayingCard.m
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLPlayingCard.h"

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
