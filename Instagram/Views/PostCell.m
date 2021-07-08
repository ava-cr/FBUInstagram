//
//  PostCell.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/6/21.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // add three tap gesture recognizers for profile photo, username at top of post,
    // and username at bottom of post -- you can't add one to two items it seems
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    
    [self.profilePicImageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profilePicImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *usernameTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUsername:)];
    
    [self.usernameLabel addGestureRecognizer:usernameTapGestureRecognizer];
    [self.usernameLabel setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *bottomUsernameTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapBottomUsername:)];
    
    [self.bottomUsernameLabel addGestureRecognizer:bottomUsernameTapGestureRecognizer];
    [self.bottomUsernameLabel setUserInteractionEnabled:YES];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    //TODO: Call method delegate
    [self.delegate postCell:self didTap:self.post.author];
}

- (void) didTapUsername:(UITapGestureRecognizer *)sender{
    //TODO: Call method delegate
    [self.delegate postCell:self didTap:self.post.author];
}

- (void) didTapBottomUsername:(UITapGestureRecognizer *)sender{
    //TODO: Call method delegate
    [self.delegate postCell:self didTap:self.post.author];
}

@end
