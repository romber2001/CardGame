//
//  RLDeck.h
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RLCard.h"

@interface RLDeck : NSObject

@property (strong, nonatomic) NSMutableArray *cards;


- (NSMutableArray *)cards;

- (void)addCard:(RLCard *)card atTop:(BOOL)atTop;

- (void)addCard:(RLCard *)card;

- (RLCard *)drawRandomCard;

@end
