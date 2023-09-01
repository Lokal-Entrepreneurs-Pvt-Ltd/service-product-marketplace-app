import "package:flutter/material.dart";
import 'package:lokal/widgets/UikiIcon/uikIcon.dart';

class GroupAvatar extends StatelessWidget {
  final list;
  final leftIcon;
  final rightIcon;
  GroupAvatar({super.key, 
    required this.list,
    this.leftIcon,
    this.rightIcon,
  });

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Row(
            children: [
              Container(
                child: (leftIcon != null)
                    ? GestureDetector(
                        child: const UikIcon(
                          iconSize: 42,
                          valIcon: Icons.add_circle_outline,
                          iconColor: Color(0xFF82868C),
                        ),
                        onTap: () {},
                      )
                    : (Container()),
              ),
              SizedBox(
                width: (leftIcon != null) ? 6.44 : null,
              ),
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Align(
                    widthFactor: 0.6, //distance of image from another image
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 18,

                        backgroundImage: NetworkImage(
                            list[index++]), // Provide your custom image
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: (rightIcon != null) ? 6.44 : null,
              ),
              Container(
                child: (rightIcon != null)
                    ? GestureDetector(
                        child: const UikIcon(
                          iconSize: 42,
                          valIcon: Icons.add_circle_outline,
                          iconColor: Color(0xFF82868C),
                        ),
                        onTap: () {},
                      )
                    : (Container()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
