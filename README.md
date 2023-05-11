# ADHD App
## Description
An ADHD community app that allows ADHD patients to help and communicate with each other. It also lets anyone check if they have ADHD or not by uploading their brain MRI to the app and getting diagnosed with the help of a machine learning model.

## Features
### Register to make a new account
- Used Firebase authentication facilities to register new user.
- Used Firestore storage facilities to store the user info provided by it.
- Used provider State Management to navigate easily from Authentication forms (register/login) to home screen depending on whether the user has logged in or not. 
###### Live Demo
<p align="center">
<img  src="https://user-images.githubusercontent.com/129562097/236480587-a95c0900-50d3-4dce-aa92-61ad3fbb39c3.gif" width="250">
</p>
<hr>

### Login to your account.
- Used Firebase authentication facilities to login an existing user.
###### Live Demo
<p align="center">
<img  src="https://user-images.githubusercontent.com/129562097/236484204-bfe1f4b2-03a4-447e-a9ae-98651dc34da0.gif" width="250">
</p>
<hr>


### Upload a post in the community.
- Used FireStore Database to save the users post.
- Users can write their posts and add tag to it then upload it to the timeline.
###### Live Demo
<p align="center">
<img  src="https://github.com/RowanMohamed311/ADHD-App/assets/129562097/6a0afdcf-3555-4547-9dc1-af98562fd6a0" width="250">
</p>
<hr>

### View, Like, Comment on the Posts uploaded on the HomePage.
###### Live Demo
<p align="center">
<img  src="https://github.com/RowanMohamed311/ADHD-App/assets/129562097/d356485f-386b-48da-baa3-93223a0658e9" width="250">
</p>
<hr>


### Search for users/posts.
###### Live Demo
<p align="center">
<img  src="https://github.com/RowanMohamed311/ADHD-App/assets/129562097/36d3ae7b-3aab-4019-a376-a835b3b7efab" width="250">
</p>
<hr>


### Know information about ADHD.
###### Live Demo
<p align="center">
<img  src="https://github.com/RowanMohamed311/ADHD-App/assets/129562097/3df0dbfd-d472-4f91-bfda-0ee78d32f9f3" width="250">
</p>
<hr>

### View and Edit Your profile Info.
###### Live Demo
<p align="center">
<img  src="https://github.com/RowanMohamed311/ADHD-App/assets/129562097/c0d8fa82-0c76-4d65-aba7-1fe63af745e6" width="250">
</p>
<hr>

### Upload a Brain MRI to Check if you have ADHD or not.
- Used File_Picker package to let the users can pick pick their MRIs from the local storage on the mobile or From their drive.
- The app then send the user MRI as A payload in an HTTP post request to the API.
- Used RESTful API (Flask) to load the ML model and Do the Classification on the MRI.
- After the classification is done the result is sent back to the app in an HTTP response.
- the Result is then displayed on the screen.
###### Live Demo
<p align="center">
<img  src="https://github.com/RowanMohamed311/ADHD-App/assets/129562097/d7242e8a-0018-46c9-a094-f64de57c6f78" width="250">
</p>
<hr>

