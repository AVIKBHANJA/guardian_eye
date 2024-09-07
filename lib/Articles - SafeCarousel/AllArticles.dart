import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guardian_eye/screens/constants.dart';
import 'ArticleDesc.dart';
import 'SadeWebView.dart';

class AllArticles extends StatefulWidget {
  const AllArticles({super.key});

  @override
  _AllArticlesState createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/bg-top.png'),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
                color: Colors.grey[50]?.withOpacity(0.3),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      List.generate(
                        imageSliders.length,
                        (index) => Hero(
                          tag: articleTitle[index],
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 180,
                              child: InkWell(
                                onTap: () => _handleArticleTap(context, index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(imageSliders[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.5),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, bottom: 8),
                                        child: Text(
                                          articleTitle[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleArticleTap(BuildContext context, int index) {
    if (index == 0) {
      navigateToRoute(
        context,
        SafeWebView(
          index: index,
          title: "Indian women inspiring the country",
          url:
              "https://www.seniority.in/blog/10-women-who-changed-the-face-of-india-with-their-achievements/",
        ),
      );
    } else if (index == 1) {
      navigateToRoute(
        context,
        SafeWebView(
          index: index,
          title: "We have to end Violence",
          url:
              "https://plan-international.org/ending-violence/16-ways-end-violence-girls",
        ),
      );
    } else if (index == 2) {
      navigateToRoute(context, ArticleDesc(index: index));
    } else {
      navigateToRoute(
        context,
        SafeWebView(
          index: index,
          title: "You are weak and ugly",
          url:
              "https://www.healthline.com/health/womens-health/self-defense-tips-escape",
        ),
      );
    }
  }

  void navigateToRoute(BuildContext context, Widget route) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => route),
    );
  }
}
