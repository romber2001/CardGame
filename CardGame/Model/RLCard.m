//
//  RLCard.m
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLCard.h"

@implementation RLCard

- (NSInteger) match:(NSArray *)otherCards
{
    int score = 0;
    
    for (RLCard *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
