import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eauc/constants.dart';
import 'package:eauc/database/db.dart';
import 'package:eauc/uiscreens/login_page.dart';
import 'package:eauc/uiscreens/search_results_page.dart';
import 'package:eauc/widgetmodels/custom_normal_button.dart';
import 'package:eauc/widgetmodels/customtextbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AdvancedFilterProduct extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;

  AdvancedFilterProduct(
      {required this.screenWidth, required this.screenHeight});

  @override
  _AdvancedFilterProductState createState() => _AdvancedFilterProductState();
}

class _AdvancedFilterProductState extends State<AdvancedFilterProduct> {
  final GlobalKey<FormState> _advFilterProductFormKey = GlobalKey<FormState>();
  late String emailid;
  List<String> auctionTypes = ['All', 'Live', 'Upcoming'];
  String? _auctiontype,
      _keyword,
      _hostname,
      _productcategory,
      _basepricefrom,
      _basepriceto;
  DateTime? _datefrom, _dateto;
  List _selectedCategories = [];

  @override
  void initState() {
    super.initState();
    getIdPreference().then((value) async {
      if (value == 'No Email Attached') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        setState(() {
          this.emailid = value;
        });
      }
    });
    _auctiontype = auctionTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(15),
      contentPadding: EdgeInsets.all(15),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: kbackgroundcolor,
      scrollable: true,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: Text(
        'Advanced Filter',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 25,
          color: kprimarycolor,
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
            height: widget.screenHeight * 0.60,
            width: widget.screenWidth * 0.90,
            color: kbackgroundcolor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _advFilterProductFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Search Keyword:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: kSmallInputFieldDecoration.copyWith(
                          hintText: 'Type Search Keyword'),
                      style: kSearchFieldTextStyle,
                      cursorColor: kprimarycolor,
                      onChanged: (value) {
                        _keyword = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'HostName:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: kSmallInputFieldDecoration.copyWith(
                          hintText: 'Type Hostname'),
                      style: kSearchFieldTextStyle,
                      cursorColor: kprimarycolor,
                      onChanged: (value) {
                        _hostname = value;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Type of Auctions:',
                            style: TextStyle(
                                color: kprimarycolor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: DropdownButtonFormField(
                            style: kSearchFieldTextStyle,
                            items: auctionTypes.map((String type) {
                              return new DropdownMenuItem(
                                  value: type, child: Text(type));
                            }).toList(),
                            onChanged: (newValue) {
                              // do other stuff with _category
                              setState(
                                  () => _auctiontype = newValue.toString());
                            },
                            value: _auctiontype,
                            decoration: kSmallInputFieldDecoration,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Product Category:',
                        style: TextStyle(
                            color: kprimarycolor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MultiSelectDialogField(
                      items: List.generate(
                        categoriesList.length,
                        (index) => MultiSelectItem(
                            categoriesList[index], categoriesList[index]),
                      ),
                      // items: [
                      //   //TODO: Build categories here
                      //   MultiSelectItem('Electronics', 'Electronics'),
                      //   MultiSelectItem('Sports', 'Sports'),
                      //   MultiSelectItem('Ancient', 'Ancient'),
                      //   MultiSelectItem('Currency', 'Currency'),
                      // ],
                      chipDisplay: MultiSelectChipDisplay(
                        textStyle: TextStyle(color: Colors.blue.shade800),
                        chipColor: Colors.blue.shade100,
                      ),
                      listType: MultiSelectListType.LIST,
                      searchable: true,
                      title: Text(
                        "Select Category",
                        style: TextStyle(color: Colors.blue.shade800),
                      ),
                      selectedColor: Colors.blue.shade800,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      searchTextStyle: TextStyle(color: Colors.black),
                      backgroundColor: kbackgroundcolor,
                      buttonIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue.shade800,
                      ),
                      buttonText: Text(
                        'Select Product Categories',
                        style: TextStyle(
                          color: Colors.blue.shade800,
                          fontSize: 16,
                        ),
                      ),
                      initialValue: _selectedCategories,
                      validator: (results) {
                        if (results == null) {
                          return null;
                        } else {
                          if (results.length > 1) {
                            return 'Only 1 category can be selected';
                          } else {
                            return null;
                          }
                        }
                      },
                      onConfirm: (results) {
                        setState(() {
                          _selectedCategories = results;
                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    (_auctiontype == 'Live')
                        ? SizedBox(
                            height: 5,
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Opening Bid Range:',
                                  style: TextStyle(
                                      color: kprimarycolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    child: TextFormField(
                                      decoration: kSmallInputFieldDecoration
                                          .copyWith(hintText: ''),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: kSearchFieldTextStyle,
                                      cursorColor: kprimarycolor,
                                      validator: (value) {
                                        if ((_basepricefrom == null ||
                                                _basepricefrom
                                                    .toString()
                                                    .isEmpty) &&
                                            (_basepriceto == null ||
                                                _basepriceto
                                                    .toString()
                                                    .isEmpty)) {
                                          return null;
                                        } else if ((_basepriceto != null &&
                                                _basepriceto
                                                    .toString()
                                                    .isNotEmpty) &&
                                            (_basepricefrom != null &&
                                                _basepricefrom
                                                    .toString()
                                                    .isNotEmpty)) {
                                          return null;
                                        } else
                                          return 'Please leave either both fields blank or none';
                                        // if (_basepricefrom == null ||
                                        //     _basepricefrom!.isEmpty) {
                                        //   if (_basepriceto != null ||
                                        //       _basepriceto!.isNotEmpty)
                                        //     return 'Please leave either both fields blank or none';
                                        // } else if (!RegExp(numberRegExp)
                                        //     .hasMatch(_basepricefrom!))
                                        //   return 'Please enter a valid number';
                                        // return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _basepricefrom = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Text(
                                      'To',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      decoration: kSmallInputFieldDecoration
                                          .copyWith(hintText: ''),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: kSearchFieldTextStyle,
                                      cursorColor: kprimarycolor,
                                      validator: (value) {
                                        if ((_basepriceto == null ||
                                                _basepriceto
                                                    .toString()
                                                    .isEmpty) &&
                                            (_basepricefrom == null ||
                                                _basepricefrom
                                                    .toString()
                                                    .isEmpty)) {
                                          return null;
                                        } else if ((_basepriceto != null &&
                                                _basepriceto
                                                    .toString()
                                                    .isNotEmpty) &&
                                            (_basepricefrom != null &&
                                                _basepricefrom
                                                    .toString()
                                                    .isNotEmpty)) {
                                          if (int.parse(_basepricefrom!) >
                                              int.parse(_basepriceto!))
                                            return 'Please enter a valid range';
                                          else
                                            return null;
                                        } else
                                          return 'Please leave either both fields empty or none';
                                        // if (_basepriceto == null ||
                                        //     _basepriceto!.isEmpty) {
                                        //   if (_basepricefrom != null ||
                                        //       _basepricefrom!.isNotEmpty)
                                        //     return 'Please leave either both fields blank or none';
                                        // } else if (!RegExp(numberRegExp)
                                        //     .hasMatch(_basepriceto!))
                                        //   return 'Please enter a valid number';
                                        // else if (int.parse(_basepriceto!) <
                                        //     int.parse(_basepricefrom!))
                                        //   return 'Invalid Range';
                                        // return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _basepriceto = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Dates:',
                                  style: TextStyle(
                                      color: kprimarycolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'From:',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              DateTimePicker(
                                decoration: kSmallInputFieldDecoration.copyWith(
                                  hintText: 'From',
                                ),
                                style: TextStyle(color: Colors.black),
                                type: DateTimePickerType.dateTime,
                                dateMask: 'dd-MM-yyyy HH:mm',
                                initialValue: '',
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: 'Date',
                                timeLabelText: 'Hour',
                                onChanged: (val) {
                                  _datefrom = DateTime.parse(val);
                                },
                                validator: (val) {
                                  if ((_datefrom == null ||
                                          _datefrom.toString().isEmpty) &&
                                      (_dateto == null ||
                                          _dateto.toString().isEmpty)) {
                                    return null;
                                  } else if ((_dateto != null &&
                                          _dateto.toString().isNotEmpty) &&
                                      (_datefrom != null &&
                                          _datefrom.toString().isNotEmpty)) {
                                    return null;
                                  } else
                                    return 'Please leave either both fields blank or none';
                                },
                                onSaved: (val) => print(val),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'To:',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              DateTimePicker(
                                decoration: kSmallInputFieldDecoration.copyWith(
                                  hintText: 'To',
                                ),
                                style: TextStyle(color: Colors.black),
                                type: DateTimePickerType.dateTime,
                                dateMask: 'dd-MM-yyyy HH:mm',
                                initialValue: '',
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                icon: Icon(Icons.event),
                                dateLabelText: 'Date',
                                timeLabelText: 'Hour',
                                onChanged: (val) {
                                  _dateto = DateTime.parse(val);
                                },
                                validator: (val) {
                                  if ((_dateto == null ||
                                          _dateto.toString().isEmpty) &&
                                      (_datefrom == null ||
                                          _datefrom.toString().isEmpty)) {
                                    return null;
                                  } else if ((_dateto != null &&
                                          _dateto.toString().isNotEmpty) &&
                                      (_datefrom != null &&
                                          _datefrom.toString().isNotEmpty)) {
                                    if (_datefrom!.isAfter(_dateto!))
                                      return 'Please enter a valid range';
                                    else
                                      return null;
                                  } else
                                    return 'Please leave either both fields empty or none';
                                },
                                onSaved: (val) => print(val),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        CustomNormalButton(
          onPressed: () {
            if (!_advFilterProductFormKey.currentState!.validate())
              return;
            else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchResultsProducts(
                            auctionType: _auctiontype!,
                            dateFrom: (_datefrom == null)
                                ? ''
                                : _datefrom!.millisecondsSinceEpoch.toString(),
                            dateTo: (_dateto == null)
                                ? ''
                                : _dateto!.millisecondsSinceEpoch.toString(),
                            hostName: (_hostname == null) ? '' : _hostname!,
                            basePriceFrom:
                                (_basepricefrom == null) ? '' : _basepricefrom!,
                            basePriceTo:
                                (_basepriceto == null) ? '' : _basepriceto!,
                            productCategory: (_selectedCategories.length == 0)
                                ? ''
                                : _selectedCategories[0]!,
                            keyWord: (_keyword == null) ? '' : _keyword!,
                          )));
            }
          },
          buttonText: 'Search',
        ),
      ],
    );
  }
}
