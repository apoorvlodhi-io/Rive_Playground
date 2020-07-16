import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:math';

//import 'demo_data.dart';
//import 'flight_barcode.dart';
//import 'flight_details.dart';
//import 'flight_summary.dart';
//import 'folding_ticket.dart';

class Ticket extends StatefulWidget {
  static const String id = 'Ticket';
  static const double nominalOpenHeight = 400;
  static const double nominalClosedHeight = 160;
//  final BoardingPassData boardingPass;
  final Function onClick;

  const Ticket({Key key, @required this.onClick}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
//  FlightSummary frontCard;
//  FlightSummary topCard;
//  FlightDetails middleCard;
//  FlightBarcode bottomCard;
  bool _isOpen;

  void handleOnTap() {
    widget.onClick();
    setState(() {
      _isOpen = !_isOpen;
//      topCard = FlightSummary(
//          boardingPass: widget.boardingPass,
//          theme: SummaryTheme.dark,
//          isOpen: _isOpen);
    });
  }

  Widget get frontCard => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xffdce6ef),
        ),
      );
  Widget get topCard => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xffdce6ef),
        ),
      );
  Widget get middleCard => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xffdce6ef),
        ),
      );
  Widget get bottomCard => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xffdce6ef),
        ),
      );
  Widget get backCard => Container(
        child: FlatButton(
          child: Text('Apoorv'),
//          onPressed: handleOnTap(),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Color(0xffdce6ef),
        ),
      );

  @override
  void initState() {
    super.initState();
    _isOpen = false;
//    frontCard = FlightSummary(boardingPass: widget.boardingPass);
//    middleCard = FlightDetails(widget.boardingPass);
//    bottomCard = FlightBarcode();
  }

  @override
  Widget build(BuildContext context) {
    return FoldingTicket(
        entries: _getEntries(), isOpen: _isOpen, onClick: handleOnTap);
  }

  List<FoldEntry> _getEntries() {
    return [
      FoldEntry(height: 160.0, front: topCard),
      FoldEntry(height: 160.0, front: middleCard, back: frontCard),
      FoldEntry(height: 80.0, front: bottomCard, back: backCard),
    ];
  }
}

class FoldingTicket extends StatefulWidget {
  static const double padding = 16.0;
  final bool isOpen;
  final List<FoldEntry> entries;
  final Function onClick;
  final Duration duration;

  FoldingTicket(
      {this.duration,
      @required this.entries,
      this.isOpen = false,
      this.onClick});

  @override
  _FoldingTicketState createState() => _FoldingTicketState();
}

class _FoldingTicketState extends State<FoldingTicket>
    with SingleTickerProviderStateMixin {
  List<FoldEntry> _entries;
  double _ratio = 0.0;
  AnimationController _controller;

  double get openHeight =>
      _entries.fold(0.0, (val, o) => val + o.height) +
      FoldingTicket.padding * 2;

  double get closedHeight => _entries[0].height + FoldingTicket.padding * 2;

  bool get isOpen => widget.isOpen;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(_tick);
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(FoldingTicket oldWidget) {
    // Opens or closes the ticked if the status changed
    _updateFromWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FoldingTicket.padding),
      height: closedHeight +
          (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                  spreadRadius: 1)
            ],
          ),
          child: _buildEntry(0)),
    );
  }

  Widget _buildEntry(int index) {
    FoldEntry entry = _entries[index];
    int count = _entries.length - 1;
    double ratio = max(0.0, min(1.0, _ratio * count + 1.0 - index * 1.0));

    Matrix4 mtx = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(1, 2, 0.2)
      ..rotateX(pi * (ratio - 1.0));

    Widget card = SizedBox(
        height: entry.height, child: ratio < 0.5 ? entry.back : entry.front);

    return Transform(
        alignment: Alignment.topCenter,
        transform: mtx,
        child: GestureDetector(
          onTap: widget.onClick,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            // Note: Container supports a transform property, but not alignment for it.
            child: (index == count || ratio <= 0.5)
                ? card
                : // Don't build a stack if it isn't needed.
                Column(children: [
                    card,
                    _buildEntry(index + 1),
                  ]),
          ),
        ));
  }

  void _updateFromWidget() {
    _entries = widget.entries;
    _controller.duration =
        widget.duration ?? Duration(milliseconds: 400 * (_entries.length - 1));
    isOpen ? _controller.forward() : _controller.reverse();
  }

  void _tick() {
    setState(() {
      _ratio = Curves.easeInQuad.transform(_controller.value);
    });
  }
}

class FoldEntry {
  final Widget front;
  Widget back;
  final double height;

  FoldEntry({@required this.front, @required this.height, Widget back}) {
    this.back = Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..rotateX(pi),
        child: back);
  }
}
