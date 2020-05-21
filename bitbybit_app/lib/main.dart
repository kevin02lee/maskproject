import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'data.dart';

const String title = 'BitByBit';
const String serverUrl = 'serverURL';
const bool noserver = false; // 서버 없이 테스트용

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<bool> _login(String url, String username, String password) async {
    bool isOK = false;

    try {
      final response =
          await http.get((url + "/" + username + "/" + password + "/login"));
      if (response.body == 'ok') {
        isOK = true;
      }
    } catch (_) {
      if (noserver) {
        isOK = true;
      }
    }

    return isOK;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext context) {
        return Container(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              OverflowBox(
                maxHeight: double.infinity,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "images/back_jungle_big.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "images/logo.png",
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Image.asset(
                                "images/input_bar.png",
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'ID',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Image.asset(
                                "images/input_bar.png",
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FlatButton(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/button.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                ),
                                Center(
                                  child: Text("로그인하기"),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              String username = _usernameController.text;
                              String password = _passwordController.text;
                              setState(() => _isLoading = true);
                              bool loginSuccess =
                                  await _login(serverUrl, username, password);
                              setState(() => _isLoading = false);
                              if (loginSuccess) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(username: username),
                                  ),
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("로그인에 실패했어요")));
                              }
                            },
                          ),
                          FlatButton(
                            child: Text("회원가입"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinPage()),
                              );
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class JoinPage extends StatefulWidget {
  @override
  JoinPageState createState() => JoinPageState();
}

class JoinPageState extends State<JoinPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  String dropdownSchool = "학교";
  String dropdownYear = "학년";
  String dropdownClass = "반";
  bool _isLoading = false;

  Future<bool> _join(
      String url, String group, String username, String password) async {
    bool isOK = false;

    try {
      final response = await http
          .get((url + "/" + group + "/" + username + "/" + password + "/join"));
      if (response.body == 'ok') {
        isOK = true;
      }
    } catch (_) {
      if (noserver) {
        isOK = true;
      }
    }

    return isOK;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext context) {
        return Container(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              OverflowBox(
                maxHeight: double.infinity,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "images/back_jungle_big.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              DropdownButton<String>(
                                value: dropdownSchool,
                                icon: Icon(Icons.arrow_downward),
                                underline: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownSchool = newValue;
                                  });
                                },
                                items: schoolList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              DropdownButton<String>(
                                value: dropdownYear,
                                icon: Icon(Icons.arrow_downward),
                                underline: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownYear = newValue;
                                  });
                                },
                                items: yearList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              DropdownButton<String>(
                                value: dropdownClass,
                                icon: Icon(Icons.arrow_downward),
                                underline: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownClass = newValue;
                                  });
                                },
                                items: classList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Image.asset(
                                "images/input_bar.png",
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'ID',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Image.asset(
                                "images/input_bar.png",
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'password',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Image.asset(
                                "images/input_bar.png",
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextField(
                                  obscureText: true,
                                  controller: _passwordController2,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'password again',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FlatButton(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/button.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                ),
                                Center(
                                  // width: MediaQuery.of(context).size.width * 0.3,
                                  child: Text("가입하기"),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              String username = _usernameController.text;
                              String password = _passwordController.text;
                              String password2 = _passwordController2.text;
                              String groupInfo = schoolList
                                      .indexOf(dropdownSchool)
                                      .toString() +
                                  yearList.indexOf(dropdownYear).toString() +
                                  (classList.indexOf(dropdownClass) > 9
                                      ? classList
                                          .indexOf(dropdownClass)
                                          .toString()
                                      : "0" +
                                          classList
                                              .indexOf(dropdownClass)
                                              .toString());
                              if (dropdownSchool == "학교") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("학교를 설정해주세요")));
                              } else if (dropdownYear == "학년") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("학년을 설정해주세요")));
                              } else if (dropdownClass == "반") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("반을 설정해주세요")));
                              } else if (username == "") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("ID가 비어있어요")));
                              } else if (password == "") {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("비밀번호가 비어있어요")));
                              } else if (password != password2) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text("두 비밀번호가 서로 달라요")));
                              } else {
                                setState(() => _isLoading = true);
                                bool joinSuccess = await _join(
                                    serverUrl, groupInfo, username, password);
                                setState(() => _isLoading = false);
                                if (joinSuccess) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(username: username),
                                    ),
                                  );
                                } else {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text("회원가입에 실패했어요")));
                                }
                              }
                            },
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  final String username;
  HomePage({Key key, @required this.username}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex;
  static List<Widget> _widgetPages = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _widgetPages.removeAt(index);
      if (index == 0) {
        _widgetPages.insert(
            index, Container(child: new MyPage(username: widget.username)));
      }
      if (index == 1) {
        _widgetPages.insert(index,
            Container(child: new ChatPageBegin(username: widget.username)));
      }
      if (index == 2) {
        _widgetPages.insert(
            index, Container(child: new QuizPage(username: widget.username)));
      }
      if (index == 3) {
        _widgetPages.insert(
            index, Container(child: new RankPage(username: widget.username)));
      }
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _widgetPages.add(Container(child: new MyPage(username: widget.username)));
    _widgetPages
        .add(Container(child: new ChatPageBegin(username: widget.username)));
    _widgetPages.add(Container(child: new QuizPage(username: widget.username)));
    _widgetPages.add(Container(child: new RankPage(username: widget.username)));
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: _widgetPages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox(
              child: Image.asset("images/my_unselected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            activeIcon: SizedBox(
              child: Image.asset("images/my_selected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              child: Image.asset("images/chat_unselected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            activeIcon: SizedBox(
              child: Image.asset("images/chat_selected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              child: Image.asset("images/quiz_unselected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            activeIcon: SizedBox(
              child: Image.asset("images/quiz_selected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              child: Image.asset("images/rank_unselected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            activeIcon: SizedBox(
              child: Image.asset("images/rank_selected.png"),
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            title: Text("", style: TextStyle(fontSize: 0)),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class MyPage extends StatefulWidget {
  final String username;
  MyPage({Key key, @required this.username}) : super(key: key);

  @override
  MyPageState createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  Future<UserStatus> userStatus;

  Future<UserStatus> _getUserStatus(String url, String username) async {
    try {
      final response = await http.get((url + "/" + username + "/mypage"));
      if (response.statusCode == 200) {
        return UserStatus.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user status');
      }
    } catch (_) {
      if (noserver) {
        return UserStatus();
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    userStatus = _getUserStatus(serverUrl, widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          OverflowBox(
            maxHeight: double.infinity,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "images/back_jungle_trim.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Image.asset(
            "images/notebook.png",
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Container(
            child: FutureBuilder<UserStatus>(
                future: userStatus,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("나의 정보", style: TextStyle(fontSize: 25)),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        CircleAvatar(
                          backgroundImage: AssetImage("images/nick_" +
                              nickList
                                  .indexOf(snapshot.data.nickname)
                                  .toString() +
                              ".png"),
                          radius: MediaQuery.of(context).size.width * 0.2,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text(snapshot.data.nickname,
                            style: TextStyle(
                                fontSize: 28 -
                                    (snapshot.data.nickname.length * 0.6))),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                                "images/tier_" +
                                    tierList
                                        .indexOf(snapshot.data.tier)
                                        .toString() +
                                    ".png",
                                height: 20),
                            Text(" " + snapshot.data.tier,
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.copyright, size: 20),
                            Text(" " + snapshot.data.coin.toString(),
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                            snapshot.data.chatCount.toString() +
                                " 번, " +
                                snapshot.data.chatTime.toString() +
                                " 분 동안",
                            style: TextStyle(fontSize: 18)),
                        Text(
                            snapshot.data.wordCount.toString() +
                                "개 단어를 써서 대화했어요!",
                            style: TextStyle(fontSize: 18)),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }
}

class ChatPageBegin extends StatefulWidget {
  final String username;
  ChatPageBegin({Key key, @required this.username}) : super(key: key);

  @override
  ChatPageBeginState createState() => ChatPageBeginState();
}

class ChatPageBeginState extends State<ChatPageBegin> {
  bool isQuizReady = true;

  void _checkMyQuiz(String url, String username) async {
    String body;
    try {
      final response = await http.get((url + "/" + username + "/quiz"));
      if (response.statusCode == 200) {
        body = response.body;
        if (body == "{\"quiz_list\": []}") {
          setState(() {
            isQuizReady = false;
          });
        } else if (QuizList.fromJson(json.decode(response.body)) != null) {
          setState(() {
            isQuizReady = true;
          });
        }
      } else {
        throw Exception('Failed to load quiz list');
      }
    } catch (_) {
      if (noserver) {
        setState(() {
          isQuizReady = true;
        });
      } else {
        setState(() {
          isQuizReady = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkMyQuiz(serverUrl, widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          OverflowBox(
            maxHeight: double.infinity,
            child: Image.asset(
              "images/back_jungle_trim.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Opacity(
            opacity: isQuizReady ? 0.8 : 0,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.lime[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          isQuizReady
              ? FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        "images/note.png",
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                      Text("채팅 시작하기", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            new ChatPage(username: widget.username),
                      ),
                    );
                  })
              : Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(" 아직 나의 퀴즈가 없어요! ", style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(" 퀴즈를 새로 설정하려면 ", style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(" 아래 QUIZ를 눌러주세요 ", style: TextStyle(fontSize: 18)),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.lime[200],
                    shape: BoxShape.rectangle,
                  ),
                ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.name,
      this.text,
      this.timestamp = "??:??",
      this.isMine = false,
      this.isContinued = false});
  final String name;
  final String text;
  final String timestamp;
  final bool isMine;
  final bool isContinued;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: isMine
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(timestamp + " ", style: TextStyle(fontSize: 11)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey[500]),
                  ),
                  child: Text(text, softWrap: true),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                isContinued
                    ? SizedBox(width: MediaQuery.of(context).size.width * 0.15)
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("images/nick_" +
                              nickList.indexOf(name).toString() +
                              ".png"),
                        ),
                      ),
                isContinued
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey[500]),
                        ),
                        child: Text(text, softWrap: true),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(name,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 5),
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.grey[500]),
                                ),
                                child: Text(text, softWrap: true),
                              ),
                              Text(" " + timestamp,
                                  style: TextStyle(fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                isContinued
                    ? Text(" " + timestamp, style: TextStyle(fontSize: 11))
                    : Text(""),
              ],
            ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String username;
  ChatPage({Key key, @required this.username}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  var _listener;
  bool _isComposing = false;
  bool _isConnected = false;
  bool _isLoading = false;
  bool _isChatEnd = false;
  String lastSpeaker = "";
  MateInfo mateInfo;
  DateTime lastTime;

  Future<bool> _endChat(String url, String username) async {
    try {
      final response = await http.get((url + "/" + username + "/chatend"));
      if (response.body == 'ok') {
        _isChatEnd = true;
        return true;
      } else {
        throw Exception('Failed to end chat');
      }
    } catch (_) {
      if (noserver) {
        _isChatEnd = true;
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> _getMateInfo(String url, String username) async {
    String body;
    try {
      final response = await http.get((url + "/" + username + "/chatstart"));
      if (response.statusCode == 200) {
        body = response.body;
        if (body != "no") {
          mateInfo = MateInfo.fromJson(json.decode(response.body));
          return true;
        } else {
          _isChatEnd = true;
          return false;
        }
      } else {
        throw Exception('Failed to start chat');
      }
    } catch (_) {
      if (noserver) {
        mateInfo = new MateInfo();
        return true;
      } else {
        return false;
      }
    }
  }

  Future<ReceivedMessage> _receiveMessage(String url, String username) async {
    String body;
    try {
      final response = await http.get((url + "/" + username + "/receive"));
      if (response.statusCode == 200) {
        body = response.body;
        return ReceivedMessage.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to receive message');
      }
    } catch (_) {
      if (noserver) {
        DateTime currTime = DateTime.now();
        if (currTime.isAfter(lastTime.add(Duration(seconds: 5)))) {
          return ReceivedMessage(timestamp: currTime.toString());
        } else {
          return ReceivedMessage(timestamp: lastTime.toString());
        }
      } else if (body == "no") {
        return ReceivedMessage(text: "no");
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  Future<bool> _sendMessage(
      String url, String username, String toname, String text) async {
    try {
      final response = await http.get((url +
          "/" +
          username +
          "/" +
          toname +
          "/" +
          Uri.encodeComponent(text) +
          "/send"));
      if (response.body == 'ok') {
        return true;
      } else {
        throw Exception('Failed to send message');
      }
    } catch (_) {
      if (noserver) {
        return true;
      } else {
        return false;
      }
    }
  }

  String _censor(String text) {
    censorText.forEach((censorText) =>
        text = text.replaceAll(censorText, '*' * censorText.length));
    return text;
  }

  void _initChat() async {
    setState(() => _isLoading = true);
    _isConnected = await _getMateInfo(serverUrl, widget.username);
    if (_isConnected) {
      _listener = Timer.periodic(Duration(milliseconds: 100), (timer) {
        _listen();
      });
    }
    else if (_isChatEnd) { 
      _endChat(serverUrl, widget.username);
      Navigator.of(context).pop(true);
    }
  }

  void _listen() {
    if (_isConnected) {
      if (_isLoading) {
        lastTime = DateTime.now().toUtc();
        setState(() => _isLoading = false);
      }
      Future<ReceivedMessage> receivedMessage =
          _receiveMessage(serverUrl, widget.username);
      receivedMessage.then((result) {
        DateTime receivedTime = DateTime.parse(result.timestamp);
        if (result.text != "no") {
          if (result.text == "MESSAGE_CHATEND_") {
            _isConnected = false;
            _endChat(serverUrl, widget.username);
          } else {
            lastTime = receivedTime;
            setState(() {
              _messages.insert(
                  0,
                  new ChatMessage(
                    name: mateInfo.nickname,
                    text: result.text,
                    timestamp: DateFormat("HH:mm").format(
                        receivedTime.add(DateTime.now().timeZoneOffset)),
                    isContinued:
                        lastSpeaker == mateInfo.username ? true : false,
                  ));
            });
            lastSpeaker = mateInfo.username;
          }
        }
      });
    } else {
      if (_isChatEnd) {
        _listener.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AfterChatPage(username: widget.username, mateInfo: mateInfo)),
        );
      }
    }
  }

  void _handleChanged(String text) {
    setState(() {
      _isComposing = text.length > 0;
    });
  }

  void _handleSubmitted(String text) async {
    if (_isComposing) {
      bool sendSuccess = await _sendMessage(
          serverUrl, widget.username, mateInfo.username, text);
      if (sendSuccess) {
        _textController.clear();
        _isComposing = false;
        lastSpeaker = widget.username;
        ChatMessage message = new ChatMessage(
          name: widget.username,
          text: _censor(text),
          timestamp: DateFormat("HH:mm").format(DateTime.now()),
          isMine: true,
        );
        setState(() {
          _messages.insert(0, message);
        });
      }
    }
  }

  Widget _buildTextComposer() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Flexible(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  height: 26,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _textController,
                    onChanged: _handleChanged,
                    onSubmitted: _handleSubmitted,
                    decoration:
                        new InputDecoration.collapsed(hintText: "메시지를 입력하세요"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            // margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: FlatButton(
              padding: EdgeInsets.zero,
              child: Image.asset(
                "images/send.png",
                height: 26,
                // width: MediaQuery.of(context).size.width * 0.1,
              ),
              onPressed: _isComposing
                  ? () => _handleSubmitted(_textController.text)
                  : null,
            ),
          ),
        ]));
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            // title: new Text('Are you sure?'),
            content: new Text('채팅을 종료할까요?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('돌아가기'),
              ),
              new FlatButton(
                onPressed: () {
                  if (_isConnected) {
                    _isConnected = false;
                    _sendMessage(serverUrl, widget.username, mateInfo.username,
                        "MESSAGE_CHATEND_");
                    _endChat(serverUrl, widget.username);
                    return Navigator.of(context).pop(false);
                  } else {
                    _endChat(serverUrl, widget.username);
                    return Navigator.of(context).pop(true);
                  }
                },
                child: new Text('종료'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    _initChat();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.grey),
            backgroundColor: Colors.grey[200],
            elevation: 0,
          ),
          body: Container(
              child: _isLoading
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        OverflowBox(
                          maxHeight: double.infinity,
                          child: Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              "images/back_jungle_big.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(" 상대방을 기다리는 중입니다 ",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(" 취소하려면 위쪽 화살표를 ",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01,
                              ),
                              Text(" 터치해서 종료해주세요 ",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.01,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.rectangle,
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        OverflowBox(
                          maxHeight: double.infinity,
                          child: Opacity(
                            opacity: 0.3,
                            child: Image.asset(
                              "images/back_jungle_big.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Column(children: <Widget>[
                          new Flexible(
                              child: new ListView.builder(
                            padding: new EdgeInsets.all(8.0),
                            reverse: true,
                            itemBuilder: (_, int index) => _messages[index],
                            itemCount: _messages.length,
                          )),
                          // Divider(height: 1.0),
                          _buildTextComposer(),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05),
                        ]),
                      ],
                    ))),
    );
  }
}

class AfterChatPage extends StatefulWidget {
  final String username;
  final MateInfo mateInfo;
  AfterChatPage({Key key, @required this.username, @required this.mateInfo})
      : super(key: key);

  @override
  AfterChatPageState createState() => AfterChatPageState();
}

class AfterChatPageState extends State<AfterChatPage> {
  Future<QuizList> quizList;
  TextEditingController _answerController1 = TextEditingController();
  TextEditingController _answerController2 = TextEditingController();
  TextEditingController _answerController3 = TextEditingController();
  String answer1;
  String answer2;
  String answer3;
  bool _isLoading = false;
  bool _isSubmitted = false;

  Future<QuizList> _getQuizList(String url, String username) async {
    try {
      final response = await http.get((url + "/" + username + "/quiz"));
      if (response.statusCode == 200) {
        return QuizList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load quiz list');
      }
    } catch (_) {
      if (noserver) {
        return QuizList();
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  Future<bool> _handleSubmitted(String url, String username) async {
    int correct = 0;
    if (answer1 == _answerController1.text) correct += 1;
    if (answer2 == _answerController2.text) correct += 1;
    if (answer3 == _answerController3.text) correct += 1;
    try {
      final response = await http
          .get((url + "/" + username + "/" + correct.toString() + "/submit"));
      if (response.body == 'ok') {
        return true;
      } else {
        throw Exception('Failed to submit quiz answer');
      }
    } catch (_) {
      if (noserver) {
        return true;
      } else {
        // throw Exception('Failed to submit quiz answer');
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    quizList = _getQuizList(serverUrl, widget.mateInfo.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? CircularProgressIndicator()
          : Container(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  OverflowBox(
                    maxHeight: double.infinity,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        "images/back_jungle_big.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Image.asset(
                            "images/legalpad.png",
                            width: MediaQuery.of(context).size.width * 0.8,
                          ),
                          Container(
                            child: FutureBuilder<QuizList>(
                                future: quizList,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    QuizData quiz1 =
                                        snapshot.data.quizList.length > 0
                                            ? snapshot.data.quizList[0]
                                            : QuizData(
                                                question: "퀴즈가 없어요!",
                                                answer: "");
                                    QuizData quiz2 =
                                        snapshot.data.quizList.length > 1
                                            ? snapshot.data.quizList[1]
                                            : QuizData(
                                                question: "퀴즈가 없어요!",
                                                answer: "");
                                    QuizData quiz3 =
                                        snapshot.data.quizList.length > 2
                                            ? snapshot.data.quizList[2]
                                            : QuizData(
                                                question: "퀴즈가 없어요!",
                                                answer: "");
                                    answer1 = quiz1.answer;
                                    answer2 = quiz2.answer;
                                    answer3 = quiz3.answer;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("채팅이 끝났습니다.",
                                            style: TextStyle(fontSize: 18)),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "images/nick_" +
                                                  nickList
                                                      .indexOf(widget
                                                          .mateInfo.nickname)
                                                      .toString() +
                                                  ".png"),
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Text(widget.mateInfo.nickname + "의 퀴즈!",
                                            style: TextStyle(
                                                fontSize: 24 -
                                                    (widget.mateInfo.nickname
                                                            .length *
                                                        0.6))),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02),
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(quiz1.question),
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/input_bar.png",
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _answerController1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        hintText: '정답을 입력하세요',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            _isSubmitted
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: answer1 ==
                                                            _answerController1
                                                                .text
                                                        ? Image.asset(
                                                            "images/right.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2)
                                                        : Image.asset(
                                                            "images/wrong.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2),
                                                  )
                                                : SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(quiz2.question),
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/input_bar.png",
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _answerController2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        hintText: '정답을 입력하세요',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            _isSubmitted
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: answer2 ==
                                                            _answerController2
                                                                .text
                                                        ? Image.asset(
                                                            "images/right.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2)
                                                        : Image.asset(
                                                            "images/wrong.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2),
                                                  )
                                                : SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(quiz3.question),
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/input_bar.png",
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                    ),
                                                    TextField(
                                                      controller:
                                                          _answerController3,
                                                      textAlign:
                                                          TextAlign.center,
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                        hintText: '정답을 입력하세요',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            _isSubmitted
                                                ? SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: answer3 ==
                                                            _answerController3
                                                                .text
                                                        ? Image.asset(
                                                            "images/right.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2)
                                                        : Image.asset(
                                                            "images/wrong.png",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.2),
                                                  )
                                                : SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text("${snapshot.error}"));
                                  }
                                  return CircularProgressIndicator();
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      _isSubmitted
                          ? FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "images/leaf.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  Text("돌아가기", style: TextStyle(fontSize: 11)),
                                ],
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            )
                          : FlatButton(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    "images/note.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                  ),
                                  Text("작성완료!", style: TextStyle(fontSize: 11)),
                                ],
                              ),
                              onPressed: () async {
                                bool success = await _handleSubmitted(
                                    serverUrl, widget.username);
                                if (success) {
                                  setState(() {
                                    _isSubmitted = true;
                                  });
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("퀴즈 정답을 확인하는데 실패했어요")));
                                }
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String username;
  QuizPage({Key key, @required this.username}) : super(key: key);

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Future<QuizList> quizList;
  TextEditingController _quizController1 = TextEditingController();
  TextEditingController _quizController2 = TextEditingController();
  TextEditingController _quizController3 = TextEditingController();
  TextEditingController _answerController1 = TextEditingController();
  TextEditingController _answerController2 = TextEditingController();
  TextEditingController _answerController3 = TextEditingController();
  bool _isLoading = false;

  Future<QuizList> _getQuizList(String url, String username) async {
    String body;
    try {
      final response = await http.get((url + "/" + username + "/quiz"));
      if (response.statusCode == 200) {
        body = response.body;
        return QuizList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load quiz list');
      }
    } catch (_) {
      if (noserver) {
        return QuizList();
      } else {
        if (body == "{\"quiz_list\": []}") {
          QuizList q = new QuizList();
          q.quizList.add(new QuizData(question: "", answer: ""));
          q.quizList.add(new QuizData(question: "", answer: ""));
          q.quizList.add(new QuizData(question: "", answer: ""));
          return q;
        } else {
          throw Exception('Failed to load quiz list');
        }
      }
    }
  }

  Future<bool> _setQuizList(String url, String username, QuizData quiz1,
      QuizData quiz2, QuizData quiz3) async {
    bool isOK = false;
    try {
      var response = await http.get((url +
          "/" +
          username +
          "/1/" +
          Uri.encodeComponent(quiz1.question) +
          "/" +
          Uri.encodeComponent(quiz1.answer) +
          "/problem"));
      response = await http.get((url +
          "/" +
          username +
          "/2/" +
          Uri.encodeComponent(quiz2.question) +
          "/" +
          Uri.encodeComponent(quiz2.answer) +
          "/problem"));
      response = await http.get((url +
          "/" +
          username +
          "/3/" +
          Uri.encodeComponent(quiz3.question) +
          "/" +
          Uri.encodeComponent(quiz3.answer) +
          "/problem"));
      if (response.body == 'ok') {
        isOK = true;
      }
    } catch (_) {
      if (noserver) {
        isOK = true;
      }
    }
    return isOK;
  }

  @override
  void initState() {
    super.initState();
    quizList = _getQuizList(serverUrl, widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? CircularProgressIndicator()
          : Container(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  OverflowBox(
                    maxHeight: double.infinity,
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        "images/back_jungle_trim.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Image.asset(
                            "images/banner2.png",
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                          Text("나의 퀴즈!", style: TextStyle(fontSize: 22)),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: FutureBuilder<QuizList>(
                            future: quizList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                QuizData quiz1 =
                                    snapshot.data.quizList.length > 0
                                        ? snapshot.data.quizList[0]
                                        : QuizData();
                                QuizData quiz2 =
                                    snapshot.data.quizList.length > 1
                                        ? snapshot.data.quizList[1]
                                        : QuizData();
                                QuizData quiz3 =
                                    snapshot.data.quizList.length > 2
                                        ? snapshot.data.quizList[2]
                                        : QuizData();
                                _quizController1.text = quiz1.question;
                                _quizController2.text = quiz2.question;
                                _quizController3.text = quiz3.question;
                                _answerController1.text = quiz1.answer;
                                _answerController2.text = quiz2.answer;
                                _answerController3.text = quiz3.answer;
                                return Column(
                                  children: <Widget>[
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/legalpad_quiz1.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              TextField(
                                                controller: _quizController1,
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: '퀴즈를 입력하세요',
                                                ),
                                              ),
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/input_bar.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _answerController1,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      hintText: '정답을 입력하세요',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/legalpad_quiz2.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              TextField(
                                                controller: _quizController2,
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: '퀴즈를 입력하세요',
                                                ),
                                              ),
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/input_bar.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _answerController2,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      hintText: '정답을 입력하세요',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/legalpad_quiz3.png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.16,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                              TextField(
                                                controller: _quizController3,
                                                textAlign: TextAlign.center,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                  hintText: '퀴즈를 입력하세요',
                                                ),
                                              ),
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: <Widget>[
                                                  Image.asset(
                                                    "images/input_bar.png",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                  ),
                                                  TextField(
                                                    controller:
                                                        _answerController3,
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                      hintText: '정답을 입력하세요',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              }
                              return CircularProgressIndicator();
                            }),
                      ),
                      FlatButton(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              "images/note.png",
                              width: MediaQuery.of(context).size.width * 0.15,
                            ),
                            Text("수정완료!", style: TextStyle(fontSize: 11)),
                          ],
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          QuizData quiz1 = QuizData(
                              question: _quizController1.text,
                              answer: _answerController1.text);
                          QuizData quiz2 = QuizData(
                              question: _quizController2.text,
                              answer: _answerController2.text);
                          QuizData quiz3 = QuizData(
                              question: _quizController3.text,
                              answer: _answerController3.text);
                          if (quiz1.question == "") {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("1번 퀴즈의 질문을 입력해주세요")));
                          } else if (quiz1.answer == "") {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("1번 퀴즈의 정답을 입력해주세요")));
                          } else if (quiz2.question == "") {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("2번 퀴즈의 질문을 입력해주세요")));
                          } else if (quiz2.answer == "") {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("2번 퀴즈의 정답을 입력해주세요")));
                          } else if (quiz3.question == "") {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("3번 퀴즈의 질문을 입력해주세요")));
                          } else if (quiz3.answer == "") {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("3번 퀴즈의 정답을 입력해주세요")));
                          } else {
                            setState(() => _isLoading = true);
                            bool setQuizSuccess = await _setQuizList(serverUrl,
                                widget.username, quiz1, quiz2, quiz3);
                            setState(() => _isLoading = false);
                            if (setQuizSuccess) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("나의 퀴즈가 서버에 저장되었어요")));
                            } else {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text("퀴즈를 수정하는데 실패했어요")));
                            }
                            setState(() {
                              quizList =
                                  _getQuizList(serverUrl, widget.username);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class RankPage extends StatefulWidget {
  final String username;
  RankPage({Key key, @required this.username}) : super(key: key);

  @override
  RankPageState createState() => RankPageState();
}

class RankPageState extends State<RankPage> {
  Future<RankList> rankList;

  Future<RankList> _getRankList(String url, String username) async {
    try {
      final response = await http.get((url + "/" + username + "/rank"));
      if (response.statusCode == 200) {
        return RankList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load rank list');
      }
    } catch (_) {
      if (noserver) {
        return RankList();
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    rankList = _getRankList(serverUrl, widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          OverflowBox(
            maxHeight: double.infinity,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "images/back_jungle_trim.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.asset(
                    "images/banner2.png",
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  Text("나의 랭킹!", style: TextStyle(fontSize: 22)),
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.asset(
                    "images/paper.png",
                    height: MediaQuery.of(context).size.height * 0.55,
                  ),
                  Container(
                    child: FutureBuilder<RankList>(
                        future: rankList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            int total = snapshot.data.total;
                            RankData ranker1 = total > 0
                                ? snapshot.data.rankList[0]
                                : RankData();
                            RankData ranker2 = total > 1
                                ? snapshot.data.rankList[1]
                                : RankData();
                            RankData ranker3 = total > 2
                                ? snapshot.data.rankList[2]
                                : RankData();
                            RankData ranker4 = total > 3
                                ? snapshot.data.rankList[3]
                                : RankData();
                            RankData ranker5 = total > 4
                                ? snapshot.data.rankList[4]
                                : RankData();
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(ranker1.rank.toString(),
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                          "images/tier_" +
                                              tierList
                                                  .indexOf(ranker1.tier)
                                                  .toString() +
                                              ".png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID : " + ranker1.username),
                                          Text("포인트 " +
                                              ranker1.score.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(ranker2.rank.toString(),
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                          "images/tier_" +
                                              tierList
                                                  .indexOf(ranker2.tier)
                                                  .toString() +
                                              ".png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID : " + ranker2.username),
                                          Text("포인트 " +
                                              ranker2.score.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(ranker3.rank.toString(),
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                          "images/tier_" +
                                              tierList
                                                  .indexOf(ranker3.tier)
                                                  .toString() +
                                              ".png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID : " + ranker3.username),
                                          Text("포인트 " +
                                              ranker3.score.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(ranker4.rank.toString(),
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                          "images/tier_" +
                                              tierList
                                                  .indexOf(ranker4.tier)
                                                  .toString() +
                                              ".png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID : " + ranker4.username),
                                          Text("포인트 " +
                                              ranker4.score.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.09,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(ranker5.rank.toString(),
                                              style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                          "images/tier_" +
                                              tierList
                                                  .indexOf(ranker5.tier)
                                                  .toString() +
                                              ".png",
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("ID : " + ranker5.username),
                                          Text("포인트 " +
                                              ranker5.score.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.asset(
                    "images/post.png",
                    width: MediaQuery.of(context).size.width * 0.55,
                  ),
                  Container(
                    child: FutureBuilder<RankList>(
                        future: rankList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                    "나의 순위  " +
                                        snapshot.data.myrank.toString() +
                                        "등 / " +
                                        snapshot.data.total.toString() +
                                        "명",
                                    style: TextStyle(fontSize: 14)),
                                Text(
                                    "포인트  " +
                                        snapshot.data.myscore.toString() +
                                        "P",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
