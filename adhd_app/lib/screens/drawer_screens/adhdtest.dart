import 'dart:ffi';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:unicons/unicons.dart';

class AdhdTest extends StatefulWidget {
  AdhdTest({Key? key}) : super(key: key);

  @override
  State<AdhdTest> createState() => _AdhdTestState();
}

class _AdhdTestState extends State<AdhdTest> {
  String url = 'http://10.0.2.2:5000/api?Query=';

  var Data;

  String QueryText = 'Query';
  String _testResult = 'load';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
    // _policyGradientAgent = PolicyGradientAgent();
  }

  uploadFile(String filePath) async {
    var postUri = Uri.parse("http://10.0.2.2:5000/api");
    var request = http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await File.fromUri(Uri.parse(filePath)).readAsBytes(),
        contentType: MediaType('nii.gz', 'nii.gz'),
      ),
    );

    request.send().then(
      (response) {
        if (response.statusCode == 200) {
          print("Uploaded!");
        }
      },
    );
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
      ))
          ?.files;
      //! remember this part well.
      print('girl: ' + _paths!.map((e) => e.path).toList()[0].toString());
      url = url + _paths!.map((e) => e.path).toList()[0].toString();
      print('querytextyaraaaaaab');
      Upload(File(_paths!.map((e) => e.path).toList()[0].toString()));
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
      _testResult = 'load';
    });
  }

  // ignore: non_constant_identifier_names
  Upload(File imageFile) async {
    print('enter');
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(url);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print('test response' + value);
      setState(() {
        _testResult = value;
        print(_testResult == 'true');
      });
    });
  }

  void _selectFolder() async {
    _resetState();
    try {
      String? path = await FilePicker.platform.getDirectoryPath();
      setState(() {
        _directoryPath = path;
        _userAborted = path == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveFile() async {
    _resetState();
    try {
      String? fileName = await FilePicker.platform.saveFile(
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        type: _pickingType,
      );
      setState(() {
        _saveAsFileName = fileName;
        _userAborted = fileName == null;
      });
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).buttonColor,
          elevation: 9,
          leading: const Icon(Icons.arrow_back, size: 30),
          title: Row(
            children: [
              Text(
                'Welcome to ADHD Test',
                textAlign: TextAlign.center,
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.favorite)
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(children: [
                      Text(
                        'Please Upload the soft-copy of your MRI ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.abel(
                          color: Colors.blueGrey[200],
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '(ex: mri.nii.gz)',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.abel(
                          color: Colors.blueGrey[200],
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).buttonColor,
                            elevation: 5,
                            textStyle: GoogleFonts.acme(
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w200,
                              fontSize: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () => _pickFiles(),
                          child:
                              Text(_multiPick ? 'Pick files' : 'Pick Your MRI'),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    child: Builder(
                      builder: (BuildContext context) => _isLoading
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 10.0, top: 10.0),
                              child: Text(
                                'Uploading the MRI.....',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.abel(
                                  color: Colors.blueGrey[300],
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : _userAborted
                              ? const Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'User has aborted the dialog',
                                  ),
                                )
                              : _directoryPath != null
                                  ? ListTile(
                                      title: const Text('Directory path'),
                                      subtitle: Text(_directoryPath!),
                                    )
                                  : _paths != null
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 30.0),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.50,
                                          child: Scrollbar(
                                              child: ListView.separated(
                                            itemCount: _paths != null &&
                                                    _paths!.isNotEmpty
                                                ? _paths!.length
                                                : 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final bool isMultiPath =
                                                  _paths != null &&
                                                      _paths!.isNotEmpty;
                                              final String name =
                                                  'File $index: ' +
                                                      (isMultiPath
                                                          ? _paths!
                                                              .map(
                                                                  (e) => e.name)
                                                              .toList()[index]
                                                          : _fileName ?? '...');
                                              final path = kIsWeb
                                                  ? null
                                                  : _paths!
                                                      .map((e) => e.path)
                                                      .toList()[index]
                                                      .toString();

                                              return ListTile(
                                                title: Text(
                                                  name,
                                                ),
                                                subtitle: Text(path ?? ''),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                        int index) =>
                                                    const Divider(),
                                          )),
                                        )
                                      : _saveAsFileName != null
                                          ? ListTile(
                                              title: const Text('Save file'),
                                              subtitle: Text(_saveAsFileName!),
                                            )
                                          : const SizedBox(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Result:',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.abel(
                          color: Colors.blueGrey[600],
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      _testResult != 'load'
                          ? _testResult == "true"
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'With ADHD',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.abel(
                                        color: Colors.red[900],
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    // Icon(
                                    //   Icons.circle_outlined,
                                    //   color: Colors.red[900],
                                    // ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'WithOut ADHD',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.abel(
                                        color: Colors.green[900],
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    // Icon(
                                    //   Icons.circle_outlined,
                                    //   color: Colors.green[900],
                                    // ),
                                  ],
                                )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Wait, The process may take few minutes',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.abel(
                                    color: Colors.blue[900],
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                // Icon(
                                //   Icons.circle_outlined,
                                //   color: Colors.blue[900],
                                // ),
                              ],
                            )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
