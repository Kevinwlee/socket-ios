//
//  ViewController.m
//  socketio
//
//  Created by Kevin Lee on 2/11/15.
//  Copyright (c) 2015 ChaiONE. All rights reserved.
//

#import "ViewController.h"
#import <SIOSocket/SIOSocket.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *statLabel;
@property (nonatomic, strong) SIOSocket *socket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [SIOSocket socketWithHost: @"http://localhost:3000" response: ^(SIOSocket *socket) {
        self.socket = socket;
        [self.socket on:@"counter" callback:^(NSArray *args) {
            NSString *countString = [args[0] stringValue];
            self.statLabel.text = countString;
        }];
    }];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:3000/stats"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"web view did finish load");
}

@end
