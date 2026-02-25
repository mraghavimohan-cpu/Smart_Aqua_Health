import 'package:flutter/material.dart';
import 'final_report_screen.dart';

class AiPredictionScreen extends StatelessWidget {
  final Map<String, double> waterData;

  const AiPredictionScreen({
    Key? key,
    required this.waterData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double turbidity = waterData["Turbidity"] ?? 0;
    final double temperature = waterData["Temperature"] ?? 25;

    bool highRisk = turbidity > 5;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "AI Prediction & Dashboard",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// HEADER CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.shade100,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.teal[100],
                    child: Icon(Icons.show_chart,
                        color: Colors.teal[800]),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "HealthMonitor AI",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "LIVE MONITORING",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight:
                                FontWeight.w600),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// MAIN RESULT CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border(
                  left: BorderSide(
                    color: highRisk
                        ? Colors.red
                        : Colors.green,
                    width: 5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  /// RISK BADGE
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6),
                    decoration: BoxDecoration(
                      color: highRisk
                          ? Colors.red[100]
                          : Colors.green[100],
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      highRisk
                          ? "HIGH RISK"
                          : "SAFE",
                      style: TextStyle(
                        color: highRisk
                            ? Colors.red
                            : Colors.green,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "AI PREDICTION RESULT",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    highRisk
                        ? "Risk Detected: Cholera"
                        : "Water Quality Stable",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                      color: highRisk
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Neural network analysis shows 92% confidence "
                    "of bacterial contamination in sector A-12.",
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.teal[800],
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          20),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                              "Verify Details"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {},
                        child:
                            const Text("Share"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// STATUS CARDS
            Row(
              children: [
                Expanded(
                  child: buildStatusCard(
                    icon: Icons.water_drop,
                    title: "WATER STATE",
                    value: highRisk
                        ? "Contaminated"
                        : "Safe",
                    subtitle:
                        "Turbidity: $turbidity NTU",
                    color: highRisk
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: buildStatusCard(
                    icon: Icons.thermostat,
                    title: "ENVIRONMENT",
                    value: "$temperature°C",
                    subtitle: "Humidity: 68%",
                    color: Colors.teal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// ALERT STATUS
            const Text(
              "Automated Alert Status",
              style:
                  TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            buildAlertTile(
              "SMS Alert Sent",
              "Broadcasted to 450 residents.",
              "14:05 PM",
            ),
            const SizedBox(height: 10),
            buildAlertTile(
              "Voice Call Initiated",
              "Public Utility Board notified.",
              "14:06 PM",
            ),

            const SizedBox(height: 35),

            /// FINAL REPORT BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
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
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/report',
                    arguments: waterData,
                  );
                },
                child: const Text(
                  "View Final Report",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatusCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(title,
              style:
                  const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          Text(value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                  color: color)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget buildAlertTile(
      String title, String subtitle, String time) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle,
              color: Colors.green),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight:
                            FontWeight.bold)),
                Text(subtitle),
              ],
            ),
          ),
          Text(time,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}