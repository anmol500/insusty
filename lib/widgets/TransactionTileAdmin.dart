import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TransactionTileAdmin extends StatelessWidget {
  const TransactionTileAdmin({
    Key? key,
    required this.screenSize,
    this.businessName,
    this.customerName,
    this.date,
    this.amount,
    this.points,
    this.id,
  }) : super(key: key);

  final Size screenSize;
  final businessName;
  final customerName;
  final date;
  final amount;
  final points;
  final id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Color(0x37ffffff),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text(
                        "Brand:  " + businessName,
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      width: screenSize.width / 2,
                    ),
                    5.height,
                    SizedBox(
                      child: Text(
                        "Customer:  " + customerName,
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      width: screenSize.width / 2,
                    ),
                    10.height,
                    Text(
                      "Date:  " + date,
                      style: TextStyle(
                        color: Color(0xffFFF4AB),
                        fontSize: 18,
                      ),
                    ),
                    10.height,
                    Text(
                      id,
                      style: TextStyle(
                        color: Color(0xffFFF4AB),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$ $amount',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                  ),
                ),
                5.height,
                Text(
                  '🪙 $points',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
