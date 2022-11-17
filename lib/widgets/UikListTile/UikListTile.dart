import 'package:flutter/material.dart';

class UikListTile extends StatelessWidget {
  final lead;
  final trail;
  final pdng;
  final mrgn;
  const UikListTile(
      {super.key,
      required this.lead,
      required this.trail,
      this.pdng,
      this.mrgn});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsetsDirectional.all(pdng),
      leading: lead,
      trailing: trail,
    );
  }
}
