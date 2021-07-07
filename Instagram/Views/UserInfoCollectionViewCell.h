//
//  UserInfoCollectionViewCell.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profPicImageView;
@property (weak, nonatomic) IBOutlet UILabel *numPostsLabel;

@end

NS_ASSUME_NONNULL_END
