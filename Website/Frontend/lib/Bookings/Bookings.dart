import 'package:flutter/material.dart';
import 'package:flutter_application/widget_util.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  List<bool> hovering = List<bool>.filled(3, false);
  final List<String> monthAbbreviation = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  List<Widget> buildNavbarActions(double screenWidth, Color textColor,
      Color btnColor, Color btnHoverColor) {
    List<Widget> actions = [];
    int numActions = 3;
    List<String> actionPrompts = ['My Bookings', 'Map', 'Settings'];
    for (int i = 0; i < numActions; i++) {
      actions.add(
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.white.withOpacity(0.8);
                }
                return hovering[i] ? btnHoverColor : btnColor;
              },
            ),
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) return 10;
                return 2;
              },
            ),
          ),
          onPressed: () {
            // TODO
          },
          child: Text(
            actionPrompts[i],
            style: TextStyle(color: textColor, fontSize: 14),
          ),
        ),
      );
      actions.add(SizedBox(width: screenWidth * 0.03));
    }
    return actions;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isMobile = screenWidth < 800;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Image.asset(
          'assets/FullTooth.png',
        ),
        title: SizedBox(
          width: 200,
          child: Image.asset(
            'assets/ToothTrek.png',
            fit: BoxFit.scaleDown,
          ),
        ),
        actions: buildNavbarActions(
            screenWidth,
            Theme.of(context).colorScheme.onPrimary,
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.primary),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isMobile)
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 550,
                  child: Image.asset(
                    'assets/LeftHalfTooth.png',
                  ),
                ),
              ),
            ),
          Center(
            child: Container(
              height: screenHeight * 0.87,
              width: !isMobile ? screenWidth * 0.4 : screenWidth * 0.9,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 0.3,
                ),
              ),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const SizedBox(height: 100),
                  createTimeSlot(
                      '1234 Main St', DateTime.now(), '1234', context),
                ],
              )),
            ),
          ),
          if (!isMobile)
            Expanded(
              child: SizedBox(
                height: 550,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/RightHalfTooth.png',
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Container createTimeSlot(
      String address, DateTime date, String id, BuildContext context) {
    DateTime to = date.add(const Duration(minutes: 30));
    double screenWidth = MediaQuery.of(context).size.width;
    int monthIndex = date.month - 1;

    return Container(
      height: 200,
      width: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/MyBookingsContainer.png'),
            fit: BoxFit.fill),
      ),
      child: Padding(
          padding: const EdgeInsets.only(left: 25, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetUtil.createText(Colors.grey, 15, "Address"),
                  const SizedBox(height: 5),
                  WidgetUtil.createText(Colors.white, 18, address),
                  const SizedBox(height: 5),
                  WidgetUtil.createText(Colors.grey, 15, "Time"),
                  const SizedBox(height: 5),
                  WidgetUtil.createText(Colors.white, 18,
                      "${date.hour}:${date.minute} - ${to.hour}:${to.minute}"),
                  const SizedBox(height: 5),
                  WidgetUtil.createText(Colors.grey, 15, "Booking ID"),
                  const SizedBox(height: 5),
                  WidgetUtil.createText(Colors.white, 18, id),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [
                      WidgetUtil.createText(
                          Theme.of(context).colorScheme.onPrimary,
                          22,
                          monthAbbreviation[monthIndex]),
                      WidgetUtil.createText(
                          Theme.of(context).colorScheme.shadow,
                          30,
                          "${date.day}"),
                      WidgetUtil.createText(
                          Theme.of(context).colorScheme.onPrimary,
                          22,
                          "${date.year}"),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.error),
                              fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(85, 20)),
                            ),
                            onPressed: () => {},
                            child: Flexible(
                              child: WidgetUtil.createText(
                                  Theme.of(context).colorScheme.onPrimary,
                                  10,
                                  "Cancel Booking"),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
