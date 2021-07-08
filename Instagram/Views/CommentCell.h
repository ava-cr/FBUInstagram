//
//  CommentCell.h
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@end

NS_ASSUME_NONNULL_END
