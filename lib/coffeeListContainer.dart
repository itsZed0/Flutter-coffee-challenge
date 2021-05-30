import 'package:coffee_app/coffee.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeListContainer extends StatefulWidget {
  @override
  _CoffeeListContainerState createState() => _CoffeeListContainerState();
}

const duration = Duration(milliseconds: 300);

class _CoffeeListContainerState extends State<CoffeeListContainer> {
  final coffeeListController = PageController(viewportFraction: .34);
  double currentPage = 0.0;
  void coffeeScrollListener() {
    setState(() {
      currentPage = coffeeListController.page!;
    });
  }

  @override
  void initState() {
    coffeeListController.addListener(coffeeScrollListener);

    super.initState();
  }

  @override
  void dispose() {
    coffeeListController.removeListener(coffeeScrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 10,
                )
              ]),
            )),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 100,
          child: Column(children: [
            AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                    coffeeList[currentPage.toInt()].price.toStringAsFixed(2),
                    style: TextStyle(fontSize: 40),
                    key: Key(coffeeList[currentPage.toInt()].name)))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Positioned(
              child: Transform.scale(
            scale: 1.4,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: coffeeListController,
                itemCount: coffeeList.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.expand();
                  }

                  final coffee = coffeeList[index - 1];
                  final result = currentPage - (index) + 1;
                  final value = -.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  print(currentPage);
                  //final value = result * 0.6;
                  //final value = currentPage -(index)+1;
                  print(result.toString() +
                      " jj " +
                      value.toString() +
                      " ll " +
                      (MediaQuery.of(context).size.height /
                              2.6 *
                              (1 - value).abs())
                          .toString());
                  return Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                            0.0,
                            index == 11
                                ? 0.0
                                : MediaQuery.of(context).size.height /
                                    2.8 *
                                    (1 - value).abs())
                        ..scale(value),
                      child: Opacity(
                          opacity: opacity,
                          child: Image.asset(
                            coffee.image,
                          )));
                  // return Image.asset(coffee.image);
                }),
          )),
        )
      ],
    );
  }
}
