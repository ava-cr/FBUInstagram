//
//  CommentsViewController.m
//  Instagram
//
//  Created by Ava Crnkovic-Rubsamen on 7/8/21.
//

#import "CommentsViewController.h"
#import <Parse/Parse.h>
#import "CommentCell.h"
#import "Comment.h"

@interface CommentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *comments;


@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.commentTextView.layer.borderColor = [UIColor.grayColor CGColor];
    self.commentTextView.layer.borderWidth = 0.75;
    self.commentTextView.layer.cornerRadius = 8;
    self.commentTextView.textContainer.lineFragmentPadding = 10;
    
    [self getComments];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    if (indexPath.row == 0) {
        cell.commentTextField.text = self.post.caption;
        cell.usernameLabel.text = self.post.author.username;
        
        PFFileObject *pfFile = [self.post.author objectForKey:@"profilePic"];
        
        NSURL *profURL = [NSURL URLWithString:pfFile.url];
        NSData *profURLData = [NSData dataWithContentsOfURL:profURL];
        cell.profileImageView.image = [[UIImage alloc] initWithData:profURLData];
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.layer.bounds.size.height / 2;
    }
    else if (self.comments) {
        Comment *comment = self.comments[indexPath.row - 1];
        cell.commentTextField.text = comment.text;
        cell.usernameLabel.text = comment.author.username;
        
        PFFileObject *pfFile = [comment.author objectForKey:@"profilePic"];
        
        NSURL *profURL = [NSURL URLWithString:pfFile.url];
        NSData *profURLData = [NSData dataWithContentsOfURL:profURL];
        cell.profileImageView.image = [[UIImage alloc] initWithData:profURLData];
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.layer.bounds.size.height / 2;
        
    }
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.comments count] + 1; // the caption is the first comment
}
- (IBAction)didTapPost:(id)sender {
    [Comment postUserCommentOnPost:self.commentTextView.text onPost:self.post withCompletion:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"the comment was posted!");
            [self getComments];
            [self.tableView reloadData];
            self.commentTextView.text = @"";
            [self.view endEditing:YES];
        } else {
            NSLog(@"problem saving comment: %@", error.localizedDescription);
        }
    }];
}



- (void) getComments {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Comment"];
    [query includeKey:@"author"];
    //[query orderByDescending:@"createdAt"];
    [query whereKey:@"post" equalTo:self.post];
    // query.limit = numberPosts;
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        if (comments != nil) {
            self.comments = comments;
            NSLog(@"got comments");
            NSLog(@"%@", self.comments);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

// code to move the view up when the keyboard shows
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -(keyboardSize.height + 20);
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
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
