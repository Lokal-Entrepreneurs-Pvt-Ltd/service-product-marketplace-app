import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokal/widgets/UikAvatar/uikAvatar.dart';

class ActiveOrder extends StatefulWidget {
  final avatarImage;
  final username;
  final location;
  final occupation;
  final contact;
  final date;
  final orderStatus;

  const ActiveOrder(
      {super.key,
      this.avatarImage =
          'https://thumbs.dreamstime.com/b/female-avatar-profile-picture-vector-female-avatar-profile-picture-vector-102690279.jpg',
      this.username = 'Natalie Dormer',
      this.location = 'Austin,USA',
      this.occupation = 'UI Designer',
      this.contact = '+22816544',
      this.date = '02-12-2021',
      this.orderStatus = 'Active'});

  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1121,
      height: 85,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffBABFC5), width: 1.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Card(
        // elevation: 10,
        margin: EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CHECK-BOX CONTAINER
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(23, 33, 12, 31),
              child: Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
                side: const BorderSide(
                  color: Color(0xff9FA8DA),
                  width: 1.0,
                ),
              ),
            ),

            UikAvatar(
              shape: UikAvatarShape.circle,
              child: Image.network(widget.avatarImage),
            ),

            Container(
                margin: EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 21,
                        child: Text(
                          widget.username,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              color: Color(0xff3A3C40)),
                        ),
                      ),
                      Container(
                        height: 16,
                        child: Text(
                          widget.occupation,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              color: Color(0xff9E9E9E)),
                        ),
                      ),
                    ])),
            Container(
              margin: EdgeInsets.only(left: 240),
              height: 21,
              child: Text(
                widget.location,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    color: Color(0xff9E9E9E)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 73),
              height: 21,
              child: Text(
                widget.contact,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    color: Color(0xff9E9E9E)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 67),
              height: 21,
              child: Text(
                widget.date,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    color: Color(0xff9E9E9E)),
              ),
            ),
            Container(
              height: 25,
              margin: EdgeInsets.only(left: 70),
              padding: const EdgeInsets.fromLTRB(17, 5, 17, 5),
              decoration: const BoxDecoration(
                  color: Color(0xffFEE440),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: Text(
                widget.orderStatus,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    color: Color(0xff212121)),
              ),
            ),
            Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(left: 79),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffbdbdbd), width: 1.0),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  size: 16.5,
                  Icons.edit_outlined,
                  color: Color(0xff9e9e9e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
