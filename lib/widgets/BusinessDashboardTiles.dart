import 'package:flutter/material.dart';
import 'package:flutter_next/widgets/next_grid_item.dart';
import 'package:nb_utils/nb_utils.dart';

class BusinessDashboardTiles extends StatelessWidget {
  const BusinessDashboardTiles({
    super.key,
    this.title,
    this.value,
    this.onTap,
    this.asset,
    required this.screenSize,
  });

  final title;
  final value;
  final onTap;
  final asset;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: SizedBox(
        height: screenSize.height / 2.6,
        width: screenSize.width / 2.1,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  asset,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: value == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Color(0xff00370F),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    value == null
                        ? Container(
                            height: 140,
                          )
                        : Text(
                            value.toString(),
                            style: TextStyle(
                              color: Color(0xff078229),
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
