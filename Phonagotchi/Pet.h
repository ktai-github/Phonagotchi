//
//  Pet.h
//  Phonagotchi
//
//  Created by KevinT on 2018-02-22.
//  Copyright © 2018 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject

{
//  NSString *defaultPath;
  
}

@property (assign) BOOL grumpy;
@property (assign) BOOL sleeping;
@property (nonatomic) UIImage *currentStateImage;
//@property (nonatomic) NSArray *catImages;
//@property (assign) float wakeful;

- (BOOL) moodChange;
- (void) enterCurrentStateImage:(UIImage *)petImage;
- (UIImage *) returnCurrentStateImage;
//- (void) eat;
//- (void) sleep;

@end
