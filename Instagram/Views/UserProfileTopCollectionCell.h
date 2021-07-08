//
//  UserProfileTopCollectionCell.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfileTopCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numPostsLabel;

@end

NS_ASSUME_NONNULL_END
