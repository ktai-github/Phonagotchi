//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "Pet.h"

@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) Pet *cat;
@property (nonatomic) BOOL isAppleBeingPinched;
@property (nonatomic) UIImageView *appleImageView;

@end

@implementation LPGViewController
- (IBAction)moodChange:(id)sender {
  [self.cat moodChange];
  self.petImageView.image = self.cat.currentStateImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.cat = [[Pet alloc] init];

    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
  self.petImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
  
  UIPanGestureRecognizer *panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPanned:)];
//  self.petImageView.isUserInteractionEnabled = TRUE;
  [self.petImageView addGestureRecognizer:panGestureRec];
//
//  UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognized:)];
//  [self.appleImageView addGestureRecognizer:pinchRecognizer];
  [self setupAppleImageView];
}

- (void) setupAppleImageView {
  self.appleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  self.appleImageView.translatesAutoresizingMaskIntoConstraints = NO;
  
  self.appleImageView.image = [UIImage imageNamed:@"apple.png"];
  
  self.appleImageView.userInteractionEnabled = YES;
  
  [self.view addSubview:self.appleImageView];
  
  UIPanGestureRecognizer *panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
  [self.appleImageView addGestureRecognizer:panGestureRec];
  
  UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognized:)];
  [self.appleImageView addGestureRecognizer:pinchRecognizer];
  
  [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:15.0].active = YES;
  
  [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.0].active = YES;
  
  [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.0].active = YES;

  [NSLayoutConstraint constraintWithItem:self.appleImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150.0].active = YES;
}
- (IBAction)viewPanned:(UIPanGestureRecognizer *)gestureRecognizer {

  CGPoint velocityPoint = [gestureRecognizer velocityInView:self.petImageView];
//  NSLog(@"%@", NSStringFromCGPoint(velocityPoint));
  if (velocityPoint.x > 2000.0 || velocityPoint.y > 2000.0) {
    self.cat.grumpy = YES;
//    self.cat.currentStateImage = [UIImage imageNamed:@"grumpy.png"];
    [self.cat enterCurrentStateImage:[UIImage imageNamed:@"grumpy.png"]];
    self.petImageView.image = [self.cat returnCurrentStateImage];

//    NSLog(@"grumpy");
  }
}
- (void) pinchGestureRecognized:(UIPinchGestureRecognizer *) recognizer {
  self.isAppleBeingPinched = YES;
}

- (void) panGestureRecognized:(UIPinchGestureRecognizer *) recognizer {
  if (self.isAppleBeingPinched) {
    CGPoint appleLocation = [recognizer locationInView:self.view];
    self.appleImageView.center = appleLocation;
    
    switch (recognizer.state) {
      case UIGestureRecognizerStateEnded:
        if (CGRectContainsPoint(self.petImageView.frame, appleLocation)) {
          self.appleImageView.alpha = 0;
          [self resetApple];
        } else  {
          [UIView animateWithDuration:2 animations:^{
            CGFloat newYLocation = CGRectGetMaxY(self.view.frame) + CGRectGetHeight(self.appleImageView.frame);
            self.appleImageView.center = CGPointMake(self.appleImageView.frame.origin.x, newYLocation);
          } completion:^(BOOL finished) {
            [self resetApple];
          }];
        }
        break;
        
      default:
        break;
    }
  }
}

- (void) resetApple {
  self.isAppleBeingPinched = NO;
  self.appleImageView = nil;
  [self.appleImageView removeFromSuperview];
  [self setupAppleImageView];
}

@end
