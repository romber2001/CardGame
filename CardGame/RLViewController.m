//
//  RLViewController.m
//  CardGame
//
//  Created by Romber Li on 9/5/14.
//  Copyright (c) 2014 Romber Co., Ldt. All rights reserved.
//

#import "RLViewController.h"
#import "RLPlayingCardDeck.h"
#import "RLCardMatchingGame.h"

@interface RLViewController ()

@property (strong, nonatomic) RLDeck *deck;
@property (nonatomic, strong) RLCardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegControl;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UISlider *choiceSlider;
@property (strong, nonatomic) NSMutableArray *historyChoices;

@end

@implementation RLViewController

- (RLCardMatchingGame *)game
{
    if (!_game) {
        _game = [[RLCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                    usingDeck:[self createDeck]];
    }
    
    return _game;
}

- (RLDeck *)createDeck
{
    return [[RLPlayingCardDeck alloc] init];
}

- (RLDeck *)deck {
    if (! _deck) {
        _deck = [self createDeck];
    }
    
    return _deck;
}

- (NSMutableArray *)historyChoices {
    if (! _historyChoices) {
        _historyChoices = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    
    return _historyChoices;
}
                 
- (IBAction)startNewGame:(UIButton *)sender {
    self.game = nil;
    self.choiceSlider.value = 0.0;
    self.choiceSlider.maximumValue = 0.0;
    self.historyChoices = nil;
    self.modeSegControl.enabled = YES;
    
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSegControl.enabled = NO;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex withMode:self.modeSegControl.selectedSegmentIndex];
    [self.historyChoices addObject:self.game.message];
    self.choiceSlider.maximumValue = [self.historyChoices count];
    self.choiceSlider.value = self.choiceSlider.maximumValue;
    
    [self updateUI];
}

- (IBAction)displayHistoryChoices:(UISlider *)sender {
    [self updateUI];
}


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        RLCard *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    
    if (self.choiceSlider.value == self.choiceSlider.maximumValue) {
        self.choiceSlider.alpha = 1.0;
        self.messageLabel.text = [self.historyChoices lastObject];
    } else {
        self.choiceSlider.alpha = 0.3;
        self.messageLabel.text = [self.historyChoices objectAtIndex: (int) self.choiceSlider.value];
    }
}

- (NSString *)titleForCard:(RLCard *)card
{
    return card.isChosen ? card.contents : nil;
}

- (UIImage *)backgroundImageForCard:(RLCard *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
