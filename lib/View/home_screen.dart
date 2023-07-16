import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/book_card.dart';
import 'package:khatabook/Utils/Components/homepage_floating.dart';
import 'package:khatabook/Utils/constant.dart';
import 'package:khatabook/view_model/home_screen_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomePageProvider>(context, listen: false).fetchCustomerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Cash Flow"),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          )
        ],
      ),
      drawer: const Drawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hello User",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Consumer<HomePageProvider>(builder: (context, value, child) {
                  return Text(
                    "₹ ${value.getIncome - value.getExpense}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  );
                })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: redColor,
                  gradient: LinearGradient(
                      stops: const [0.5, 0.5],
                      colors: [Colors.green.shade800, redColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      tileMode: TileMode.clamp),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Income",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Consumer<HomePageProvider>(
                          builder: (context, value, child) {
                        return Text(
                          "₹ ${value.getIncome}",
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        );
                      })
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Your Expense",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      Consumer<HomePageProvider>(
                          builder: (context, value, child) {
                        return Text(
                          "₹ ${value.getExpense}",
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        );
                      })
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Books",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 1,
                child: Consumer<HomePageProvider>(
                    builder: (context, value, child) {
                  return value.getLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: value.getCustomerList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return BookCard(
                           
                              bookModel: value.getCustomerList[index],
                            );
                          },
                        );
                })),
          ],
        ),
      ),
      floatingActionButton: const HomePageFlotingButton(),
    ));
  }
}
