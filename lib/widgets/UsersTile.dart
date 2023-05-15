import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class UsersTile extends StatelessWidget {
  const UsersTile({
    Key? key,
    required this.screenSize,
    this.points,
    this.email,
    this.individual,
    this.name,
    this.plan,
    this.daysLeft,
  }) : super(key: key);

  final Size screenSize;
  final email;
  final individual;
  final name;
  final plan;
  final points;
  final daysLeft;

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
                    Text(
                      "Name",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.height,
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.height,
                    Text(
                      "Plan",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.height,
                    individual
                        ? Text(
                            "Points",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(),
                    individual ? 10.height : Container(),
                    individual
                        ? Text(
                            "Days Left",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ":",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                10.height,
                Text(
                  ":",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                10.height,
                Text(
                  ":",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                10.height,
                individual
                    ? Text(
                        ":",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Container(),
                10.height,
                individual
                    ? Text(
                        ":",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Container(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                  ),
                ),
                10.height,
                Text(
                  email,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                  ),
                ),
                10.height,
                Text(
                  plan,
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16,
                  ),
                ),
                10.height,
                individual
                    ? Text(
                        '🪙 $points',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                        ),
                      )
                    : Container(),
                10.height,
                individual
                    ? Text(
                        daysLeft.toString(),
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 16,
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
