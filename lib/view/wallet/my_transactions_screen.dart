import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gold11/utils/utils.dart';
import 'package:gold11/view/const_widget/container_const.dart';
import 'package:gold11/view_model/wallet_view_model.dart';
import '../../model/user_transaction_model.dart';
import '../../res/color_const.dart';
import '../../res/sizes_const.dart';
import '../const_widget/text_const.dart';

class MyTransactionsScreen extends StatefulWidget {
  const MyTransactionsScreen({super.key});

  @override
  State<MyTransactionsScreen> createState() => _MyTransactionsScreenState();
}

class _MyTransactionsScreenState extends State<MyTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WalletViewModel>(builder: (context, walletProvider, child) {
      switch (walletProvider.walletState){
        case WalletState.idle:
          return const Scaffold(
            body: Center(child: TextConst(text: "Something went wrong",)),
          );
        case WalletState.loading:
         return  const Scaffold(
           body: Center(child: CircularProgressIndicator(color: AppColor.primaryRedColor,)),
         );
        case WalletState.success:
          return transactionDataUI(walletProvider);
        case WalletState.error:
         return  const Scaffold(
           body: Center(child: TextConst(text: "Something went wrong",)),
         );
      }
    });
  }

  Widget transactionDataUI(WalletViewModel walletProvider) {
    final transactionType = walletProvider.transactionType?.data ?? [];
    if (transactionType.isEmpty) {
      return const Scaffold(
        body: Center(child: TextConst(text: "No transaction types available")),
      );
    }

    return DefaultTabController(
      initialIndex: 0,
      length: transactionType.length,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          title: TextConst(
            text: "My Transactions",
            textColor: AppColor.whiteColor,
            fontSize: Sizes.fontSizeLarge / 1.25,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download, color: AppColor.whiteColor),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.question_mark_rounded, color: AppColor.whiteColor),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ColoredBox(
              color: Colors.white,
              child: TabBar(
                tabs: transactionType.map((type) => Tab(text: type.name)).toList(),
                isScrollable: true,
                labelColor: AppColor.primaryRedColor,
                tabAlignment: TabAlignment.start,
                indicatorColor: Colors.blueAccent,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: transactionType.map((type) {
            final userTransactions = walletProvider.userTransactions?.data
                ?.where((e) => e.type == type.id)
                .toList() ?? [];
            return userTransactions.isNotEmpty
                ? contestListing(userTransactions)
                : const Center(child: TextConst(text: "No data available"));
          }).toList(),
        ),
      ),
    );
  }

  Widget contestListing(List<UserTransactionList> userTransaction) {
    return ListView.builder(
      itemCount: userTransaction.length,
      itemBuilder: (_, int i) {
        final transaction= userTransaction[i];
        return ContainerConst(
          color: AppColor.whiteColor,
          border: Border(
              bottom: BorderSide(
                  color: AppColor.scaffoldBackgroundColor, width: 1)),
          child: ListTile(
            title: TextConst(
              text: transaction.transactionSubtype.toString(),
              alignment: Alignment.centerLeft,
              width: Sizes.screenWidth / 2,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle:transaction.type==2? TextConst(
              text: "${transaction.createdAt??""} | ${transaction.matchName}",
              alignment: Alignment.centerLeft,
              fontSize: Sizes.fontSizeOne,
              textColor: AppColor.textGreyColor,
            ):TextConst(
              text: "${transaction.createdAt??""}",
              alignment: Alignment.centerLeft,
              fontSize: Sizes.fontSizeOne,
              textColor: AppColor.textGreyColor,
            ),
            trailing: TextConst(
              text:"${transaction.symbols}${Utils.rupeeSymbol}${transaction.amount}",
              alignment: Alignment.centerRight,
              width: 100,
              textColor:transaction.symbols=="+"
                  ? AppColor.activeButtonGreenColor
                  : AppColor.blackColor,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        );
      },
    );
  }
}
