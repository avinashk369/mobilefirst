import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobilefirst/repository/todo_repositoryImpl.dart';
import 'package:mobilefirst/screens/todo/todo_add.dart';
import 'package:mobilefirst/styles/styles.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../blocs/parse/todobloc.dart';

class TodoMgmt extends StatefulWidget {
  const TodoMgmt({Key? key}) : super(key: key);

  @override
  State<TodoMgmt> createState() => _TodoMgmtState();
}

class _TodoMgmtState extends State<TodoMgmt> {
  SuperTooltip? tooltip;
  LiveQuery liveQuery = LiveQuery();
  late QueryBuilder<ParseObject> todoQuery;

  void onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.left,
      arrowTipDistance: 15.0,
      arrowBaseWidth: 40.0,
      arrowLength: 40.0,
      borderColor: Colors.green,
      borderWidth: 5.0,
      snapsFarAwayVertically: true,
      showCloseButton: ShowCloseButton.inside,
      hasShadow: false,
      touchThrougArea: Rect.fromLTWH(targetGlobalCenter.dx - 100,
          targetGlobalCenter.dy - 100, 200.0, 160.0),
      touchThroughAreaShape: ClipAreaShape.rectangle,
      content: const Material(
          child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, "
          "sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, "
          "sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. ",
          softWrap: true,
        ),
      )),
    );

    tooltip!.show(context);
  }

  void startLiveQuery() async {
    todoQuery = QueryBuilder<ParseObject>(ParseObject("Diet_Plans"));
    await liveQuery.client.subscribe(todoQuery);
  }

  @override
  void initState() {
    startLiveQuery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(
            context.read<TodoRepositoryImpl>(),
          )..add(const LoadTodos()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Parse Todo List",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Column(
          children: [
            ParseLiveListWidget<ParseObject>(
              query: todoQuery,
              reverse: false,
              shrinkWrap: true,
              childBuilder: (BuildContext context,
                  ParseLiveListElementSnapshot<ParseObject> snapshot) {
                if (snapshot.failed) {
                  return const Text('something went wrong!');
                } else if (snapshot.hasData) {
                  return SlidableAutoCloseBehavior(
                    child: Slidable(
                      key: ObjectKey(snapshot.loadedData),
                      closeOnScroll: true,
                      groupTag: "todo",
                      // The start action pane is the one at the left or the top side.
                      endActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {
                          BlocProvider.of<TodoBloc>(context).add(
                            DeleteTodo(snapshot.loadedData!.objectId!),
                          );
                        }),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (context) {
                              BlocProvider.of<TodoBloc>(context).add(
                                DeleteTodo(snapshot.loadedData!.objectId!),
                              );
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.of(context).push(CupertinoPageRoute(
                                builder: ((context) => ToDOAdd(
                                    id: snapshot.loadedData!.objectId!)),
                              ));
                            },
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.update_rounded,
                            label: 'Update',
                          ),
                        ],
                      ),
                      child: Builder(builder: (context) {
                        if (snapshot.loadedData!.get("Name") == "Diet Plan") {
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            Slidable.of(context)?.openEndActionPane(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            //onTap();
                          });
                        }
                        return ListTile(
                          onTap: onTap,
                          title: Text(
                            snapshot.loadedData!.get("Name"),
                            style: kLabelStyleBold,
                          ),
                          subtitle: Text(
                            snapshot.loadedData!.get("Description"),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                        );
                      }),
                    ),
                  );
                } else {
                  return const ListTile(
                    leading: CircularProgressIndicator(),
                  );
                }
              },
            ),
            // BlocBuilder<TodoBloc, TodoState>(
            //   builder: ((context, state) {
            //     if (state is TodoInitializing) {
            //       return const LoadingUI();
            //     }
            //     if (state is TodoLoaded) {
            //       return SlidableAutoCloseBehavior(
            //         child: ListView.separated(
            //             shrinkWrap: true,
            //             physics: const NeverScrollableScrollPhysics(),
            //             itemBuilder: (context, index) =>
            //                 Builder(builder: (context) {
            //                   return Slidable(
            //                     key: ObjectKey(state.todos[index]),
            //                     closeOnScroll: true,
            //                     groupTag: "todo",
            //                     // The start action pane is the one at the left or the top side.
            //                     endActionPane: ActionPane(
            //                       // A motion is a widget used to control how the pane animates.
            //                       motion: const ScrollMotion(),

            //                       // A pane can dismiss the Slidable.
            //                       dismissible: DismissiblePane(onDismissed: () {
            //                         BlocProvider.of<TodoBloc>(context).add(
            //                           DeleteTodo(state.todos[index]),
            //                         );
            //                       }),

            //                       // All actions are defined in the children parameter.
            //                       children: [
            //                         // A SlidableAction can have an icon and/or a label.
            //                         SlidableAction(
            //                           onPressed: (context) {
            //                             BlocProvider.of<TodoBloc>(context).add(
            //                               DeleteTodo(state.todos[index]),
            //                             );
            //                           },
            //                           backgroundColor: const Color(0xFFFE4A49),
            //                           foregroundColor: Colors.white,
            //                           icon: Icons.delete,
            //                           label: 'Delete',
            //                         ),
            //                         SlidableAction(
            //                           onPressed: (context) {
            //                             Navigator.of(context)
            //                                 .push(CupertinoPageRoute(
            //                               builder: ((context) => ToDOAdd(
            //                                   todo: state.todos[index])),
            //                             ));
            //                           },
            //                           backgroundColor: const Color(0xFF21B7CA),
            //                           foregroundColor: Colors.white,
            //                           icon: Icons.update_rounded,
            //                           label: 'Update',
            //                         ),
            //                       ],
            //                     ),
            //                     child: Builder(builder: (context) {
            //                       if (state.todos[index].name == "Diet Plan") {
            //                         WidgetsBinding.instance
            //                             .addPostFrameCallback((timeStamp) {
            //                           Slidable.of(context)?.openEndActionPane(
            //                             duration:
            //                                 const Duration(milliseconds: 500),
            //                             curve: Curves.ease,
            //                           );
            //                           //onTap();
            //                         });
            //                       }
            //                       return ListTile(
            //                         onTap: onTap,
            //                         title: Text(
            //                           state.todos[index].name!,
            //                           style: kLabelStyleBold,
            //                         ),
            //                         subtitle: Text(
            //                           state.todos[index].description!,
            //                         ),
            //                         trailing: const Icon(
            //                           Icons.keyboard_arrow_right,
            //                           color: Colors.grey,
            //                         ),
            //                       );
            //                     }),
            //                   );
            //                 }),
            //             separatorBuilder: (_, __) => const Divider(),
            //             itemCount: state.todos.length),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   }),
            // ),
            // CustomPaint(
            //   painter: CustomStyleArrow(Colors.grey),
            //   child: Container(
            //     padding: const EdgeInsets.only(
            //         left: 15, right: 15, bottom: 20, top: 20),
            //     child: const Text(
            //       "This is the custom painter for arrow down curve",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Tooltip(
            //     message: 'Hover Icon for Tooltip...',
            //     padding: const EdgeInsets.all(20),
            //     showDuration: const Duration(seconds: 10),
            //     decoration: ShapeDecoration(
            //       color: Colors.blue,
            //       shape: ToolTipCustomShape(),
            //     ),
            //     textStyle: const TextStyle(color: Colors.white),
            //     preferBelow: false,
            //     verticalOffset: 20,
            //     child: IconButton(
            //       icon: const Icon(Icons.info, size: 30.0),
            //       onPressed: () {},
            //     ),
            //   ),
            // ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: ((context) => ToDOAdd()),
            ));
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add_rounded),
        ),
      ),
    );
  }

  Future<void> saveTodo(String title) async {
    final todo = ParseObject('Todo')
      ..set('title', title)
      ..set('done', false);
    await todo.save();
  }

  Future<List<ParseObject>> getTodo() async {
    try {
      QueryBuilder<ParseObject> queryTodo =
          QueryBuilder<ParseObject>(ParseObject('Todo'));
      final ParseResponse apiResponse = await queryTodo.query();

      if (apiResponse.success && apiResponse.results != null) {
        return apiResponse.results as List<ParseObject>;
      } else {
        return [];
      }
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      throw Exception("Something went wrong");
    }
  }

  Future<void> updateTodo(String id, bool done) async {
    var todo = ParseObject('Todo')
      ..objectId = id
      ..set('done', done);
    await todo.save();
  }

  Future<void> deleteTodo(String id) async {
    var todo = ParseObject('Todo')..objectId = id;
    await todo.delete();
    await todo.save();
    setState(() {});
  }
}

class ToolTipCustomShape extends ShapeBorder {
  final bool usePadding;

  ToolTipCustomShape({this.usePadding = true});

  @override
  EdgeInsetsGeometry get dimensions =>
      EdgeInsets.only(bottom: usePadding ? 20 : 0);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect =
        Rect.fromPoints(rect.topLeft, rect.bottomRight - const Offset(0, 20));
    return Path()
      ..addRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 3)))
      ..moveTo(rect.bottomCenter.dx - 10, rect.bottomCenter.dy)
      ..relativeLineTo(10, 20)
      ..relativeLineTo(10, -20)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
