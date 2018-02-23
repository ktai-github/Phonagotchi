//
//  Pet.m
//  Phonagotchi
//
//  Created by KevinT on 2018-02-22.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import "Pet.h"

@implementation Pet



- (instancetype)init
{
  self = [super init];
  if (self) {
    _grumpy = FALSE;
    _sleeping = FALSE;
    _currentStateImage = [UIImage imageNamed:@"default.png"];
  }
  return self;
}

- (BOOL) moodChange {
  NSLog(@"%i", self.grumpy);
  if (self.grumpy == TRUE) {
    self.grumpy = FALSE;
    NSLog(@"%i", self.grumpy);

    self.currentStateImage = [UIImage imageNamed:@"default.png"];
  } else {
    self.grumpy = TRUE;
    NSLog(@"%i", self.grumpy);

    self.currentStateImage = [UIImage imageNamed:@"grumpy.png"];
  }
  return self.grumpy;
}

- (void) enterCurrentStateImage:(UIImage *)petImage {
  self.currentStateImage = petImage;
}


- (UIImage *) returnCurrentStateImage {
  return self.currentStateImage;
}

@end
