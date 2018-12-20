//
//  ViewController.m
//  LTSignDemo
//
//  Created by Luther on 2018/12/20.
//  Copyright © 2018 mrstock. All rights reserved.
//

#import "ViewController.h"
#import "LTSignView.h"

@interface ViewController ()
@property (nonatomic, strong) LTSignView *signView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    LTSignView *signView = [[LTSignView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    signView.lineWidth = 5;
    signView.lineColor = [UIColor redColor];
    self.signView = signView;
    [self.view addSubview:signView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 300)];
    [self.view addSubview:self.imageView];
    
}
- (IBAction)clearClick:(id)sender {
    [self.signView clear];
}

- (IBAction)sureClick:(id)sender {
    [self.signView saveTheSignatureImage:^(UIImage *image) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        NSLog(@"------------%.1lu KB", data.length / 1024);
        self.imageView.image = image;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
