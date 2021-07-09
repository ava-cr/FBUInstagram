//
//  Like.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/9/21.
//

#import <Parse/Parse.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Like : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) Post *post;

+ (void) postUserLikeOnPost: ( Post * _Nullable )post withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
