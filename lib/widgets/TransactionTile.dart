import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key? key,
    required this.screenSize,
    this.businessName,
    this.date,
    this.amount,
    this.points,
  }) : super(key: key);

  final Size screenSize;
  final businessName;
  final date;
  final amount;
  final points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      businessName,
                      style: TextStyle(
                        fontFamily: 'nt',
                        color: Color(0xffffffff),
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    width: screenSize.width / 2,
                  ),
                  5.height,
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'nt',
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
                  fontFamily: 'nt',
                  color: Color(0xffffffff),
                  fontSize: 18,
                ),
              ),
              5.height,
              Text(
                '🪙 $points',
                style: TextStyle(
                  fontFamily: 'nt',
                  color: Color(0xffffffff),
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
