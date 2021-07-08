//
//  ProfileViewController.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/7/21.
//

#import "ProfileViewController.h"
#import "PhotoCollectionViewCell.h"
#import "UserInfoCollectionViewCell.h"
#import <Parse/Parse.h>
#import "Post.h"
#import "DetailsViewController.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    
    [refreshControl setTintColor:[UIColor whiteColor]];
    [self.collectionView insertSubview:refreshControl atIndex:0];
    
    
    [self getPosts];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        PFUser *user = [PFUser currentUser];
        UserInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserInfoCollectionViewCell" forIndexPath:indexPath];
        
        cell.profPicImageView.layer.cornerRadius = cell.profPicImageView.layer.bounds.size.height / 2;
        
        
        cell.editProfileButton.layer.cornerRadius = 5;
        cell.editProfileButton.layer.borderColor = [UIColor.darkGrayColor CGColor];
        cell.editProfileButton.layer.borderWidth = 0.5;
        
        PFFileObject *pfFile = [user objectForKey:@"profilePic"];
        
        NSURL *url = [NSURL URLWithString:pfFile.url];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        cell.profPicImageView.image = [[UIImage alloc] initWithData:urlData];
        
        cell.usernameLabel.text = user.username;
        cell.numPostsLabel.text = [NSString stringWithFormat:@"%d", (int)[self.posts count]];
        
        return cell;
    }
    
    else {
        
        PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
        
        if ([self.posts count] != 0) {
            Post *post = self.posts[indexPath.item - 1];
            
            
            cell.post = post;
            
            NSURL *url = [NSURL URLWithString:post.image.url];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            cell.picImageView.image = [[UIImage alloc] initWithData:urlData];
            
            
        }
//        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
        
        
        return cell;
    }

}


// Makes a network request to get updated data
// Updates the collection view with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self getPosts];
    [refreshControl endRefreshing];
}

- (void) getPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query includeKey:@"profilePic"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    // query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            NSLog(@"got user's posts");
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.posts count] + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 180);
    }
    
    else {
        return CGSizeMake((CGRectGetWidth(collectionView.frame) - 2.2) /3.0, (CGRectGetWidth(collectionView.frame) - 2.2) /3.0);
    }
    
    // return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"showDetails"]) {
        NSLog(@"viewing details");
        PhotoCollectionViewCell *tappedCell = sender;
        //NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        Post *post = tappedCell.post;
        
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
}


@end
