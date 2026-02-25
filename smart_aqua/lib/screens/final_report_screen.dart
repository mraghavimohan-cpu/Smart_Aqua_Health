import 'package:flutter/material.dart';

class FinalReportScreen extends StatelessWidget {
  final Map<String, double> waterData;

  const FinalReportScreen({
    Key? key,
    required this.waterData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double turbidity = waterData["Turbidity"] ?? 0;
    final double ph = waterData["pH Level"] ?? 7;

    bool highRisk = turbidity > 5 || ph < 6.5 || ph > 8.5;

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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  /// Title Row
                  Row(
                    children: const [
                      Icon(Icons.description,
                          color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        "Final Comprehensive Report",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  buildMetricRow(
                    "AI Confidence Level",
                    highRisk ? "92.4%" : "98.7%",
                  ),

                  buildMetricRow(
                    "Avg pH Level",
                    "$ph (${ph > 7.5 ? "Alkaline" : "Normal"})",
                  ),

                  buildMetricRow(
                    "Bacterial Colony Count",
                    highRisk
                        ? "High (1.2k/ml)"
                        : "Normal",
                    valueColor:
                        highRisk ? Colors.red : Colors.green,
                  ),

                  buildMetricRow(
                    "System Uptime",
                    "99.9%",
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
                        color: Colors.yellow.shade300,
                      ),
                    ),
                    child: Text(
                      highRisk
                          ? "Summary: The model identified spectral anomalies "
                            "consistent with bacterial contamination. "
                            "Immediate purification intervention is required."
                          : "Summary: All monitored water parameters fall "
                            "within safe regulatory standards. No immediate "
                            "intervention required.",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
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
                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Generating PDF Report..."),
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
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              child: Stack(
                children: [

                  /// Map Placeholder
                  const Center(
                    child: Text(
                      "Heatmap Visualization",
                      style: TextStyle(
                          color: Colors.black54),
                    ),
                  ),

                  /// Red Risk Zone Indicator
                  if (highRisk)
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color:
                              Colors.red.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5),
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
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMetricRow(
    String title,
    String value, {
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 6),
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
              fontWeight:
                  FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}