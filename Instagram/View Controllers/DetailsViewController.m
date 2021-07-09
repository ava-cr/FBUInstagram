//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/6/21.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import "CommentsViewController.h"
#import "Like.h"
#import <Parse/Parse.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomUsernameLabel;
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property BOOL liked;
@property (strong, nonatomic) Like *like;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

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
    [self updateLikeLabel];
    
    PFFileObject *pfFile = [self.post.author objectForKey:@"profilePic"];
    
    NSURL *profURL = [NSURL URLWithString:pfFile.url];
    NSData *profURLData = [NSData dataWithContentsOfURL:profURL];
    self.profilePicImageView.image = [[UIImage alloc] initWithData:profURLData];
    
    [self getLiked];
    
    
}

-(void) getLiked {
    // did user already like the post
    PFQuery *query = [PFQuery queryWithClassName:@"Like"];
    //[query includeKey:@"author"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query whereKey:@"post" equalTo:self.post];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *likes, NSError *error) {
        if (likes != nil) {
            NSLog(@"user has liked post");
            Like *like = likes[0];
            self.like = like;
            self.liked = true;
            self.likeButton.selected = true;
            
        } else {
            self.liked = false;
            self.likeButton.selected = true;
            NSLog(@"user hasn't liked post");
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


- (IBAction)didTapLike:(id)sender {
    
    
    if (self.liked) {
        self.liked = FALSE;
        self.likeButton.selected = FALSE;
        [self.like deleteInBackground];
        self.post[@"likeCount"] = [NSNumber numberWithInteger:(self.post.likeCount.integerValue - 1)];
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
          if (succeeded) {
              NSLog(@"updated like count!");
              [self updateLikeLabel];
          } else {
              NSLog(@"%@", error.localizedDescription);
          }
        }];
        
    }
    else {
        self.liked = TRUE;
        self.likeButton.selected = TRUE;
        [Like postUserLikeOnPost:self.post withCompletion:^(BOOL succeeded, NSError * error) {
            if (succeeded) {
                NSLog(@"the like was posted!");
                
            } else {
                NSLog(@"problem saving comment: %@", error.localizedDescription);
            }
        }];
        self.post[@"likeCount"] = [NSNumber numberWithInteger:(self.post.likeCount.integerValue + 1)];
        
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
          if (succeeded) {
              NSLog(@"updated like count!");
              [self updateLikeLabel];
          } else {
              NSLog(@"%@", error.localizedDescription);
          }
        }];
    }
}

-(void) updateLikeLabel {
    if (self.post.likeCount.intValue == 1) {
        self.likesLabel.text = [self.post.likeCount.stringValue stringByAppendingString:@" like"];
    }
    else self.likesLabel.text = [self.post.likeCount.stringValue stringByAppendingString:@" likes"];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"commentSegue"]) {
        NSLog(@"going to comments");
        
        CommentsViewController *cvc = [segue destinationViewController];
        cvc.post = self.post;
    }
}


@end
