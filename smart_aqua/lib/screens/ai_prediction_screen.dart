import 'package:flutter/material.dart';

class AiPredictionScreen extends StatelessWidget {
  final Map<String, double> waterData;

  const AiPredictionScreen({
    Key? key,
    required this.waterData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double turbidity = waterData["Turbidity"] ?? 0;
    final double ph = waterData["pH Level"] ?? 7;
    final double temperature = waterData["Temperature"] ?? 25;

    /// Simple AI Risk Logic
    bool highRisk = turbidity > 5 || ph > 8.5 || ph < 6.5;

    String riskLabel = highRisk ? "HIGH RISK" : "SAFE";
    Color riskColor = highRisk ? Colors.red : Colors.green;
    String disease = highRisk ? "Cholera" : "No Major Threat";

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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

            /// HEADER
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.teal[100],
                  child: Icon(Icons.analytics,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "LIVE MONITORING",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.notifications_none),
              ],
            ),

            const SizedBox(height: 25),

            /// MAIN PREDICTION CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
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

                  /// Risk Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: riskColor.withOpacity(0.15),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      riskLabel,
                      style: TextStyle(
                        color: riskColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "AI PREDICTION RESULT",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    highRisk
                        ? "Risk Detected: $disease"
                        : "Water Quality Stable",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: riskColor,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    highRisk
                        ? "Model confidence: 92% probability of bacterial contamination."
                        : "All monitored parameters are within safe thresholds.",
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.teal[800],
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/report');
                          },
                          child:
                              const Text("Generate Report"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Share"),
                      )
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// STATUS CARDS
            Row(
              children: [
                Expanded(
                  child: buildSmallCard(
                    "Water State",
                    highRisk
                        ? "Contaminated"
                        : "Safe",
                    "Turbidity: $turbidity NTU",
                    highRisk
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: buildSmallCard(
                    "Environment",
                    "$temperature °C",
                    "pH Level: $ph",
                    Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSmallCard(
      String title,
      String value,
      String subtitle,
      Color color) {
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
          Text(title,
              style: const TextStyle(
                  color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              )),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}