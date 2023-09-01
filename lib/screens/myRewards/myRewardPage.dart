import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

class MyRewardPage extends StatelessWidget {
  const MyRewardPage({super.key});

  void _showScratchCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Scratch Card"),
          content: const ScratchCardContent(),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Rewards", style: TextStyle(color: Colors.black)),
        backgroundColor:
            Colors.white, // Set the background color of the app bar to white
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 16), // Add left padding to the text
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LOYALTY POINTS",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.w200), // Increase font size and set bold
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Join Loyalty Points and get rewarded while you shop. You'll get 250 points for signing up. What are you waiting for?",
                style: TextStyle(fontSize: 18), // Increase font size
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text('Join Now')),
                  ElevatedButton(onPressed: () {}, child: const Text('Log in')),
                ],
              ),
              const SizedBox(height: 32),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         Icon(Icons.favorite, color: Colors.red),
              //         Text("Your Rewards"),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Icon(Icons.star, color: Colors.yellow),
              //         Text("Earn Points"),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Icon(Icons.card_giftcard, color: Colors.green),
              //         Text("Rewards"),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Icon(Icons.list, color: Colors.blue),
              //         Text("Tiers"),
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Icon(Icons.access_time, color: Colors.orange),
              //         Text("History"),
              //       ],
              //     ),
              //   ],
              // ), // Add some spacing between the row and the divider
              // Divider(
              //   // Add a horizontal line (divider) below the row
              //   color:
              //       Colors.grey, // Customize the color of the divider if needed
              //   thickness: 1.0, // Set the thickness of the divider if needed
              // ),
              const SizedBox(height: 25),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: Divider(
              //         // Add a horizontal line to the left of "Your Rewards"
              //         color: Colors
              //             .grey, // Customize the color of the divider if needed
              //         thickness:
              //             1.0, // Set the thickness of the divider if needed
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //       child: Text(
              //         "Your Rewards",
              //         style: TextStyle(fontSize: 18),
              //       ),
              //     ),
              //     Expanded(
              //       child: Divider(
              //         // Add a horizontal line to the right of "Your Rewards"
              //         color: Colors
              //             .grey, // Customize the color of the divider if needed
              //         thickness:
              //             1.0, // Set the thickness of the divider if needed
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 25), // Add some spacing below the divider
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Expanded(
              //       child: _buildCard(
              //         icon: Icons.currency_exchange_outlined,
              //         title: "\$5 discount",
              //         subtitle: "3 days ago",
              //         onTap: () {
              //           // Add your action for the first card here
              //           print("Hello world");
              //         },
              //       ),
              //     ),
              //     SizedBox(width: 16), // Add spacing between the cards
              //     Expanded(
              //       child: _buildCard(
              //         icon: Icons.currency_exchange_outlined,
              //         title: "\$10 discount",
              //         subtitle: "5 days ago",
              //         onTap: () {
              //           // Add your action for the second card here
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the left of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Earn Points",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the right of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25), // Add some spacing below the divider
              _buildEarnPointsRow(
                [
                  _buildEarnPointsCard(
                    icon: Icons.shopping_cart,
                    title: "Purchase Item",
                    subtitle: "4 points per \$1",
                    buttonText: "Learn More",
                  ),
                  _buildEarnPointsCard(
                    icon: Icons.shopping_bag,
                    title: "Action Reward",
                    subtitle: "2 points per \$1",
                    buttonText: "Explore",
                  ),
                ],
              ),
              const SizedBox(height: 25),
              _buildEarnPointsRow(
                [
                  _buildEarnPointsCard(
                    icon: Icons.shopping_cart,
                    title: "New Purchase",
                    subtitle: "3 points per \$1",
                    buttonText: "Learn More",
                  ),
                  _buildEarnPointsCard(
                    icon: Icons.shopping_bag,
                    title: "New Action",
                    subtitle: "1 point per \$1",
                    buttonText: "Explore",
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the left of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Rewards",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the right of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25), // Add some spacing below the divider
              _buildRewardsRow(
                [
                  _buildRewardsCard(
                    context: context,
                    icon: Icons.card_giftcard_outlined,
                    title: "Free Shipping",
                    subtitle: "1000 points",
                    buttonText: "Get Reward",
                  ),
                  _buildRewardsCard(
                    context: context,
                    icon: Icons.shopping_bag,
                    title: "\$5 discount",
                    subtitle: "500 points",
                    buttonText: "Get Reward",
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the left of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Tiers",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the right of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25), // Add some spacing below the divider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTierWidget(
                      "1", "Bronze", "Start here", "2 points per \$1"),
                  _buildTierWidget(
                      "2", "Silver", "Spend \$500", "3 points per \$1"),
                  _buildTierWidget(
                      "3", "Gold", "Spend \$1000", "4 points per \$1"),
                ],
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the left of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "History",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      // Add a horizontal line to the right of "Your Rewards"
                      color: Colors
                          .grey, // Customize the color of the divider if needed
                      thickness:
                          1.0, // Set the thickness of the divider if needed
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25), // Add some spacing below the divider
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: Center(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("DATE")),
                        DataColumn(label: Text("TYPE")),
                        DataColumn(label: Text("ACTION")),
                        DataColumn(label: Text("POINTS")),
                        DataColumn(label: Text("STATUS")),
                      ],
                      rows: _generateDummyData().map((entry) {
                        return DataRow(cells: [
                          DataCell(Text(entry.date)),
                          DataCell(Text(entry.type)),
                          DataCell(Text(entry.action)),
                          DataCell(Text(entry.points.toString())),
                          DataCell(Text(entry.status)),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEarnPointsRow(List<Widget> widgets) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: widgets[0]),
        Expanded(child: widgets[1]),
      ],
    );
  }

  Widget _buildEarnPointsCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 12.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add your action for the button here
                print("Button pressed");
              },
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardsRow(List<Widget> widgets) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: widgets[0]),
        Expanded(child: widgets[1]),
      ],
    );
  }

  Widget _buildRewardsCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 12.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _showScratchCardDialog(context);
              },
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}

class ScratchCardContent extends StatelessWidget {
  const ScratchCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      child: Scratcher(
        brushSize: 30,
        threshold: 50,
        color: Colors.red,
        onChange: (value) => print("Generating Value: $value%"),
        onThreshold: () => print("Threshold reached"),
        child: Container(
          height: 300,
          width: 300,
          color: Colors.green,
          child: const Center(
            child: Text(
              "You earned 100\$",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTierWidget(
    String number, String tierName, String amount, String desc) {
  return Column(
    children: [
      Text(
        number,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        tierName,
        style: const TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        amount,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 40),
      const SizedBox(
        width: 100,
        child: Divider(
          color: Colors.grey, // Customize the color of the divider if needed
          thickness: 1.0, // Set the thickness of the divider if needed
        ),
      ),
      const SizedBox(height: 15),
      Text(
        desc,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 15),
      const SizedBox(
        width: 100,
        child: Divider(
          color: Colors.grey, // Customize the color of the divider if needed
          thickness: 1.0, // Set the thickness of the divider if needed
        ),
      ),
    ],
  );
}

class RewardHistoryEntry {
  final String date;
  final String type;
  final String action;
  final int points;
  final String status;

  RewardHistoryEntry({
    required this.date,
    required this.type,
    required this.action,
    required this.points,
    required this.status,
  });
}

List<RewardHistoryEntry> _generateDummyData() {
  final List<String> dates = [
    "2023-07-01",
    "2023-07-03",
    "2023-07-07",
    "2023-07-10",
    "2023-07-15",
  ];

  final List<String> types = [
    "Activity",
    "Reward",
    "Activity",
    "Reward",
    "Reward"
  ];
  final List<String> actions = [
    "Visit",
    "Make a Purchase",
    "Sign Up",
    "Review",
    "Refer a Friend"
  ];
  final List<int> points = [50, 100, 30, 70, 200];
  final List<String> statuses = [
    "Approved",
    "Pending",
    "Approved",
    "Declined",
    "Pending"
  ];

  final List<RewardHistoryEntry> dummyData = List.generate(5, (index) {
    return RewardHistoryEntry(
      date: dates[index],
      type: types[index],
      action: actions[index],
      points: points[index],
      status: statuses[index],
    );
  });

  return dummyData;
}
