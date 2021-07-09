# Project 4 - *Mockstagram*

**Mockstagram** is a photo sharing app using Parse as its backend.

Time spent: **X** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"
- [X] User can pull to refresh the last 20 posts submitted to "Instagram"
- [X] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [X] Run your app on your phone and use the camera to take the photo
- [X] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [X] Show the username and creation time for each post
- [X] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [X] Allow the logged in user to add a profile photo
  - [X] Display the profile photo with each post
  - [X] Tapping on a post's username or profile photo goes to that user's profile page
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [X] User can comment on a post and see all comments for each post in the post details screen.
- [X] User can like a post and see number of likes for each post in the post details screen.
- [ ] Style the login page to look like the real Instagram login page.
- [X] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [X] Ability to unlike a post!
- [X] I made the keyboard push the view up when you are writing a comment and dismiss automatically/slide the view down when you post it.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would love to discuss further customizing the UI because I wanted to make my app look as much like Instagram as possible but wasn't sure how they made their nav bar look the way it does etc.
2.  I would also like to talk more about animations and how to implement them!

## Video Walkthrough

Here are 5 gifs to walkthrough the implemented user stories:

1. Post details page, like, comment (keyboard slides view up feature), tap profile photo or username to see user profile page.
<img src='https://github.com/ava-cr/FBUInstagram/blob/main/gifs/insta4.gif' title='Video Walkthrough' width='' alt='Video Walkthrough 1' />

2. Sign up, log in, home feed with timestamp, profile photo, username, etc.
<img src='https://github.com/ava-cr/FBUInstagram/blob/main/gifs/insta1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough 1' />

3. Take and post a photo, progress HUD while the post is being uploaded to Parse, pull-to-refresh timeline.
<img src='https://github.com/ava-cr/FBUInstagram/blob/main/gifs/insta2.gif' title='Video Walkthrough' width='' alt='Video Walkthrough 1' />

4.  Tab bar to view currently logged-in user's profile and their feed, edit profile photo.

<img src='https://github.com/ava-cr/FBUInstagram/blob/main/gifs/insta3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough 1' />

5. Infinite scrolling

<img src='https://github.com/ava-cr/FBUInstagram/blob/main/gifs/insta5.gif' title='Video Walkthrough' width='' alt='Video Walkthrough 1' />

All gifs were screen-recorded on an iPhone X.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

- 
    [DateTools](https://github.com/MatthewYork/DateTools#time-ago) - library to streamline date and time handling in iOS.
    
    - 
    [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) - activity monitor library
    
    
    


## Notes

Describe any challenges encountered while building the app.

I encountered some challenges with configuring the layout of my collection view on the profile tab because I wanted to use two different custom cells (one for the header and one for all the photos) and so I had to use a function to define the layouts for each of them.

## License

    Copyright [2021] [Ava Crnkovic-Rubsamen]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
