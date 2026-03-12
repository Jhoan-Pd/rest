import 'package:flutter/material.dart';

import 'package:app_flutter_rest/models/user.dart';
import 'package:app_flutter_rest/services/api_service.dart';
import 'package:app_flutter_rest/widgets/error_message.dart';
import 'package:app_flutter_rest/widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _usersFuture = _apiService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorMessage(
              message: 'Failed to load users: ${snapshot.error}',
              onRetry: _loadUsers,
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          } else if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                _loadUsers();
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return UserCard(user: snapshot.data![index]);
                },
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
