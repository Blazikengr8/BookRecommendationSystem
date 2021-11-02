import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:portfolio_website/utils/theme_selector.dart';
import 'package:portfolio_website/utils/view_wrapper.dart';
import 'package:portfolio_website/widgets/navigation_arrow.dart';

class AboutView extends StatefulWidget {

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView>
    with SingleTickerProviderStateMixin {
  double screenWidth=0;
  double screenHeight=0;
  String name='';
  bool flag=false;
  var ans;
  String loremIpsum =
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ViewWrapper(
      desktopView: desktopView(),
      mobileView: mobileView(),
    );
  }

  Widget desktopView() {
    return Stack(
      children: [
        NavigationArrow(isBackArrow: false),
        NavigationArrow(isBackArrow: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 1),
            flag?Expanded(flex: 3, child: infoSection()):Container(),
            Spacer(flex: 1),
            Expanded(
                flex: 3,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text('  Genre:',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Genre',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('  Book For Reference:',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          onChanged: (String value){
                            name=value;
                          },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Book Title',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('  Favourite Author:',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Author Name',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async{
                        flag=false;
                        ans=await getList(name);
                        flag=true;
                        setState(() {
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: 600,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('Submit',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
            Spacer(flex: 1),
          ],
        )
      ],
    );
  }

  Widget mobileView() {
    return Expanded(
      child: Stack(
        children: [
          NavigationArrow(isBackArrow: false),
          NavigationArrow(isBackArrow: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              flag?Expanded(flex: 3, child: infoSection()):Container(),
              Spacer(flex: 1),
              Expanded(
                flex: 3,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text('  Genre:',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Genre',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('  Book For Reference:',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Book Title',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('  Favourite Author:',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      width: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 17),
                            hintText: 'Enter Author Name',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(13),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async{
                        flag=false;
                        ans=await getList(name);
                        flag=true;
                        setState(() {
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 50,
                        width: 600,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('Submit',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1),
            ],
          )
        ],
      ),
    );
  }

  Widget infoSection() {
    return ListView(
        children: ans.map<Widget>((document) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
            child: Container(
                height: 130,
                width: screenWidth*0.35,
                color: Color(0xFF0A81AB),
                child: Center(
                  child: ListTile(
                    title: Text(
                      document,
                      style: GoogleFonts.poppins(
                        color: Colors.white,fontSize: 24),),

                    //Da Vinci Code Fault iN our stars
                  ),
                )
            ),
          );
        }).toList()
    );
  }

  Widget profilePicture() {
    return Container(
      height: getImageSize(),
      width: getImageSize(),
      child: ClipRRect(
          child: Image.network('https://upload.wikimedia.org/wikipedia/en/6/6b/Harry_Potter_and_the_Philosopher%27s_Stone_Book_Cover.jpg'),
    )
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 350;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 300;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 200;
    } else {
      return 150;
    }
  }

  Widget infoText() {
    return Text(
      'Harry Potter has been treated abusively by his aunt and uncle, Vernon and Petunia Dursley and bullied by their son Dudley since the death of Harry’s parents ten years prior. This changes on his eleventh birthday, when a half-giant named Rubeus Hagrid delivers a letter of acceptance into Hogwarts School of Witchcraft and Wizardry, after Vernon and Petunia destroyed previous ones. Harry learns his parents, wizards James and Lily Potter, were murdered by the most evil and powerful dark wizard, Lord Voldemort, and Harry was sent to the Dursleys as a baby. Voldemort lost his powers after failing to kill Harry, going into exile and making Harry famous among the hidden magical community',
      overflow: TextOverflow.clip,
      style: ThemeSelector.selectBodyText(context),
    );
  }
}

Future<List<dynamic>> getList(String name) async{
  Response r=await get(Uri.parse('https://b40c-223-177-43-197.ngrok.io/tag?name=$name'),
      headers:{
    "Access-Control-Allow-Origin":"*",
  });
  List<dynamic> x = jsonDecode(r.body);
  print(x);
  return x;
}
