//
//  Post.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/6/21.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;


@end

NS_ASSUME_NONNULL_END
