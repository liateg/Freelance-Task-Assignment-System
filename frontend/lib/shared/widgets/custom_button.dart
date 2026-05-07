import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutLined;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading=false,
    this.isOutLined=false,

  });
  @override
  Widget build(BuildContext context){
    final button =isOutLined
        ? OutlinedButton(
           onPressed: isLoading ? null : onPressed,
           style: OutlinedButton.styleFrom(
           padding: const EdgeInsets.symmetric(vertical: 16),
           shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
           ),
           side: const BorderSide(color: Colors.black),
        ),
           child: _buildChild(),
         )
        :
        ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1C3E1B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: _buildChild(),
        );
    return SizedBox(width: 150,child: button);
  }
  Widget _buildChild(){
    if (isLoading){
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );
    }
    return Text(
      text,
      style: TextStyle(
        color: isOutLined ? Colors.black : Colors.white,
      ),
    );
  }
}