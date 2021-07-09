//
//  Like.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/9/21.
//

#import "Like.h"
#import "Post.h"

@implementation Like

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Like";
}

+ (void) postUserLikeOnPost: (Post * _Nullable )post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Like *newLike = [Like new];
    newLike.author = [PFUser currentUser];
    newLike.post = post;
    
    [newLike saveInBackgroundWithBlock: completion];
}

@end
