import 'package:assignment/utils/color.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Import to use Timer

class SlidingButton extends StatefulWidget {
  final Function onSlide;

  const SlidingButton({super.key, required this.onSlide});

  @override
  _SlidingButtonState createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton> {
  double _buttonPosition = 0;
  bool _isSliding = false;
  bool _showCheckIcon = false;
  late double _maxSlidePosition;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maxSlidePosition = MediaQuery.of(context).size.width - 60;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          decoration: BoxDecoration(
            color: _isSliding ? AppColors.primaryColor : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100),
          ),
          alignment: Alignment.center,
          child: Text(
            _showCheckIcon ? "RSVP'd" : "Swipe to RSVP'd",
            style: TextStyle(
              color: _isSliding || _showCheckIcon ? Colors.white : Colors.grey.shade600,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: _buttonPosition,
          child: Container(
            child: GestureDetector(
              onPanStart: (_) {
                setState(() {
                  _isSliding = true;
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _buttonPosition += details.delta.dx;
                  if (_buttonPosition < 0) {
                    _buttonPosition = 0;
                  } else if (_buttonPosition > _maxSlidePosition) {
                    _buttonPosition = _maxSlidePosition;
                  }
                });
              },
              onPanEnd: (_) {
                if (_buttonPosition >= _maxSlidePosition * 0.9) {
                  setState(() {
                    _showCheckIcon = true;
                  });
                  widget.onSlide();
                  Timer(const Duration(seconds: 1), () {
                    _resetButton();
                  });
                } else {
                  _resetButton();
                }
              },
              child: Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _isSliding || _showCheckIcon ? Colors.white : Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: _showCheckIcon
                    ? Icon(
                  Icons.check,
                  color: AppColors.primaryColor,
                )
                    : Icon(
                  Icons.arrow_forward_ios,
                  color: _isSliding ? AppColors.primaryColor : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _resetButton() {
    setState(() {
      _buttonPosition = 0;
      _isSliding = false;
      _showCheckIcon = false;
    });
  }
}
