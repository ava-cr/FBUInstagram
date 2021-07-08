//
//  UserProfilePhotoCollectionCell.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserProfilePhotoCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
