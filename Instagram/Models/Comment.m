//
//  Comment.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import "Comment.h"
#import "Post.h"

@implementation Comment

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic text;
@dynamic post;

+ (nonnull NSString *)parseClassName {
    return @"Comment";
}

+ (void) postUserCommentOnPost: ( NSString * _Nullable )comment onPost: (Post * _Nullable )post withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Comment *newComment = [Comment new];
    newComment.text = comment;
    newComment.author = [PFUser currentUser];
    newComment.post = post;
    
    [newComment saveInBackgroundWithBlock: completion];
}

@end
