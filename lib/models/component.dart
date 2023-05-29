import 'package:flutter/material.dart';
import 'package:mobp/utilities/remote_database.dart';

import '../screens/components/edit_component.dart';
import '../widgets/components/image_widget.dart';
import '../widgets/components/separator_widget.dart';
import '../widgets/components/subtitle_widget.dart';
import '../widgets/components/text_widget.dart';
import '../widgets/components/title_widget.dart';

class ProcessComponent {
  String id, widget, processID;
  int index;
  List<dynamic> data;

  ProcessComponent({
    required this.id,
    required this.processID,
    required this.widget,
    required this.index,
    required this.data
  });

  Widget getWidget() {
    Widget componentWidget = const Text('');
    switch (widget) {
      case 'text':
        componentWidget = TextComponent(text: data[0]);
        break;
      case 'image':
        componentWidget = ImageComponent(url: data[0]);
        break;
      case 'separator':
        componentWidget = const SeparatorComponent();
        break;
      case 'title':
        componentWidget = TitleComponent(text: data[0]);
        break;
      case 'subtitle':
        componentWidget = SubtitleComponent(text: data[0]);
        break;
      default:
        break;
    }
    return componentWidget;
  }

  Widget getListWidget(context) {
    List<dynamic> dataList = [""];

    if (data.isNotEmpty) {
      dataList[0] = data[0];
    }

    return Padding(
      key: Key(id),
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF3D3B3C),
            border: Border(bottom: BorderSide(color: Colors.black)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if(widget != 'separator' && widget != 'list') {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EditComponent(component: this,)));
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.white24,
                              width: 1
                          )
                      )
                  ),
                  padding: const EdgeInsets.all(10),
                  width: 251,
                  height: 95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("$index. $widget", style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis),),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text("$dataList", style: const TextStyle(color: Colors.grey),)
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
            Material(
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(5)),
              color: Colors.transparent,
              child: IconButton(
                  onPressed: () async {
                    await RemoteDatabase.getUserData().collection('ListProcess')
                        .doc(processID).collection('Components').doc(id)
                        .delete();
                  },
                  icon: const Icon(Icons.delete, color: Colors.white,)
              ),
            ),
          ],
        ),
      ),
    );
  }
}