//
//  Comment.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comment : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) Post *post;
@property (nonatomic, strong) NSString *text;

+ (void) postUserCommentOnPost: ( NSString * _Nullable )comment onPost: ( Post * _Nullable )post withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
