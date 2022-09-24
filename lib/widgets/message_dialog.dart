import 'package:flutter/material.dart';

//======================================================================

class MessageDialog extends StatelessWidget {
  final String image;
  final String title;
  final String? description;
  final String buttonText;
  final bool extraButton;
  final Function firstButtonFunctoin;
  final Function? secondButtonFunction;
  final String? buttonText2;
  const MessageDialog(
      {Key? key,
      required this.image,
      required this.title,
      this.description,
      required this.buttonText,
      required this.extraButton,
      required this.firstButtonFunctoin,
      this.secondButtonFunction,
      this.buttonText2})
      : super(key: key);

//------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: SizedBox(
        width: screenSize.size.width * 0.8,
        height: screenSize.size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: screenSize.size.height * 0.23,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.red, fontSize: 25, fontWeight: FontWeight.w500),
            ),
            description == null ? const SizedBox() : Text(description!),
            extraButton
                ? SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenSize.size.width * 0.4 - 40,
                          height: screenSize.size.height * 0.07,
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side:
                                    const BorderSide(color: Color(0xff140f5f)),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                              onPressed: () => firstButtonFunctoin(),
                              child: Text(
                                buttonText,
                                style:
                                    const TextStyle(color: Color(0xff140f5f)),
                              )),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          width: screenSize.size.width * 0.4 - 40,
                          height: screenSize.size.height * 0.07,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff140f5f)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            onPressed: () => secondButtonFunction!(),
                            child: Text(buttonText2!),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: screenSize.size.width * 0.4 - 15,
                    height: screenSize.size.height * 0.1,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff140f5f)),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        onPressed: () => firstButtonFunctoin(),
                        child: Text(buttonText)),
                  )
          ],
        ),
      ),
    );
  }
}
