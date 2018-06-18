//
//  ViewController.m


#import "ViewController.h"

typedef enum
{
    IDLE = 0,
    SCANNING,
    CONNECTED,
} ConnectionState;

typedef enum
{
    LOGGING,
    RX,
    TX,
} ConsoleDataType;

@interface ViewController ()
@property CBCentralManager *cm;
@property ConnectionState state;
@property UARTPeripheral *currentPeripheral;
@end

@implementation ViewController
@synthesize cm = _cm;
@synthesize currentPeripheral = _currentPeripheral;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.cm = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    [self addTextToConsole:@"Did start application" dataType:LOGGING];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    [self.sendTextField setDelegate:self];
    
    
    dataArray = [[NSArray alloc]initWithObjects:@"15",@"16",@"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",@"25",@"26",@"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34",@"35",@"36",@"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44",@"45",@"46",@"47", @"48", @"49", @"50", @"51", @"52", @"53",@"54",@"55",@"56",@"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64",@"65",@"66",@"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74",@"75",@"76",@"77", @"78", @"79", @"80", @"81", @"82", @"83",@"84",@"85",@"86",@"87", @"88", @"89", @"90", @"91", @"92", @"93", @"94",@"95",@"96",@"97", @"98", @"99", @"100", @"101", @"102", @"103", @"104",@"105",@"106",@"107", @"108", @"109", @"110", @"111", @"112", @"113", @"114",@"115",@"116",@"117", @"118", @"119", @"120", @"121", @"122", @"123", @"124",@"125",@"126",@"127", @"128", @"129", @"130", @"131", @"132", @"133", @"134",@"135",@"136",@"137", @"138", @"139", @"140", @"141", @"142", @"143", @"144",@"145",@"146",@"147", @"148", @"149", @"150", @"151", @"152", @"153", @"154",@"155",@"156",@"157", @"158", @"159", @"160", @"161", @"162", @"163", @"164",@"165",@"166",@"167", @"168", @"169", @"170", @"171", @"172", @"173", @"174",@"175",@"176",@"177", @"178", @"179", @"180", @"181", @"182", @"183", @"184",@"185",@"186",@"187", @"188", @"189", @"190", @"191", @"192", @"193", @"194",@"195",@"196",@"197", @"198", @"199", @"200", nil];
    
    
    
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 100, 300, 216)];
    
    //disable for custom position
    [self.view addSubview:picker];
    picker.frame = CGRectMake(0, 100, 300, 216);
    
    
    picker.dataSource = self;
    picker.delegate = self;
    [picker setShowsSelectionIndicator:YES];
    [self.pickerTextField setInputView:picker];
    
    
    
    
    
    picker.backgroundColor = [ UIColor colorWithRed:0.161 green:0.161 blue:0.161 alpha:1];
    self.view.backgroundColor =[ UIColor colorWithRed:0.161 green:0.161 blue:0.161 alpha:1];
    
    //default position
    [picker selectRow:99 inComponent:1 animated:YES];
    
    //NSString *userPace = [NSString stringWithFormat:@"%@%@\n",[dataArray objectAtIndex:[picker selectedRowInComponent:0]], [dataArray objectAtIndex:[picker selectedRowInComponent:1]] ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectButtonPressed:(id)sender
{
    [self.sendTextField resignFirstResponder];
    
    switch (self.state) {
        case IDLE:
            self.state = SCANNING;
            
            NSLog(@"Started scan ...");
            [self.connectButton setTitle:@"Scanning ..." forState:UIControlStateNormal];
            
            [self.cm scanForPeripheralsWithServices:@[UARTPeripheral.uartServiceUUID] options:@{CBCentralManagerScanOptionAllowDuplicatesKey: [NSNumber numberWithBool:NO]}];
            break;
            
        case SCANNING:
            self.state = IDLE;

            NSLog(@"Stopped scan");
            [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];

            [self.cm stopScan];
            break;
            
        case CONNECTED:
            NSLog(@"Disconnect peripheral %@", self.currentPeripheral.peripheral.name);
            [self.cm cancelPeripheralConnection:self.currentPeripheral.peripheral];
            break;
    }
}

- (IBAction)sendTextFieldEditingDidBegin:(id)sender {
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    [self.tableView setContentOffset:CGPointMake(0, 220) animated:YES];
}

- (IBAction)sendTextFieldEditingChanged:(id)sender {
    if (self.sendTextField.text.length > 20)
    {
        [self.sendTextField setBackgroundColor:[UIColor redColor]];
    }
    else
    {
        [self.sendTextField setBackgroundColor:[UIColor whiteColor]];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self sendButtonPressed:textField];
    return YES;
}
-(IBAction)debug:(id)sender{
    NSLog(@" The following string will be send%@look this is on a new line!",userPace );

}
- (IBAction)sendButtonPressed:(id)sender {
    [self.sendTextField resignFirstResponder];
    
    if (self.sendTextField.text.length == 0)
    {
        return;
    }
    
    
    //add a newline character to the numbers bieng sent across
    
   // NSString *sendTextFieldString;
    //sendTextFieldString = self.sendTextField.text;
    //self.sendTextField = [NSString stringWithFormat:@"%@\n",sendTextFieldString];
    
    //NSString *newLine =[[[NSString alloc] initWithString:"\n"];
    
    self.sendTextField.text = [self.sendTextField.text stringByAppendingString:@"\n"];
    
    
   // NSData *data = [self.sendTextField.text dataUsingEncoding:NSUTF8StringEncoding];
    
    [self addTextToConsole:self.sendTextField.text dataType:TX];
    //NSString *newLine2 =@"1000";
    NSString *newLine2 =@"1000\n";
    
    
    [self.currentPeripheral writeString:userPace];
    NSLog(@"%@", userPace);
}

#pragma mark - UIpickerView DataSource Method
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  [dataArray count];
}

#pragma mark - UIPickerView Delegate Method

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //array number becomes picker label
    return [dataArray objectAtIndex:row];
    
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    /*self.pickerTextField.text = [NSString stringWithFormat:@"%@%@",[dataArray objectAtIndex:[pickerView selectedRowInComponent:0]], [dataArray objectAtIndex:[pickerView selectedRowInComponent:1]] ];
     //self.pickerTextField.text = [dataArray objectAtIndex:row];*/
    
  /*
    self.pickerTextField.text = [NSString stringWithFormat:@"%@%@",[dataArray objectAtIndex:[pickerView selectedRowInComponent:0]], [dataArray objectAtIndex:[pickerView selectedRowInComponent:1]] ];
    */
    
   // NSString *userPace = [NSString stringWithFormat:@"%@%@\n",[dataArray objectAtIndex:[pickerView selectedRowInComponent:0]], [dataArray objectAtIndex:[pickerView selectedRowInComponent:1]] ];
    
    UILabel *label;
    [label setTextColor:[UIColor redColor]];
    
    
    
    
    [pickerView reloadComponent:component]; //refresh pickerView
    
    
}


//User interface options for wheel

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    
    
    UILabel *label = (UILabel*) view;
    if (label == nil)
    {
        label = [[UILabel alloc] init];
    }
    
    label.text = [NSString stringWithFormat:@" %ld", 15+row];
    
    // picker LABEL options
    
    [label setTextColor:[UIColor colorWithRed:0.996 green:0.996 blue:0.996 alpha:1]];
    //[label setBackgroundColor:[UIColor colorWithRed:.1 green:52.0/255 blue:52.0/255 alpha:1]];
    
    CGSize rowSize = [pickerView rowSizeForComponent:component];
    CGRect labelRect = CGRectMake (0, 0, rowSize.width, rowSize.height);
    [label setFrame:labelRect];
    label.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    
    if([pickerView selectedRowInComponent:component] == row)
    {
        
        label.textColor = [UIColor colorWithRed:0.91 green:0.271 blue:0.267 alpha:1]; // red highlight
        [label setFont:[UIFont fontWithName:@"Malayalam Sangam MN" size:28.0]];
        //[pickerView reloadComponent:component];
        //[label setTextColor:[UIColor greenColor]];
        //[label setTextColor:[UIColor redColor]];
        
        //[label setBackgroundColor:[UIColor darkGrayColor]];
      
      
        
       userPace =  [NSString stringWithFormat:@"%@%@\n",[dataArray objectAtIndex:[pickerView selectedRowInComponent:0]], [dataArray objectAtIndex:[pickerView selectedRowInComponent:1]] ];
        //userPace = label.text;
        NSLog(@"%@", userPace);
        
    }
    else{
        
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont fontWithName:@"Malayalam Sangam MN" size:14.0]];
        //[pickerView reloadComponent:component];
        // label.backgroundColor = [UIColor colorWithRed:0.204 green:0.204 blue:0.204 alpha:1];
        
        
        
    }
    
    
    
    return label;
}


- (void) didReadHardwareRevisionString:(NSString *)string
{
    [self addTextToConsole:[NSString stringWithFormat:@"Hardware revision: %@", string] dataType:LOGGING];
}

- (void) didReceiveData:(NSString *)string
{
    [self addTextToConsole:string dataType:RX];
}

- (void) addTextToConsole:(NSString *) string dataType:(ConsoleDataType) dataType
{
    NSString *direction;
    switch (dataType)
    {
        case RX:
            direction = @"RX";
            break;
            
        case TX:
            direction = @"TX";
            break;
            
        case LOGGING:
            direction = @"Log";
    }
    
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss.SSS"];
    
    self.consoleTextView.text = [self.consoleTextView.text stringByAppendingFormat:@"[%@] %@: %@\n",[formatter stringFromDate:[NSDate date]], direction, string];
    
    [self.consoleTextView setScrollEnabled:NO];
    NSRange bottom = NSMakeRange(self.consoleTextView.text.length-1, self.consoleTextView.text.length);
    [self.consoleTextView scrollRangeToVisible:bottom];
    [self.consoleTextView setScrollEnabled:YES];
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn)
    {
        [self.connectButton setEnabled:YES];
    }
    
}

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Did discover peripheral %@", peripheral.name);
    [self.cm stopScan];
    
    self.currentPeripheral = [[UARTPeripheral alloc] initWithPeripheral:peripheral delegate:self];
    
    [self.cm connectPeripheral:peripheral options:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey: [NSNumber numberWithBool:YES]}];
}

- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Did connect peripheral %@", peripheral.name);

    [self addTextToConsole:[NSString stringWithFormat:@"Did connect to %@", peripheral.name] dataType:LOGGING];
    
    self.state = CONNECTED;
    [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
    [self.sendButton setUserInteractionEnabled:YES];
    [self.sendTextField setUserInteractionEnabled:YES];
    
    if ([self.currentPeripheral.peripheral isEqual:peripheral])
    {
        [self.currentPeripheral didConnect];
    }
}

- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"Did disconnect peripheral %@", peripheral.name);
    
    [self addTextToConsole:[NSString stringWithFormat:@"Did disconnect from %@, error code %d", peripheral.name, error.code] dataType:LOGGING];
    
    self.state = IDLE;
    [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    [self.sendButton setUserInteractionEnabled:NO];
    [self.sendTextField setUserInteractionEnabled:NO];
    
    if ([self.currentPeripheral.peripheral isEqual:peripheral])
    {
        [self.currentPeripheral didDisconnect];
    }
}
@end
