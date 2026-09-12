import 'package:flutter/material.dart';
import '../services/my_reports_service.dart';
import '../widgets/report_status_chip.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  final service = MyReportsService();
  late Future<List<Map<String, dynamic>>> reportsFuture;

  @override
  void initState() {
    super.initState();
    reportsFuture = service.getMyReports();
  }

  Future<void> refreshReports() async {
    setState(() {
      reportsFuture = service.getMyReports();
    });
    await reportsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بلاغاتي'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final reports = snapshot.data ?? [];

          if (reports.isEmpty) {
            return const Center(
              child: Text('ما عندك بلاغات حالياً'),
            );
          }

          return RefreshIndicator(
            onRefresh: refreshReports,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: reports.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final report = reports[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          report['reason']?.toString() ??
                              'بلاغ بدون سبب',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const ReportStatusChip(),
                        const SizedBox(height: 8),
                        Text(
                          report['created_at']?.toString() ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
