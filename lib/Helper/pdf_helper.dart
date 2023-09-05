
import 'package:flutter/services.dart';
import 'package:khatabook/Models/book_model.dart';
import 'package:khatabook/Models/transaction_model.dart';
import 'package:khatabook/Models/user_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfHelper {
  //GetUserData
  //GetTransactionList
  void generateTransactionPdf(List<TransactionModel> transactionList,
      UserModel userModel, BookModel bookModel, String company) async {
    final pdf = Document();
    final ByteData image = await rootBundle.load('assests/images/user3.png');

    Uint8List imageData = (image).buffer.asUint8List();

    // final font = await rootBundle.load("assests/fonts/Poppins/open-sans.ttf");
    // final ttf = Font.ttf(font);

    double total = 0;
    double cost = 0;
    double net = 0;

    List<TableRow> transactions = [
      TableRow(children: [
        Text("SR No.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Title",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Category",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Date",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Time",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Total",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Cost",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("Net",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    ];
    for (int i = 0; i < transactionList.length; i++) {
      total += transactionList[i].total;
      cost += transactionList[i].cost;
      transactions.add(
        TableRow(children: [
          Text((i + 1).toString(),
              style: const TextStyle(fontSize: 16)),
          Text(transactionList[i].title,
              style: const TextStyle(fontSize: 16)),
          Text(transactionList[i].category,
              style: const TextStyle(fontSize: 16)),
          Text(transactionList[i].date,
              style: const TextStyle(fontSize: 16)),
          Text(transactionList[i].time,
              style: const TextStyle(fontSize: 16)),
          Text(transactionList[i].total.toString(),
              style: const TextStyle(fontSize: 16)),
          Text(transactionList[i].cost.toString(),
              style: const TextStyle(fontSize: 16)),
          Text((transactionList[i].total - transactionList[i].cost).toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ]),
      );
    }

    transactions.add(
      TableRow(children: [
        Text("", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text("", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(total.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(cost.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text((total - cost).toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    );

    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        margin: const EdgeInsets.all(20),
        header: (context) {
          return Column(children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 80,
                      width: 80,
                      child: Image(pw.MemoryImage(imageData))),
                  Column(children: [
                    Text((company == "" ? userModel.name : company) ?? "Cash Flow",
                        style: TextStyle(
                          fontSize: 34,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 5),
                    Text(userModel.email ?? "user@cashflow.com",
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                    SizedBox(height: 5),
                    Text("Your Own Finance Tracking Application",
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                  ]),
                  Container(
                      height: 80,
                      width: 80,
                      child: Image(pw.MemoryImage(imageData))),
                ]),
            Divider(thickness: 2, color: PdfColor.fromHex("#000000")),
          ]);
        },
        build: (pw.Context context) {
          return [
            SizedBox(height: 20),
            Text("Book(Khata) Details:-",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Table(children: [
              TableRow(children: [
                Text("Book's Name:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(bookModel.name, style: const TextStyle(fontSize: 16))
              ]),
              TableRow(children: [
                Text("Book's Type:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(bookModel.type, style: const TextStyle(fontSize: 16))
              ]),
              TableRow(children: [
                Text("Book's Address:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(bookModel.address, style: const TextStyle(fontSize: 16))
              ]),
              TableRow(children: [
                Text("Book's Contact:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(bookModel.mobile, style: const TextStyle(fontSize: 16))
              ]),
              TableRow(children: [
                Text("Book's Total:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(bookModel.total.toString(), style: const TextStyle(fontSize: 16))
              ]),
              TableRow(children: [
                Text("Book's Cost:",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(bookModel.cost.toString(), style: const TextStyle(fontSize: 16))
              ]),
            ]),
            SizedBox(height: 30),
            Center(
              child: Text("Transactions",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Table(
                border: TableBorder.all(color: PdfColor.fromHex("#000000")),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: transactions)
          ];
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
