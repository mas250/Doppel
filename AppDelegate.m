//
//  AppDelegate.m
//  nRF UART


#import "AppDelegate.h"

@implementation AppDelegate
- (UIStoryboard *)grabStoryboard {
    
    UIStoryboard *storyboard;
    
    // detect the which hardware the app is running on
    int height = [UIScreen mainScreen].bounds.size.height;
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
    
#define   IsIphone6     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
    
#define   IsIphone6plus     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
    
    
    //load the appropriate storyboard for said device - default is iPhone 4
    if(IsIphone5)
    {
        NSLog(@"iphone5");
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard5s" bundle:nil];
    }
    
    if(IsIphone6)
    {
        NSLog(@"iphone6");
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard6" bundle:nil];
    }
    
    if(IsIphone6plus)
    {
        NSLog(@"iphone6 Plus");
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard6+" bundle:nil];
    }
    
    
    return storyboard;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UIStoryboard *storyboard = [self grabStoryboard];
    if (IsIphone5) {
        self.window.rootViewController = [storyboard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
    }
    
    
    if (IsIphone6) {
        self.window.rootViewController = [storyboard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
        
    }
    
    if (IsIphone6plus){
        self.window.rootViewController = [storyboard instantiateInitialViewController];
        [self.window makeKeyAndVisible];
    }
    //return YES;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
