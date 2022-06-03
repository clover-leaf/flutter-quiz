import 'package:chicken/common/common.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Constant.BORDER_RADIUS.value))),
      content: Text(
        'Are you sure want to exit?',
        style: Theme.of(context).textTheme.headline1,
      ),
      actions: <Widget>[
        ConfirmButton(
          text: 'No',
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        ConfirmButton(
          text: 'Yes, exit',
          onPressed: () {
            // context.read<QuizBloc>().add(const QuizReseted());
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({Key? key, required this.text, this.onPressed})
      : super(key: key);
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            // fixedSize: Size(80, Constant.SIDETAB_BUTTON_HEIGHT.value),
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(Constant.BORDER_RADIUS.value)))),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline2,
        ));
  }
}
