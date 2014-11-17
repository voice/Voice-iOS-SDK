# Voice Polls SDK and API documentation

## How to add polls to your site or native app
![Voice Embed](/images/voiceEmbed.png)

[Voice Polls](https://voicepolls.com) are a great way to give your audience a voice. This documentation is intended for developers who want to integrate polls into their website or native app.

### Embedded Polls and Surveys

You can embed either a single poll, or a series of polls ("survey").
Both will appear the same on your site. The difference is that a survey
displays a series of polls one poll at a time, automatically
transitioning to the next poll after the viewer votes.

### Examples

###### Embedded single poll
http://thenextweb.com/dd/2013/06/11/poll-what-do-you-think-of-the-new-ios-7-design/

###### Embedded survey 
http://voiceapp.tumblr.com/post/102617249934/voice-surveys

### How To Embed them in your Website or App

We have several options to embed polls in your website or app where we
handle the responsive sizing and user interaction for you.

##### [Embed code](https://voicepolls.com/publisher/how_to/embed_a_poll)

The preferred approach. We give you a <script/> or <iframe> code that you embed in your web page. The code will insert an iframe
containing the polls.

##### iOS SDK

Cocoa Touch classes that you can include in your iOS project. The
classes will create a UIWebView containing the embedded polls.

Embedded solutions are great because you can even customize the colors
of embedded polls to match your site.([see
customization](https://voicepolls.com/publisher/account/theme)).

##### [API](https://voicepolls.com/developers) 

Voice HTTPS/JSON-based API

![Voice voiceRealTime](/images/voiceRealTime.png)

###### Automatically update your embedded content

If you want to change the poll or poll set embedded on your
website *without* changing the code you used to integrate Voice polls,
this is for you. On the website you can make sure the embed will always
fetch your latest poll or survey.

![Voice publisher](/images/voicePublisher.png)

When embedding your polls via the embed code or the iOS SDK, simply make
sure it includes the user id rather than the poll or the survey id.

##### Getting started

The first thing you should do is create a Voice Polls account: https://voicepolls.com/publisher

You’re now ready to start making some great-looking polls or surveys.
You can either create your own, or borrow existing content from our
	community: https://voicepolls.com/publisher/sets/

After you've chosen your content, you're ready to embed some polls on
your site.

##### Contact us

Need a hand getting started? We're happy to help: hello@voicepolls.com

##### Voice-iOS-SDK

The Voice Polls iOS SDK allows you to use Voice Polls inside your own
iOS app. (Read more about integrating Voice Polls.).

When you initialize an instance of VPQuestionView, it creates a
UIWebView that loads embedded Voice polls. You can access this UIWebview
via the webView attribute. Simply add this
UIWebView to your app in any way you like. Note that the maximum size
for the pollView UIWebView is 320\*480.

###### Installation

Voice-iOS-SDK is available through CocoaPods. To install it, simply add the following line to your Podfile:
```
pod 'Voice-iOS-SDK'
```
You can also add the library as shown in the sample.

###### Example project

To run the example project, clone the repo. Then, open the project by
opening the file VoiceSDK.xcworkspace. Select VoiceSDKSample in the
scheme list and run.

###### Usage

Initialisation :
 ```
// Put these lines in your AppDelegate.m in the didFinishLaunchingWithOption method to get your publisher id just open this url (https://voicepolls.com/developers/api#!/account/accountindex) in your browser and click on try it out. You will get a JSon containing an id key.

NSString *publisherId = @"";

[VoicePollsSDK sharedInstance].publisherId = publisherId;
```
VPQuestionView usage :


```
// You can add the VPQuestionView wherever you want like this
VPQuestionView *questionView = [[VPQuestionView alloc] initWithFrame:self.view.bounds];
//here we load a Set with the id 56 you can also load a single question by using 
// [questionView loadQuestion:@"3" completion:^{}];
[questView loadSet:@“56” completion:^{}];
[self.view addSubview:questionView];
``` 
##### VPQuestionView Class API

In order to use the VPQuestionView you need to initialise the
VoicePollsSdk as seen in the Usage part of this documentation.

-   load a single poll

-   load a set of polls

###### Load a single poll
```
- (void)loadQuestion:(NSString *)questionId completion:(void(^)())completion
```
| **Param**                            | **Description**                      |
| -------------------------------------- | -------------------------------------- |
| questionId                           | The ID of the question to load.      |

###### Load a set of polls
```
- (void)loadSet:(NSString *)setId completion:(void(^)())completion
```

| **Param**                            | **Description**                      |
| -------------------------------------- | -------------------------------------- |
| setId                                | The ID of the question set to load.  |


##### VoicePollsSDK Class API

-   Initialize

-   Load and display a single poll

-   Load and display a poll set

-   Load all your questions

-   Load all the questions under a tag

###### Initialize

VoicePollsSDK class is a singleton meaning that you shouldn’t create
your own instance of it. You just need to use [VoicePollsSDK
sharedInstance] and set your publisher ID to initialise it.

All loading methods are asynchrone. There are two completion block the
first one is when the request succeed in this block you have access to a
dictionary (or an array of dictionary) representing the question you’ve
loaded. The second block is a failure block.

###### Load a single poll
```
- (void)getQuestionWithId:(NSString *)questionId success:(void(^)(NSDictionary *question))success failure:(void(^)(NSError *error))failure
```
| **Param**                            | **Description**                      |
| -------------------------------------- | -------------------------------------- |
| questionId                           | The ID of the question to load.      |

###### Load a poll set
```
- (void)getQuestionsInSet:(NSString *)setId success:(void(^)(NSArray *questions))success failure:(void(^)(NSError *error))failure
```
| **Param**                            | **Description**                      |
| -------------------------------------- | -------------------------------------- |
| setId                                | The ID of the question set to load.  |

###### Load all your questions
```
-   (void)getMyQuestions:(void(^)(NSArray *questions))success failure:(void(^)(NSError *error))failure
```
###### Load all questions with tag
```
-   (void)getQuestionsInTag:(NSString *)tagName success:(void(^)(NSDictionary *question))success failure:(void(^)(NSError *error))failure
```
| **Param**                            | **Description**                      |
| -------------------------------------- | -------------------------------------- |
| tagName                              | The name of the tag to load.         |

##### License

Voice-iOS-SDK is available under the MIT license. See the LICENSE file
for more info.