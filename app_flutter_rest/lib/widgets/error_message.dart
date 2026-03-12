import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorMessage({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 60),
          SizedBox(height: 16),
          Text(
            'Error',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(message, textAlign: TextAlign.center),
          ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text('Retry')),
        ],
      ),
    );
  }
}
