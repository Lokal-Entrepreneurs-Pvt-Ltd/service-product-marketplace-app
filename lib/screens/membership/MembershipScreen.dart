import 'package:flutter/material.dart';
import '../../Widgets/UikPrice/UikPrice.dart';
import '../../Widgets/Uikbenifits/Uikbenifits.dart';
class MembershipPlan extends StatelessWidget {
  const MembershipPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16,30,16,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Membership Plans',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(19, 27, 19, 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6.82186)),
                    border:Border.all(
                      color:const Color.fromRGBO(255,193,7,1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color:  const Color.fromRGBO(255,193,7,1),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lokal Membership",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Block Level",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Benifits("Enable Internet Services"),
                      Benifits("Access to Members Area"),
                      Benifits("Shop Online Get"),
                      Benifits("Shop Online Get"),
                      Benifits("Shop Online Get"),
                      Benifits("Shop Online Get"),
                      Benifits("Shop Online Get"),
                      Benifits("Shop Online Get"),
                      const SizedBox(height: 14,),
                    ],
                  ),
                ),
                const Price(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
