import 'package:flutter/material.dart';
import 'package:flutter_playground/utils/result.dart';
import 'package:flutter_playground/views/shop/shop_viewmodel.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key, required this.viewModel});

  final ShopViewModel viewModel;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stream Example")),
      body: Center(
        child: AnimatedBuilder(
          animation: widget.viewModel.counter,
          builder: (_, __) {
            return switch (widget.viewModel.counter.latest) {
              null => const Text("No data yet"),
              Ok<int>(:final value) => Text("Value: $value"),
              Error<int>(:final error) => Text("Error: $error"),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.viewModel.counter.running
              ? widget.viewModel.counter.stop()
              : widget.viewModel.counter.start();
        },
        child: Icon(
          widget.viewModel.counter.running ? Icons.stop : Icons.play_arrow,
        ),
      ),
    );
  }
}
