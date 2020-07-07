import 'package:flutter/material.dart';

class FilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter Result',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _titleContainer("Kategori Pencarian"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 1.0,
                  children: <Widget>[
                    filterChipWidget(
                      chipName: 'Ekonomi Rendah',
                    ),
                    filterChipWidget(
                      chipName: 'Disabilitas',
                    ),
                    filterChipWidget(
                      chipName: 'Penyakit Kronis',
                    ),
                    filterChipWidget(
                      chipName: 'Putus Sekolah',
                    ),
                    filterChipWidget(
                      chipName: 'Yatim/Piatu',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _titleContainer("Kategori Usia"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 1.0,
                  children: <Widget>[
                    filterChipWidget(
                      chipName: 'Anak',
                    ),
                    filterChipWidget(
                      chipName: 'Remaja',
                    ),
                    filterChipWidget(
                      chipName: 'Dewasa',
                    ),
                    filterChipWidget(
                      chipName: 'Lansia',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _titleContainer(String myTitle) {
  return Text(
    myTitle,
    style: TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
  );
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Colors.blue, fontSize: 13.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.blue[100],
    );
  }
}
