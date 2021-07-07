//
//  PhotoCollectionViewCell.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
