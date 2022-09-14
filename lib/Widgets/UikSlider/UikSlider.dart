import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login/screens/MainPage/RowCard.dart';

class UikSlider extends StatelessWidget {
  final heightSize;
  final slide;

  UikSlider({
    this.heightSize,
    this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightSize,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < slide.length; i++) ...[
            RowCard(
              imgVal: Image.asset(slide[i]["image"]).image,
              text: (slide[i]["text"]),
            ),
            const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}
