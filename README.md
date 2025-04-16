Tech Stack: UIKit, Snapkit, StoreKit 2, Combine, SPM

The entry point to the app is the SceneDelegate, as mentioned before, avoiding the use of Storyboard.

As I noticed, all the onboarding "screens" contain similar chunks of data, so I decided to use a single scene and manage it with a UITableView.

All functionality for the quiz can be found in the QuizScreen folder and QuizViewModel.

QuizViewModel:
The data for the quiz is controlled by the enum OnboardingStage. Whenever the case changes, quizItem.value changes, and Combine is used to observe the data change on the table view.

Note: Errors are printed not because this is my usual error handling practice, but to save time during development. Since this task is relatively large, I concentrated on implementing the key functionality.

StoreManager:
All subscriptions are implemented using StoreKit 2, and the implementation has been tested only with Xcode. All specifications can be checked in the store config file. The process starts with the loadProducts() method, and then I create a separate task for observing all transaction statuses. The purchase() method is used for buying a subscription.

Note: I noticed the label indicates a trial, but I couldn't find any documentation on implementing introductory offers without connecting to an App Store account.
