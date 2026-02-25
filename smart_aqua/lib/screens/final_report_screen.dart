import 'package:flutter/material.dart';

class FinalReportScreen extends StatelessWidget {
  const FinalReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Final Comprehensive Report",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// MAIN REPORT CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "AI Confidence Level",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "92.4%",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Divider(height: 25),

                  buildMetricRow(
                    title: "Avg pH Level",
                    value: "8.4 (Alkaline)",
                  ),

                  buildMetricRow(
                    title: "Bacterial Colony Count",
                    value: "High (1.2k/ml)",
                    valueColor: Colors.red,
                  ),

                  buildMetricRow(
                    title: "System Uptime",
                    value: "99.9%",
                  ),

                  const SizedBox(height: 20),

                  /// SUMMARY BOX
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.yellow[50],
                      borderRadius:
                          BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.yellow.shade200),
                    ),
                    child: const Text(
                      "Summary: The model identified spectral anomalies "
                      "consistent with V. cholerae. Immediate purification "
                      "intervention is required. Automated safeguards have "
                      "isolated the main reservoir.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// DOWNLOAD BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF0D1B2A),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),
                      ),
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Download Full PDF Report",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Downloading Report..."),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// RISK MAP SECTION
            const Text(
              "RISK DISTRIBUTION MAP",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage(
                      "assets/logo.png"), // replace with real map image
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding:
                      const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                            15),
                  ),
                  child: const Text(
                    "Sector A-12",
                    style: TextStyle(
                        fontWeight:
                            FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMetricRow({
    required String title,
    required String value,
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}