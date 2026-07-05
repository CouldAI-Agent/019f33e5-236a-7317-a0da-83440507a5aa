import 'package:flutter/material.dart';

void main() {
  runApp(const MarineRoadApp());
}

class MarineRoadApp extends StatelessWidget {
  const MarineRoadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الهيكل التنظيمي - مشروع الطريق البحري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto', // Fallback for Arabic
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OrgChartScreen(),
      },
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}

class OrgChartScreen extends StatelessWidget {
  const OrgChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الهيكل التنظيمي - مشروع الطريق البحري', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            return Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16.0),
              child: isMobile ? _buildMobileView() : _buildDesktopView(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    return ListView(
      children: [
        _buildOrgCard(
          title: 'مدير المشروع',
          subtitle: 'المسؤول العام عن تنفيذ الطريق البحري',
          icon: Icons.person,
          color: Colors.blue[800]!,
          children: [
            _buildDepartmentNode(
              title: 'الإدارة الهندسية',
              roles: ['مهندسين بحريين', 'مهندسين مدنيين', 'مساحين'],
              icon: Icons.engineering,
            ),
            _buildDepartmentNode(
              title: 'إدارة العمليات',
              roles: ['مشرف المعدات', 'منسق الخدمات اللوجستية'],
              icon: Icons.settings,
            ),
            _buildDepartmentNode(
              title: 'إدارة الجودة والسلامة',
              roles: ['مسؤولي الأمن والسلامة', 'مفتشي الجودة'],
              icon: Icons.health_and_safety,
            ),
            _buildDepartmentNode(
              title: 'الشؤون الإدارية والمالية',
              roles: ['الموارد البشرية', 'محاسبين'],
              icon: Icons.attach_money,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopView() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildTopLevelCard(),
              const SizedBox(height: 40),
              // Connectors
              Container(
                width: 4,
                height: 40,
                color: Colors.blueGrey,
              ),
              Container(
                height: 4,
                width: 800,
                color: Colors.blueGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBranchLine(),
                  _buildBranchLine(),
                  _buildBranchLine(),
                  _buildBranchLine(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _buildDesktopDepartment(title: 'الإدارة الهندسية', roles: ['مهندسين بحريين', 'مهندسين مدنيين', 'مساحين'], icon: Icons.engineering)),
                  Expanded(child: _buildDesktopDepartment(title: 'إدارة العمليات', roles: ['مشرف المعدات', 'منسق الخدمات اللوجستية'], icon: Icons.settings)),
                  Expanded(child: _buildDesktopDepartment(title: 'إدارة الجودة والسلامة', roles: ['مسؤولي الأمن والسلامة', 'مفتشي الجودة'], icon: Icons.health_and_safety)),
                  Expanded(child: _buildDesktopDepartment(title: 'الشؤون الإدارية والمالية', roles: ['الموارد البشرية', 'محاسبين'], icon: Icons.attach_money)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBranchLine() {
    return Container(
      width: 4,
      height: 20,
      color: Colors.blueGrey,
    );
  }

  Widget _buildTopLevelCard() {
    return Card(
      elevation: 4,
      color: Colors.blue[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          children: [
            Icon(Icons.person, size: 60, color: Colors.white),
            SizedBox(height: 8),
            Text(
              'مدير المشروع',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              'الإدارة العليا',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDepartment({required String title, required List<String> roles, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.blue[600]),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
              ),
              const Divider(),
              ...roles.map((role) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(role, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrgCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    List<Widget>? children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (children != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: children,
              ),
            )
        ],
      ),
    );
  }

  Widget _buildDepartmentNode({required String title, required List<String> roles, required IconData icon}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2,
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue[600]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: roles
            .map((role) => ListTile(
                  leading: const Icon(Icons.arrow_left, size: 20),
                  title: Text(role),
                ))
            .toList(),
      ),
    );
  }
}
