//
//  RLCard.h
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLCard : NSObject

@property (nonatomic, strong) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL mactched;

- (NSInteger) match:(NSArray *)otherCards;

@end
