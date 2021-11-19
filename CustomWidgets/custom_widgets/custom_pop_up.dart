import 'package:flutter/material.dart';

enum PopUpType { success, warning, error }

class CustomPopUp {
  final PopUpType type;
  final String description;
  final String closeText;
  final String? acceptText;
  final void Function()? closeFunction;
  final void Function()? acceptFunction;
  final Widget? iconWidget;
  final double aspectRatio;

  CustomPopUp({
    required this.type,
    required this.description,
    required this.closeText,
    this.acceptText,
    this.closeFunction,
    this.acceptFunction,
    this.iconWidget,
    this.aspectRatio = 1,
  }) : assert(
          (acceptFunction != null && acceptText != null) ||
              acceptFunction == null,
        );

  show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // Design
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,

        // Controller
        content: AspectRatio(
          aspectRatio: aspectRatio,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                iconWidget == null
                    ? SizedBox.shrink()
                    : Expanded(flex: 12, child: Center(child: iconWidget!)),
                Expanded(
                  flex: iconWidget == null ? 16 : 4,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Text(description, textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: acceptFunction != null
                        ? [
                            Expanded(
                              flex: 17,
                              child: _buildActionButton(
                                context: context,
                                accept: false,
                                buttonText: closeText,
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 17,
                              child: _buildActionButton(
                                context: context,
                                accept: true,
                                buttonText: acceptText!,
                                buttonFunction: acceptFunction,
                              ),
                            ),
                          ]
                        : [
                            Expanded(
                              flex: 17,
                              child: _buildActionButton(
                                context: context,
                                accept: true,
                                buttonText: closeText,
                                buttonFunction: closeFunction,
                              ),
                            )
                          ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required bool accept,
    required String buttonText,
    Function()? buttonFunction,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: accept ? _getColor(type) : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        child: Text(
          buttonText,
          style: TextStyle(color: accept ? Colors.white : _getColor(type)),
        ),
        onPressed: () {
          buttonFunction?.call();
          Navigator.pop(context);
        },
      ),
    );
  }

  Color _getColor(PopUpType type) {
    switch (type) {
      case PopUpType.success:
        return Colors.green;
      case PopUpType.warning:
        return Colors.orange;
      case PopUpType.error:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  IconData _getIcon(PopUpType type) {
    switch (type) {
      case PopUpType.success:
        return Icons.check_box_outlined;
      case PopUpType.warning:
        return Icons.warning_amber;
      case PopUpType.error:
        return Icons.error_outline;
      default:
        return Icons.check_box_outlined;
    }
  }
}
