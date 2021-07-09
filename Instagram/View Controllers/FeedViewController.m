//
//  FeedViewController.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/6/21.
//

#import "FeedViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailsViewController.h"
#import <DateTools/DateTools.h>
#import "UserViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, PostCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (nonatomic) BOOL loadedAllData;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [refreshControl setTintColor:[UIColor whiteColor]];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getPosts:20];
}
- (IBAction)logoutButtonPressed:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
    
    NSLog(@"%s", "logout");
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    myDelegate.window.rootViewController = loginViewController;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = self.posts[indexPath.row];
    if (self.posts) {
        cell.post = post;
        cell.delegate = self; // for tap gesture recognizer
        cell.usernameLabel.text = post.author.username;
        cell.bottomUsernameLabel.text = post.author.username;
        cell.profilePicImageView.layer.cornerRadius = cell.profilePicImageView.layer.bounds.size.height / 2;
        cell.captionTextField.text = post.caption;
                
        NSURL *url = [NSURL URLWithString:post.image.url];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        cell.postImageView.image = [[UIImage alloc] initWithData:urlData];
        
        NSDate *createdAt = post.createdAt;
        NSString *createdAtString = createdAt.shortTimeAgoSinceNow;
        cell.timestampLabel.text = [createdAtString stringByAppendingString:@" ago"];
        
        PFFileObject *pfFile = [post.author objectForKey:@"profilePic"];
        
        NSURL *profURL = [NSURL URLWithString:pfFile.url];
        NSData *profURLData = [NSData dataWithContentsOfURL:profURL];
        cell.profilePicImageView.image = [[UIImage alloc] initWithData:profURLData];
        
        // num likes label
        if (cell.post.likeCount.intValue == 1) {
            cell.numLikesLabel.text = [cell.post.likeCount.stringValue stringByAppendingString:@" like"];
        }
        else cell.numLikesLabel.text = [cell.post.likeCount.stringValue stringByAppendingString:@" likes"];
        
    }
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (void) getPosts: (int) numberPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query orderByDescending:@"createdAt"];
    query.limit = numberPosts;
    // query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            NSLog(@"got posts");
            if ([self.posts count] < numberPosts) self.loadedAllData = true;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}



// infinite scrolling method
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.loadedAllData && indexPath.row + 1 == [self.posts count]){
        [self getPosts:(int)([self.posts count]+20)];
        NSLog(@"loading more data");
    }
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    [self getPosts:20];

    [refreshControl endRefreshing];
}

- (void)postCell:(PostCell *)postCell didTap:(PFUser *)user{
    // TODO: Perform segue to profile view controller
    NSLog(@"%@", user.username);
    [self performSegueWithIdentifier:@"showProfile" sender:user];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"showDetails"]) {
        NSLog(@"viewing details");
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
    else if ([segue.identifier isEqual:@"showProfile"]){
        UserViewController *userViewController = [segue destinationViewController];
        userViewController.user = sender;
    }
}


@end
