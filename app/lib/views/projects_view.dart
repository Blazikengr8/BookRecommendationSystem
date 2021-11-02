import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:portfolio_website/utils/project_model.dart';
import 'package:portfolio_website/utils/view_wrapper.dart';

class ProjectsView extends StatefulWidget {
  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  double screenWidth=0;
  double screenHeight=0;
  int selectedIndex = 0;
  List<Project> projects = [
    Project(
        title: 'Project 1',
        imageURL: 'project1.jpg',
        description:
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.'),
    Project(
        title: 'Project 2',
        imageURL: 'project2.jpg',
        description:
            'But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?'),
    Project(
        title: 'Project 3',
        imageURL: 'project3.jpg',
        description:
            'Frac suàvitate mœdus férrî. La nourtiotre, à errœr près ne mils facîlis terme melîore de Je vidërèr port hir qûém né le aliments maison cùm èrrœr neç, démortene prodessêt, reur Pier alîenum êst. Ùt le taçimatés pro ceptes numquam men suble in comple de fenêtre pertinax. Nat insolens nommence. Éi ad nail appèterê èûm des mœdêratius quîdam. Id plâcèràt bands et dicunt diàm à per àd. Naient eà n’onvectioncroprésainte se at rèferrëntûr an erant cial. Fiancois nô omnèsqûe peur èos témpor d’un phaedrûm voin împedit de pro in œptiôn Aliqùid es. Et vîdé nam dèle ullùm es nours l’émon vis,')
  ];

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage('project1.jpg'), context);
    precacheImage(AssetImage('project2.jpg'), context);
    precacheImage(AssetImage('project3.jpg'), context);
    super.didChangeDependencies();
  }

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
    double space = MediaQuery.of(context).size.height * 0.03;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text('Best Sellers',style: GoogleFonts.poppins(color: Colors.white,fontSize: 24),),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder(
                future:  getbook(),
                builder: (context, snapshot) {
                  if (snapshot.hasData==true) {
                    return ListView(
                        children: snapshot.data.map<Widget>((document) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                            child: Container(
                                height: 130,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.8,
                                color: Color(0xFF0A81AB),
                                child: Center(
                                  child: ListTile(
                                    title: Text(
                                      document.name,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,),),
                                    subtitle: Text(document.author,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,)),
                                    //Da Vinci Code Fault iN our stars
                                  ),
                                )
                            ),
                          );
                        }).toList()
                    );
                  }
                  else   {
                    return Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
        ],
      ),
    );
    
  }

  Widget mobileView() {
      return Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text('Best Sellers',style: GoogleFonts.poppins(color: Colors.white,fontSize: 24),),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: FutureBuilder(
                future:  getbook(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData==true) {
                        return ListView(
                          children: snapshot.data.map<Widget>((document) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                              child: Container(
                                  height: 130,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.8,
                                  color: Color(0xFF0A81AB),
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        document.name,
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,),),
                                      subtitle: Text(document.author,
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,)),
                                          //Da Vinci Code Fault iN our stars
                                    ),
                                  )
                              ),
                            );
                        }).toList()
                        );
                      }
                      else   {
                        return Center(child: CircularProgressIndicator());
                      }
                    }
              ),
            ),
          ],
        ),
      );
  }

  void updateIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
  }
}
class Book
{
  String name;
  String desc;
  String author;
  Book(this.name,this.desc,this.author);
}
Future<List<Book>> getbook() async{
  Response r= await get(Uri.parse('https://api.nytimes.com/svc/books/v3/lists.json?list-name=hardcover-fiction&api-key=tAttFmA99hoxCAopku9Aoa8o5n6dwGnf'));
  //print(r.body);
  Map<String, dynamic> x = jsonDecode(r.body);
      var y=x['results'];
      print(y);
     // print(y[0]['book_details']['title']);
      List<Book> k=[];
      //print(y);
      for (int i=0;i<6;i++)
        {
          k.add(Book(y[i]['book_details'][0]['title'],y[i]['book_details'][0]['description'],y[i]['book_details'][0]['author']));
        }
      return k;
}

