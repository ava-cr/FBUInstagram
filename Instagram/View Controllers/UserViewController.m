//
//  UserViewController.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import "UserViewController.h"
#import "UserProfileTopCollectionCell.h"
#import "UserProfilePhotoCollectionCell.h"

@interface UserViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    
    self.navigationItem.title = self.user.username;
    
    [self getPosts];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        
        UserProfileTopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserProfileTopCollectionCell" forIndexPath:indexPath];
        
        cell.profilePicImageView.layer.cornerRadius = cell.profilePicImageView.layer.bounds.size.height / 2;
        
        
        PFFileObject *pfFile = [self.user objectForKey:@"profilePic"];
        
        NSURL *url = [NSURL URLWithString:pfFile.url];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        cell.profilePicImageView.image = [[UIImage alloc] initWithData:urlData];
        
        cell.usernameLabel.text = self.user.username;
        cell.numPostsLabel.text = [NSString stringWithFormat:@"%d", (int)[self.posts count]];
        
        return cell;
    }
    
    else {
        
        UserProfilePhotoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserProfilePhotoCollectionCell" forIndexPath:indexPath];
        
        if ([self.posts count] != 0) {
            Post *post = self.posts[indexPath.item - 1];
            
            
            cell.post = post;
            
            NSURL *url = [NSURL URLWithString:post.image.url];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            cell.postImageView.image = [[UIImage alloc] initWithData:urlData];
            
            
        }
        return cell;
    }

}
- (void) getPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query includeKey:@"author"];
    [query includeKey:@"profilePic"];
    // [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query whereKey:@"author" equalTo:self.user];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

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
        return CGSizeMake(CGRectGetWidth(collectionView.frame), 140);
    }
    
    else {
        return CGSizeMake((CGRectGetWidth(collectionView.frame) - 2.2) /3.0, (CGRectGetWidth(collectionView.frame) - 2.2) /3.0);
    }
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
