import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

double collapsableHeight = 0.0;

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(top: 79.0),
          duration: Duration(milliseconds: 375),
          curve: Curves.ease,
          height: (width < 800.0) ? collapsableHeight : 0.0,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: navBarItems,
              ),
            ),
          ),
        ),
        Container(
          height: 80.0,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: LayoutBuilder(builder: (context, constraints) {
            if (width < 800.0) {
              return NavBarButton(
                onPressed: () {
                  //This is to open and close the animated container when the screen is of mobile size
                  if (collapsableHeight == 0.0) {
                    setState(() {
                      collapsableHeight = 240.0;
                    });
                  } else if (collapsableHeight == 240.0) {
                    setState(() {
                      collapsableHeight = 0.0;
                    });
                  }
                },
              );
            } else {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: navBarItems,
              );
            }
          }),
        ),
      ],
    );
  }
}

class NavBarButton extends StatefulWidget {
  final Function onPressed;

  NavBarButton({
    required this.onPressed,
  });

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: IconButton(
            icon: Icon(
              Icons.menu,
              size: 25.0,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                widget.onPressed();
              });
            }),
      ),
    );
  }
}

//add your routes such as Projects.route or "/stories" under routes below
List<Widget> navBarItems = [
  NavBarItem(text: 'Home', route: "", image: 'assets/emojis/house.png'),
  NavBarItem(text: 'About Me', route: "", image: 'assets/emojis/about.png'),
  NavBarItem(text: 'Fav Books', route: "", image: 'assets/emojis/book.png'),
  NavBarItem(text: 'Projects', route: "", image: 'assets/emojis/rocket.png'),
];

class NavBarItem extends StatefulWidget {
  final String text;
  final String route;
  final String image;
  NavBarItem({
    required this.text,
    required this.route,
    required this.image,
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool hoover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          hoover = true;
        });
      },
      onExit: (value) {
        setState(() {
          hoover = false;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            Navigator.pushNamed(context, widget.route);
            setState(() {
              collapsableHeight = 0.0;
            });
          },
          child: Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Image(
                    image: AssetImage(
                      widget.image,
                    ),
                    width: 20,
                  ),
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: hoover ? Colors.deepOrange : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
