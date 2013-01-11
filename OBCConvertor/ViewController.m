//
//  ViewController.m
//  OBCConvertor
//
//  Created by so898 on 13-1-11.
//  Copyright (c) 2013年 R3 Studio. All rights reserved.
//

#import "ViewController.h"
#import "OBCConvertor.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *abc = @"小说是文学的一种样式，一般描写人物故事，塑造多种多样的人物形象，但亦有例外。\n它是拥有完整布局、发展及主题的文学作品。\n而对话是不是具有鲜明的个性，每个人物说的话是不是有独特的语言风格，是衡量小说水平的一个重要标准。\n与其他文学样式相比，小说的容量较大，它可以细致的展现人物性格和人物命运，可以表现错综复杂的矛盾冲突，同时还可以描述人物所处的社会生活环境。\n“小说”一词，最早见于《庄子·外物》：“饰小说以干县令，其于大达亦远矣。”这里所说的小说，是指琐碎的言谈、小的道理，与现时所说的小说相差甚远。文学中，小说通常指长篇小说、中篇、短篇小说和诗的形式。\n英文“Novel”是指篇幅较长的小说（参见长篇小说），而“Fiction”是指虚构的故事作品（不限于文字）。中文的“小说”严格来说没有单一合适的英语单字可以对应，但是大多会将Novel译为小说。";
        
        self.view.frame = CGRectMake(0, 0, 320, 480);
        
        mainText = [UITextView new];
        mainText.frame = CGRectMake(0, 0, 320, 300);
        mainText.editable = YES;
        mainText.text = abc;
        mainText.delegate = self;
        [self.view addSubview:mainText];
        
        UIButton *st = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        st.frame = CGRectMake(30, 330, 100, 30);
        [st setTitle:@"简体转繁体" forState:UIControlStateNormal];
        [st addTarget:self action:@selector(sTot) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:st];
        
        UIButton *ts = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        ts.frame = CGRectMake(190, 330, 100, 30);
        [ts setTitle:@"繁体转简体" forState:UIControlStateNormal];
        [ts addTarget:self action:@selector(tTos) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:ts];
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [mainText resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)sTot
{
    mainText.text = [[OBCConvertor getInstance] s2t:mainText.text];
}

- (void)tTos
{
    mainText.text = [[OBCConvertor getInstance] t2s:mainText.text];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
