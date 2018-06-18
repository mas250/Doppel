//
//  ViewController.h
//  nRF UART


#import <UIKit/UIKit.h>

#import "UARTPeripheral.h"

@interface ViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CBCentralManagerDelegate, UARTPeripheralDelegate> {
    
    UIPickerView *ddlStatus;
    NSArray *dataArray;
    NSString *userPace ;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UITextView *consoleTextView;
@property (weak, nonatomic) IBOutlet UITextField *sendTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (nonatomic, strong) IBOutlet UIPickerView *ddlStatus;



@property (weak, nonatomic) IBOutlet UITextField *pickerTextField;


- (IBAction)connectButtonPressed:(id)sender;
- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)sendTextFieldEditingDidBegin:(id)sender;
- (IBAction)sendTextFieldEditingChanged:(id)sender;
@end
