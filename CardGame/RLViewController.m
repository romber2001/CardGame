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
                 
- (IBAction)startNewGame:(UIButton *)sender {
    self.game = nil;
    //self.deck = nil;
    [self updateUI];
    self.modeSegControl.enabled = YES;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.modeSegControl.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    
    if (self.modeSegControl.selectedSegmentIndex == 0) {
        [self.game chooseCardAtIndex:cardIndex withMode:self.modeSegControl.selectedSegmentIndex];
    } else {
        [self.game chooseCardAtIndex:cardIndex withMode:self.modeSegControl.selectedSegmentIndex];
    }
    
    [self updateUI];
}


- (IBAction)displayHistoryChoices:(UISlider *)sender {
    [self updateUIofSlider:sender];
}

- (void)updateUIofSlider:(UISlider *)slider {
    //int i = (int) slider.value;
    if (slider.value != slider.maximumValue) {
        self.messageLabel.text = [NSString stringWithFormat:@"%.0f", slider.value];
    } else {
        self.messageLabel.text = [NSString stringWithFormat:@"%.0f", slider.value];
    }
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        RLCard *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.messageLabel.text = self.game.message;
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
