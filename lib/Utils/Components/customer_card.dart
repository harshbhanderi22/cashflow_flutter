import 'package:flutter/material.dart';
import 'package:khatabook/Utils/Components/common_text.dart';
import 'package:khatabook/Utils/general_utils.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, blurRadius: 5, offset: Offset(5, 2))
          ],
          color: Colors.grey.shade200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonText(
                    text: "Harsh Bhanderi",
                    fontsize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const CommonText(
                    text: "Customer",
                    fontsize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assests/images/location.png",
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const CommonText(
                        text: "Surat",
                        fontsize: 12,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CommonText(
                  text: "50000",
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontsize: 18,
                )
              ],
            ),
          ),
          PopupMenuButton(
              position: PopupMenuPosition.under,
              child: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      GeneralUtils.showToast("First");
                    },
                    child: const Text("First"),
                  ),
                  const PopupMenuItem(
                    child: Text("Second"),
                  ),
                  const PopupMenuItem(
                    child: Text("Third"),
                  ),
                ];
              })
        ],
      ),
    );
  }
}
