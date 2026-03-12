import 'package:flutter/material.dart';
import 'package:app_flutter_rest/models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Personal Information', [
              _buildInfoRow('Name', user.name),
              _buildInfoRow('Username', '@${user.username}'),
              _buildInfoRow('Email', user.email),
              _buildInfoRow('Phone', user.phone),
              _buildInfoRow('Website', user.website),
            ]),
            const SizedBox(height: 16.0),
            _buildInfoCard('Address', [
              _buildInfoRow('Street', user.address.street),
              _buildInfoRow('Suite', user.address.suite),
              _buildInfoRow('City', user.address.city),
              _buildInfoRow('Zipcode', user.address.zipcode),
              _buildInfoRow(
                'Coordinates',
                '${user.address.geo.lat}, ${user.address.geo.lng}',
              ),
            ]),
            const SizedBox(height: 16.0),
            _buildInfoCard('Company', [
              _buildInfoRow('Name', user.company.name),
              _buildInfoRow('Catch Phrase', user.company.catchPhrase),
              _buildInfoRow('BS', user.company.bs),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.0,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
