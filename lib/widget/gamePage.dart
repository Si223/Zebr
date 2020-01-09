import 'package:flutter/material.dart';
import '../painter/painter.dart';
import '../painter/painterPiece.dart';
import '../router/router.dart';
import '../entity/zebr.dart';
import '../function/checkOutcome.dart';
import '../function/playerPiece.dart';
import '../function/AIPiece.dart';

class SWidgetState extends State<SWidget> {
  var checkerboard = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double titlePadding = MediaQuery.of(context).padding.top;
    final double height = screenSize.height - titlePadding;
    final double realHeight = height * 0.7;
    final Size basicSize = Size(screenSize.width, realHeight);
    return Column(
      children: <Widget>[
        GestureDetector(
          onTapUp: (TapUpDetails details) {
            pieceDown(checkerboard, details.globalPosition, height,
                titlePadding, screenSize, 0);
          },
          child: CustomPaint(
              size: basicSize,
              foregroundPainter:
                  PiecePainter(checkerboard, screenSize, titlePadding),
              child: CustomPaint(
                  size: basicSize,
                  foregroundPainter:
                      GomokuPainter(checkerboard, screenSize, titlePadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: realHeight,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black,
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 1.0),
                              ),
                            ],
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: ExactAssetImage('assets/th.jpg'),
                              fit: BoxFit.fill,
                            )),
                      ),
                    ],
                  ))),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, height * 0.01, 0, 0),
          height: height * 0.09,
          width: screenSize.width,
          decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                image: ExactAssetImage('assets/footer.jpg'),
                fit: BoxFit.fitWidth,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  _neverSatisfied(Text('Restarting Game'),
                      Text('Are you ready for restart?'), () {
                    init();
                  });
                },
                child: Text("Restart"),
                textTheme: ButtonTextTheme.normal,
                color: Color.fromRGBO(255, 255, 255, 0.7),
                splashColor: Color.fromRGBO(24, 144, 255, 0.4),
                colorBrightness: Brightness.light,
                elevation: 10,
              ),
              MaterialButton(
                onPressed: () {
                  _neverSatisfied(Text('Back To Main Page'),
                      Text('Are you sure you want to back to menu page?'), () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Index()));
                  });
                },
                child: Text("Back"),
                textTheme: ButtonTextTheme.normal,
                color: Color.fromRGBO(255, 255, 255, 0.7),
                splashColor: Color.fromRGBO(24, 144, 255, 0.4),
                colorBrightness: Brightness.light,
                elevation: 10,
              )
            ],
          ),
        )
      ],
    );
  }

  pieceDown(List<List<int>> checkerboard, Offset offset, double height,
      double titlePadding, Size screenSize, int type) {
    final int piece = widget.gomokuStatus.nowPlayer == 1 ? 2 : 1;
    List position = [];
    if (type == 0)
      position =
          playerPiece(checkerboard, offset, height, titlePadding, screenSize);
    else if (type == 1) {
      position = AIPiece(checkerboard);
      widget.updateLock(false);
    }

    final cX = position[0];
    final cY = position[1];
    final positionFlag =
        checkerboard[cX][cY] == 0 && widget.gomokuStatus.winPlayer == 0;
    print(positionFlag ||
        (positionFlag &&
            widget.gomokuStatus.type == 1 &&
            !widget.gomokuStatus.lock));
    if (positionFlag ||
        (positionFlag &&
            widget.gomokuStatus.type == 1 &&
            !widget.gomokuStatus.lock)) {
      setState(() {
        checkerboard[cX][cY] = widget.gomokuStatus.nowPlayer;
      });
      int outcome = checkOutcome(checkerboard, cX, cY);
      if (outcome == 0) {
        widget.updatePiece(piece);

        if (type == 0 && widget.gomokuStatus.type == 1) {
          widget.updateLock(true);
          pieceDown(checkerboard, offset, height, titlePadding, screenSize, 1);
        }
      } else {
        String winPiece = outcome == 1 ? 'Black' : 'White';
        widget.updateWinner(outcome);
        _neverSatisfied(Text('Congratulations!'),
            Text(winPiece + 'Win! \n\nDo you want play again?'), () {
          init();
        });
      }
    }
  }

  init() {
    setState(() {
      checkerboard = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      ];
    });
    widget.updatePiece(1);
    widget.updateWinner(0);
  }

  _neverSatisfied(Text title, Text text, callBack) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                text,
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                callBack();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class SWidget extends StatefulWidget {
  final GomokuStatus gomokuStatus;

  final updatePiece;
  final updateWinner;
  final updateLock;
  SWidget(
      this.gomokuStatus, this.updatePiece, this.updateWinner, this.updateLock);
  @override
  SWidgetState createState() => new SWidgetState();
}
