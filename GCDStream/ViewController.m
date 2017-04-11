//
//  ViewController.m
//  GCDStream
//
//  Created by AquaJava on 2017. 04. 07..
//  Copyright © 2017. IDJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *logText;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *receivedBytesLabel;

@end

@implementation ViewController {
    GCDStream* gcdStream;
    long receivedBytes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];

    NSInputStream* ins = [[NSInputStream alloc] initWithFileAtPath:[[NSBundle mainBundle] pathForResource:@"testimage" ofType:@"jpg"]];
    NSOutputStream* os = [[NSOutputStream alloc] initToFileAtPath:[cacheDirectory stringByAppendingPathComponent:@"testimage.jpg"] append:NO];
    
    gcdStream = [GCDStream gcdStreamWithInputStream:ins outputStream:os];
    gcdStream.delegate = self;
    [gcdStream open];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLog:(NSString*)log {
    self.logText.text = [NSString stringWithFormat:@"%@\n%@",self.logText.text,log];
}

- (void)gcdStream:(GCDStream *)gcdstream didOpenStream:(NSStream *)stream {
    [self addLog:@"Stream opened"];
}

- (void)gcdStream:(GCDStream *)gcdstream didReceiveData:(NSData *)data {
    [gcdStream writeData:data];
    
    receivedBytes += data.length;
    self.receivedBytesLabel.text = [NSString stringWithFormat:@"%ld", receivedBytes];
}

- (void)gcdStream:(GCDStream *)gcdstream errorOccured:(NSError *)error withStream:(NSStream *)stream {
    [self addLog:[error localizedDescription]];
}

- (void)gcdStream:(GCDStream *)gcdstream streamEndEncountered:(NSStream *)stream {
    [self addLog:@"Stream closed"];
}

@end
