import 'package:flutter/material.dart';
import 'package:flutter_playground/views/shop/shop_viewmodel.dart';

class ShopScreen extends StatefulWidget {
  final ShopViewModel viewModel;

  const ShopScreen({super.key, required this.viewModel});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.start();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        final vm = widget.viewModel;

        return Scaffold(
          appBar: AppBar(title: const Text('Shop')),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Traffic count: ${vm.currentCount}',
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 8),
                if (vm.isRunning)
                  const Text(
                    'Updating, please wait...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag: 'start_pause',
                onPressed: vm.isRunning ? vm.pause : vm.start,
                child: Icon(vm.isRunning ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(width: 16),
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: vm.reset,
                child: const Icon(Icons.restart_alt),
              ),
            ],
          ),
        );
      },
    );
  }
}
