//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/6/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomUsernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.profilePicImageView.layer.cornerRadius = self.profilePicImageView.layer.bounds.size.height / 2;
    self.captionTextField.text = self.post.caption;
            
    NSURL *url = [NSURL URLWithString:self.post.image.url];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.postImageView.image = [[UIImage alloc] initWithData:urlData];
    
    NSDate *createdAt = self.post.createdAt;
    NSString *createdAtString = createdAt.shortTimeAgoSinceNow;
    self.timestampLabel.text = [createdAtString stringByAppendingString:@" ago"];
    
    self.usernameLabel.text = self.post.author.username;
    self.bottomUsernameLabel.text = self.usernameLabel.text;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
