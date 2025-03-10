
import 'package:flutter/material.dart';
import 'package:gold11/generated/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../res/color_const.dart';
import '../../../res/sizes_const.dart';
import '../../const_widget/container_const.dart';
import '../../const_widget/text_const.dart';
import '../../drawer/drawer_screen.dart';
import '../../widgets/circular_profile_image_widget.dart';

class BottomNavRewardScreen extends StatefulWidget {
  const BottomNavRewardScreen({super.key});

  @override
  State<BottomNavRewardScreen> createState() => _BottomNavRewardScreenState();
}

class _BottomNavRewardScreenState extends State<BottomNavRewardScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedTab=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer:const HomeScreenDrawer(),
      appBar: AppBar(
        leading:  CircularProfileImageWidget(onPressed: (){
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.closeDrawer();
          } else {
            scaffoldKey.currentState!.openDrawer();
          }
        },),
        title: TextConst(text: "Rewards",textColor: AppColor.whiteColor,fontSize: Sizes.fontSizeLarge/1.25,alignment: FractionalOffset.centerLeft,fontWeight: FontWeight.w600,),
        backgroundColor: AppColor.blackColor,
        elevation: 0,
        actions: const [
          Sizes.spaceWidth10
        ],
      ),
      body: ContainerConst(
        image: const DecorationImage(
          image: AssetImage(Assets.assetsRewardNeonBg),
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.high,
          alignment: Alignment.topCenter,
        ),
        child: Column(
          children: [
            Expanded(
              // height: Sizes.screenHeight/8.5,
              // color:AppColor.whiteColor,
              // alignment: Alignment.center,
              // gradient: LinearGradient(colors: [AppColor.blackColor, AppColor.blackColor.withOpacity(0.7),AppColor.blackColor.withOpacity(0.4), AppColor.blackColor.withOpacity(0.2),AppColor.blackColor.withOpacity(0.0)],begin: Alignment.topCenter, end: Alignment.bottomCenter),
              child:
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContainerConst(
                          width: Sizes.screenWidth / 6,
                          height: 1.5,
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade50.withOpacity(0.3),
                            Colors.grey.shade200.withOpacity(0.8),
                          ], begin: Alignment.topLeft, end: FractionalOffset.centerRight),
                          color: Colors.blue),
                      Sizes.spaceWidth5,
                      TextConst(
                        text: AppLocalizations.of(context)!.meetOurWinners.toUpperCase(),
                        textColor: AppColor.textGoldenColor,
                        fontSize: Sizes.fontSizeThree,
                        fontWeight: FontWeight.bold,
                      ),
                      Sizes.spaceWidth5,
                      ContainerConst(
                          width: Sizes.screenWidth / 6,
                          height: 1.5,
                          gradient: LinearGradient(colors: [
                            Colors.grey.shade200.withOpacity(0.8),
                            Colors.grey.shade50.withOpacity(0.3),
                          ], begin: Alignment.centerLeft, end: FractionalOffset.topRight),
                          color: Colors.blue),
                    ],
                  ),
                  Sizes.spaceHeight5,
                  ContainerConst(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Assets.assetsRewardCoin, height: 40,width: 35,fit: BoxFit.fill,),
                        Sizes.spaceWidth5,
                        TextConst(text: "0", textColor: AppColor.whiteColor, fontSize: Sizes.fontSizeLarge,fontWeight: FontWeight.w600,),
                        Sizes.spaceWidth5,
                        ContainerConst(
                            padding: const EdgeInsets.all(1),
                            border: Border.all(width: 0.5, color: AppColor.scaffoldBackgroundColor),
                            shape: BoxShape.circle,
                            child: const Icon(Icons.navigate_next,color: AppColor.whiteColor,))
                      ],
                    ),
                  )
                ],
              ),
            ),
            ContainerConst(
              height: Sizes.screenHeight/1.32,
              color: AppColor.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    optionSwitch(),
                    ContainerConst(
                        height: Sizes.screenHeight/1.54,
                        child: rewardShop())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget optionSwitch(){
    return ContainerConst(
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      color: AppColor.scaffoldBackgroundColor,

      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContainerConst(
            onTap: (){
              setState(() {
                selectedTab=0;
              });
            },
            borderRadius: BorderRadius.circular(8),
            border:selectedTab==0? Border.all(color: AppColor.blackColor.withOpacity(0.2,),width:2):null,
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: Sizes.screenWidth/2.26,
            color:selectedTab==0? AppColor.whiteColor:null,
            child:  TextConst(text: "Reward Shop",fontWeight:selectedTab==0?FontWeight.w600:FontWeight.normal,textColor:selectedTab==0?AppColor.primaryRedColor:AppColor.textGreyColor,),
          ),
          ContainerConst(
            onTap: (){
              setState(() {
                selectedTab=1;
              });
            },
            borderRadius: BorderRadius.circular(8),
            border:selectedTab==1? Border.all(color: AppColor.blackColor.withOpacity(0.2,),width:2):null,
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: Sizes.screenWidth/2.26,
            color:selectedTab==1? AppColor.whiteColor:null,
            child:  TextConst(text: "My Rewards",fontWeight:selectedTab==1?FontWeight.w600:FontWeight.normal,textColor:selectedTab==1?AppColor.primaryRedColor:AppColor.textGreyColor,),
          ),
        ],
      ),
    );
  }

  Widget rewardShop(){
    final List<Category> categories = [
      Category(
        title: 'Tour Passes',
        subTitle:"Exclusive discount on your favourite  tours",
        offers: [
          Offer(title: '50% OFF: World Cup 2024 pass', price: 600, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s"),
          Offer(title: '50% OFF: UAE T10 ICCA pass', price: 450,image: "https://static.vecteezy.com/system/resources/thumbnails/021/688/074/small_2x/sports-football-stadium-blurred-background-ai-generated-image-photo.jpg"),
          Offer(title: '50% OFF: Premier League pass', price: 500, image: "https://www.shutterstock.com/image-photo/blurred-field-lights-full-spectators-260nw-351081242.jpg"),
          Offer(title: '50% OFF: La Liga pass', price: 550,image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRfgHMu1-qLUhLthh7AVylktWcFX9Yg4oAhNy4NANWmXpsK-IvLEU_Syl3ccu2QYqZGjc&usqp=CAU"),
          Offer(title: '50% OFF: Serie A pass', price: 600, image: "https://www.shutterstock.com/image-photo/blurred-field-lights-full-spectators-260nw-351081242.jpg"),
        ],
      ),
      Category(
        title: 'Dream Offers',
        subTitle: "Enjoy the best of Dream11 discount",
        offers: [
          Offer(title: '50% OFF: Discount Pass (₹10 OFF)', price: 200, image: "https://www.shutterstock.com/image-photo/blurred-field-lights-full-spectators-260nw-351081242.jpg"),
          Offer(title: '50% OFF: Discount Pass (₹25 OFF)', price: 500,image: "https://static.vecteezy.com/system/resources/thumbnails/021/688/074/small_2x/sports-football-stadium-blurred-background-ai-generated-image-photo.jpg"),
          Offer(title: '50% OFF: Discount Pass (₹50 OFF)', price: 700,image: "https://www.shutterstock.com/image-photo/blurred-field-lights-full-spectators-260nw-351081242.jpg"),
          Offer(title: '50% OFF: Discount Pass (₹75 OFF)', price: 900, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s"),
          Offer(title: '50% OFF: Discount Pass (₹100 OFF)', price: 1000, image: "https://www.shutterstock.com/image-photo/blurred-field-lights-full-spectators-260nw-351081242.jpg"),
        ],
      ),
      Category(
        title: 'Special Passes',
        subTitle: 'Limited time offers on exclusive events',
        offers: [
          Offer(title: '30% OFF: Champions League pass', price: 800, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '40% OFF: Wimbledon pass', price: 900, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '20% OFF: F1 Grand Prix pass', price: 1000, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '25% OFF: Tour de France pass', price: 1100, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '35% OFF: US Open pass', price: 1200, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
        ],
      ),
      Category(
        title: 'Holiday Deals',
        subTitle: 'Special discounts for holiday trips',
        offers: [
          Offer(title: '50% OFF: Christmas pass', price: 300, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '45% OFF: New Year\'s Eve pass', price: 350, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '60% OFF: Easter pass', price: 400, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '55% OFF: Summer Vacation pass', price: 450, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
          Offer(title: '50% OFF: Winter Vacation pass', price: 500, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvBEu85ap4V1VNeLYg_GRYmoRszNAHPdbCPA&s'),
        ],
      ),
    ];
    return ListView.builder(
      shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (_, int i){
      return categoryWidget(categories[i]);
    });
  }

  Widget categoryWidget(Category category){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerConst(
            border: const Border(
              left: BorderSide(width: 6, color: AppColor.primaryRedColor)
            ),
            child: ListTile(
              leading: const Icon(Icons.discount_outlined),
              title:TextConst(text: category.title, alignment: Alignment.centerLeft,fontWeight: FontWeight.w600,),
              subtitle:TextConst(text: category.subTitle, alignment: Alignment.centerLeft,fontSize: Sizes.fontSizeZero,),
            ),
          ),
          Sizes.spaceHeight10,
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.offers.length,
              itemBuilder: (context, index) {
                return offerWidget( category.offers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget offerWidget(Offer offer){
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ContainerConst(
        width: Sizes.screenWidth/2.5,
        padding: const EdgeInsets.all(16.0),
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(offer.image),
          filterQuality: FilterQuality.low,
          opacity: 0.7,
          fit: BoxFit.fill
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextConst(text: offer.title, alignment: Alignment.centerLeft,textColor: AppColor.whiteColor,),
            Sizes.spaceHeight10,
            ContainerConst(
              borderRadius: BorderRadius.circular(15),
              padding: const EdgeInsets.only(right: 5),
              color: AppColor.whiteColor.withOpacity(0.5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(Assets.assetsStraightCoinReward, height: 22,),
                    TextConst(text: offer.price.toString(), alignment: Alignment.centerLeft,),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
class Category {
  final String title;
  final String subTitle;
  final List<Offer> offers;

  Category( {required this.title,required this.subTitle ,required this.offers});
}

class Offer {
  final String title;
  final String image;
  final int price;

  Offer({required this.title,required this.image,required this.price});
}