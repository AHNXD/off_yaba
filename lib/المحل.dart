// Import libraries
import 'package:flutter/material.dart';

class Resturant extends StatefulWidget {
  static const routeName = '/rest';
  const Resturant({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Resturant> {
  bool isDetailsPressed =
      false; // Track the pressed state of the Details button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Set background color
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(// Use Stack to position elements on top of each other
                children: <Widget>[
          // Background image
          SizedBox(
            width: double.infinity, // Cover entire width
            height: double.infinity, // Cover entire height
            child: Image.asset(
              'assets/background.jpg', // Replace with your image path
              fit: BoxFit.cover, // Cover the container with the image
            ),
          ),
          // Content positioned on top of the background
          Padding(
              padding: const EdgeInsets.all(20.0), // Add padding from all sides
              child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Distribute content vertically with space in between
                  children: <Widget>[
                    // Top area - App name and details
                    const Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Align elements horizontally with space in between
                      children: <Widget>[
                        // App name text
                        Text(
                          "كنتاكي هوم", // Restaurant name based on your description
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        // Info section with icon and text
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16.0,
                            ),
                            SizedBox(
                                width:
                                    5.0), // Add spacing between icon and text
                            Text(
                              "4.5", // Replace with actual rating
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0), // Add spacing

                    // Offer and Details buttons - Row with two buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Align buttons horizontally
                      children: <Widget>[
                        // Offer button
                        ElevatedButton(
                          onPressed: () {}, // Arabic text for "Offers"
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            textStyle: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          child: const Text('العروض'),
                        ),
                        // Details button with color change on press
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isDetailsPressed = !isDetailsPressed;
                            });
                          }, // Arabic text for "Details"
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDetailsPressed ? Colors.amber : Colors.grey,
                            textStyle: TextStyle(
                              color: isDetailsPressed
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                          child: const Text('تفاصيل'),
                        ),
                      ],
                    ),

                    // Offer section - Card with rounded corners (visible when Offers button is pressed)
                    Visibility(
                        visible:
                            !isDetailsPressed, // Show only when Details button is not pressed
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Padding(
                                padding: EdgeInsets.all(
                                    10.0), // Add padding inside the card
                                child: Column(children: <Widget>[
                                  // Offer title
                                  Text(
                                    "العروض", // Arabic text for "Offers"
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5.0), // Add spacing

                                  // Offer details - Replace with your actual offer text
                                  Text(
                                      "خصم 20% على جميع اصناف البرجر", // Arabic text for "20% discount on all burgers"
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ))
                                ]))))
                  ]))
        ])));
  }
}
