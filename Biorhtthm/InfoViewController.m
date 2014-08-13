//
//  InfoViewController.m
//  Biorhtthm
//
//  Created by Jianhai Yu on 14/7/30.
//  Copyright (c) 2014年 JianhaiYu. All rights reserved.
//

#import "InfoViewController.h"
#import "PDFView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于生物节律";
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(backToRootView:)];
    self.navigationItem.leftBarButtonItem = leftBBI;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(10, 15, 60, 30);
    [button setTitle:@"<<关于" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backToRootView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
//    CGRect frame = CGRectMake(0, 45, 320, 523);
//    PDFView *pdfView = [[PDFView alloc]initWithFrame:frame];
//    pdfView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:pdfView];
    
    
    // 文本视图
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(10, 65, 300, 500);
//    textView.backgroundColor = [UIColor redColor];
    textView.text = @"      在日常生活中，几乎每个人都有这么一种感觉：有时体力充沛，情绪饱满，精神焕发；而有时却又感到浑身疲乏，情绪低落，精神萎靡。迥然不同的两种情况是怎么在同一个人身上发生的呢？科学家们经过长期研究表明：对人的自我感觉影响最大的三个因素是——体力、情绪和智力，而且体力、情绪和智力的变化是有规律的，一个人从出生之日起，到离开世界为止，这个规律自始至终不会有丝毫变化，不受任何后天影响，这个规律就是人的“生物节律”，又称为的“生物三节律”，即：“体力节律、情绪节律、智力节律”。                        时期划分 20世纪初，英国医生费里斯和德国心理学家斯沃博特发现一个奇怪的现象：有一些病人因头痛、精神疲倦等，每隔固定的天数就来就诊一次，后来他们总结出：人的体力状况变化是以23天为周期的，人的情绪状况变化是以28天为周期的，20多年后，特里舍尔又根据总结自己学生的智力变化情况，总结出：人的智力状况变化是以33天为周期的；后来科学家们又发现：人的“体力状况、情绪状况、智力状况”按正弦曲线规律变化，人的“生物三节律”中，可分为“高潮期”、“低潮期”、“临界点”、“临界期”。各阶段现象 人处于正半周期为节律的高潮期，高潮期内人的心情舒畅，精力充沛，工作效率高； 人处于负半周期为节律的低潮期，低潮期内人的心情不佳，容易疲劳、健忘，工作效率低； 正弦曲线与横轴交点这一天称为“临界点”，三节律的3个临界点互不重叠称为单临界点；2个临界点重叠称“双临界点”；3个临界点重叠称“三临界点”； 临界点及前后一天为临界期，三节律同时在负半周期重叠的日子，也称为“临界期”；在临界点及临界期内，人的体力、情绪和智力极不稳定，做事非常容易出现失误。利用节律 背景资料 1946年，瑞典商人乔治.汤姆听说他的一位朋友汉斯.弗若恩在一次火车相撞事故发生之后，计算了出事的两列火车上的司机和司炉的生物节律，出乎意外地发现其中三人生物节律处在“临界期”，另一人生物节律则处于“低潮期”。一年以后，另一起几乎类似的事发生了。乔治这次计算了事故中的司机和司炉的生物节律。他十分惊讶地发现：一个司机的两个生物节律周期正处于“低潮期”，另一个司机和一名司炉则处于“临界期”，第四位司炉的三个生物周期全部处于“低潮期”。乔治想起了汉斯的计算结果，看来两次事故中责任人的生物节律结果与事故发生的关系并非巧合。于是，乔治开始弃商从学，开始了生物节奏方面的深入的研究。后来，他的研究颇有成就，还出版了一部研究性著作——《这是你的日子吗？》 利用方法 如何利用‘你的日子’呢?其实,人的心理状态是十分重要的。就拿来体力、情绪和智力的变化来说吧，处于高潮期的时候，就应充分利用自己良好的“竟技”状态，努力学习，勤奋工作，多作贡献。这时如果盲目乐观，也会给工作和学习带来影响。例如有的汽车司机就是因为麻痹大意，而在高潮期发生车祸的。 同样，体力、情绪和智力处于低潮期和临界期的人，不必过分紧张。因为紧张的心理状态，会影响人的体力和大脑的机能，使工作和学习效率进一步下降。在这一时期，适当注意休息、锻炼和营养，注意用脑的卫生，如变换大脑活动的方式，轮流学习不同的内容，使大脑的各个区域交替活动、劳逸结合，就可以使大脑仍然有条不紊地工作，有利于提高工作和学习的效率。 “事在人为”。掌握人体生物节奏的规律，是为了扬长避短，使人们更好地工作、生活和学习。忧心忡忡是不必要的，盲目乐观也是十分有害的。注意事项从事危险作业人员在生物节律低潮期时应引起注意；双重临界日更应高度注意；三重临界日应尽可能避免从事相关危险作业；以防止事故发生。 从事脑力工作或学习的人员，应合理安排作息时间，在体力高潮期尽可能多的参加锻炼活动，而在智力和情绪高潮期应抓紧从事用脑活动、这样会获得事半功倍的效果，工作或学习效率会非常高。 从事体育训练也应根据运动员的体力、情绪、智力节律情况，合理安排训练项目，在高潮期应多参加训练，而在临界日及低潮期应注意进行调整，能避免运动上海事故并能收到良好好的训练效果；人们选择体力高潮期进行体育锻练可达到好的锻练效果。 如果夫妇要生育计划时，应查看参考夫妻双方的生物节律指标，尽可能选择双方四条以上生物节律高潮期的时间段内受孕，对于将来出生的小宝宝的聪明健康有很大好处；对孩子的教育，父母也应参考孩子的情绪和智力节律的高潮期对孩子进行合理的教育。 大家应该参考各自的生物节律指标，应避免在情绪临界日发生争吵；破坏家庭和睦。 如有病人需要进行手术治疗，应尽可能避免在体力、情绪临界日进行，危重病人在体力及情绪临界日应多加关照和护理，防止意外发生；老人、儿童、体弱者在体力低潮期或临界日应注意天气变化，预防疾病的感染。 伪科学 对于生物节律是否真的存在，它对我们的生活和人生是否有实在的意义，科学上有所争论。《与众不同的心理学》一书，明确表示生物节律是伪科学。网上也有人对生物节律的三节律进行分析，与实际情况并不相符合。 或许我们可以这样考虑，一件事情的影响因素可能有非常多，生物节律或许对事件也会产生一些影响，但是并不能根本决定事情和未来的走向。只是作为一个参考一件，不要太纠结于此。上面的各行业注意事项，听听就可以，不用太在意。 尊重节律 我国许多地方规定：连续驾车超过4小时的驾驶人必须停车休息20分钟以上。笔者认为，此举会大大减少我国的恶性交通事故。 　知名安全专家胡正祥教授为写《生物节律与行车安全》一书做了大量调查，他发现疲劳驾驶是交通事故的主要原因之一，除意外事故外，大车祸都发生在开车人的生物节律临界期和低潮期，即疲惫不堪时。 　生物节律，就是我们常说的“人体生物钟”。研究证实，每个人从他出生之日直至生命终结，体内都存在着多种自然节律，如体力、智力、情绪、血压、经期等，人们将这些自然节律称作生物节律或生命节奏等。人体内存在一种决定人们睡眠和觉醒的生物钟，生物钟根据大脑的指令，调节全身各种器官以24小时为周期发挥作用。现已发现12个与生物钟相关的基因。生物钟使人有高潮期和低潮期，两者之间为临界期。高潮期时，人的思维敏捷、情绪高涨、体力充沛，可以充分发挥自己的潜能；低潮期，思维迟钝，情绪低落，耐力下降；临界期时，人的判断力较差，易出差错。日本发现，82%车祸都发生在司机生物节律的临界期。交通事故与肇事者的生物节律密切有关。当人体生物节律处于临界期或低潮期时，人会感到体力不济，精神恍惚，对高速运行的车辆和复杂的路况做出错误判断和错误动作，这是导致交通事故的重要原因之一。无论开车人起步时多么精力充沛，在连续驾车超过4小时后都可能出现疲劳，使人处于生物节律的临界期或低潮期。这时一定要停车休息，人处“低潮”要慎行车，能不开就不开。从这个角度看，尊重我们的生物节律就是爱护我们的生命。　为了避免和减少车祸的发生，要运用生物节律的理论对开车人实行生物钟管理，如“驾车超过4小时必须休息”等做法，对疲劳驾驶，欧美国家早就有严格规定，如欧洲国家就规定，不准连续驾车超过4小时，一天总驾车时间不能超过8小时，驾驶人是否停车和停了多长时间都由车内的“黑匣子”记录在案，供警察检查，违反规定者会受到重罚。 　此举对预防交通事故取得了显著成效。开车人也要自律，如果开车时出现思想不能集中或者不连贯、反复打哈欠、眼睛睁开有困难、忽视交通信号、经常偏离车道等，就不要再勉强驾驶了，应停车休息。每一个人的生物钟不尽相同，平时要摸索自己的生物钟，合理安排驾驶时间。我们一定要尊重大自然为我们身体制定的规律，否则就会受到惩罚。";
    textView.font = [UIFont boldSystemFontOfSize:17];
    // 设置不可编辑
    textView.editable = NO;
    [self.view addSubview:textView];
}

- (void)backToRootView:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)drawRect:(CGRect)rect {
//    
//    CGContextRef cgctx=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(cgctx, 1.00f);
//    CGContextSetStrokeColorWithColor(cgctx, [UIColor redColor].CGColor);
//    float x=0.0;
//    float y=240.0;
//    CGContextMoveToPoint(cgctx, x, y);
//    for(float x=0;x<320;x++){
//        y=sin(x/180*3.14)*100+240.0;
//        CGContextAddLineToPoint(cgctx,x,y);
//        CGContextStrokePath(cgctx);
//        CGContextMoveToPoint(cgctx,x, y);
//    }
//    
//    CGContextRef cgcty=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(cgcty, 1.00f);
//    CGContextSetStrokeColorWithColor(cgcty, [UIColor blackColor].CGColor);
//    float xy=0.0;
//    float yy=260.0;
//    CGContextMoveToPoint(cgcty, xy, yy);
//    for(float xy=0;xy<320;xy++){
//        yy=sin(xy/180*3.14)*100+260.0;
//        CGContextAddLineToPoint(cgcty,xy,yy);
//        CGContextStrokePath(cgcty);
//        CGContextMoveToPoint(cgcty,xy, yy);
//    }
//    
//    CGContextRef cgctyz=UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(cgctyz, 1.00f);
//    CGContextSetStrokeColorWithColor(cgctyz, [UIColor yellowColor].CGColor);
//    float xyz=0.0;
//    float yyz=280.0;
//    CGContextMoveToPoint(cgctyz, xyz, yyz);
//    for(float xyz=0;xyz<320;xyz++){
//        yyz=sin(xyz/180*3.14)*100+280.0;
//        CGContextAddLineToPoint(cgctyz,xyz,yyz);
//        CGContextStrokePath(cgctyz);
//        CGContextMoveToPoint(cgctyz,xyz, yyz);
//    }
//}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
