// ignore_for_file: prefer_const_constructor, prefer_const_constructors,

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list/controller/todoContoller.dart';
import 'package:todo_list/widgets/listbars.dart';
import '../models/listforTodo.dart';

class todoList extends StatefulWidget {
  @override
  State<todoList> createState() => _todoListState();
}

class _todoListState extends State<todoList> {
  String? title, description;
  DateTime? todoDate;
  //object of ControllerTodo
  ControllerTodo tController = ControllerTodo();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: _showAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskSheet();
        },
        backgroundColor: Color(0xff8687E7),
        child: Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 27.0, bottom: 20, left: 24, right: 24),
              child: tController.todolist.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/icons/checkList.png"),
                          width: 227,
                          height: 227,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            "What do you want to do Today?",
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color(0xffFFFFFF).withOpacity(0.87)),
                          ),
                        ),
                        Text(
                          "Tap + to add your tasks",
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xffFFFFFF).withOpacity(0.87)),
                        )
                      ],
                    )
                  : _showSearchField()),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 74.0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: ((context, index) {
                    Todo item = tController.searchTodolist != null
                        ? tController.searchTodolist![index]
                        : tController.todolist[index];
                    return ListBar(listTodo: item);
                  }),
                  itemCount: tController.searchTodolist != null
                      ? tController.searchTodolist!.length
                      : tController.todolist.length),
            ),
          ),
        ],
      ),
    );
  }

  // Appbar Function
  //     Start
  AppBar _showAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xff121212),
      leading: Padding(
        padding: const EdgeInsets.only(left: 33),
        child: Image.asset('assets/icons/sort.png'),
      ),
      title: Text(
        'Todo',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Color(0xffFFFFFF),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Image.asset(
            'assets/user.png',
            height: 42,
            width: 42,
          ),
        )
      ],
    );
  }
  //    End

  // Search Function
  //     Start
  TextField _showSearchField() {
    return TextField(
      cursorColor: const Color(0xff979797),
      style: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: const Color(0xffFFFFFF),
      ),
      onChanged: (value) {
        setState(() {
          tController.searchTodo(value);
        });
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.5),
          child: Image.asset(
            'assets/icons/search.png',
            height: 20.5,
            width: 20.5,
          ),
        ),
        fillColor: Color(0xff1D1D1D),
        filled: true,
        hintText: "Search for your task...",
        hintStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: const Color(0xffAFAFAF),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff979797))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff979797))),
      ),
    );
  }
  //     End

  //Bottom Sheet for Add Task in Todos
  //  Start
  void _showAddTaskSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return _showBottomSheet();
        });
  }
  // End

  // Bottom Sheet Function
  //     Start
  Container _showBottomSheet() {
    return Container(
      color: Color(0xff363636),
      padding: EdgeInsets.fromLTRB(
          25, 25, 25, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Add Task",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _showTextFieldinBottom("Add Title", true),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 22.25),
            child: _showTextFieldinBottom("Add Description", false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 17.0),
            child: Row(
              children: [
                _iconsInBottomSheet(
                    imageName: 'timer',
                    onPressedFunction: _selectDateTimeTogether,
                    opacity: 0.87),
                _iconsInBottomSheet(
                    imageName: 'tag', onPressedFunction: () {}, opacity: 0.87),
                _iconsInBottomSheet(
                    imageName: 'flag', onPressedFunction: () {}, opacity: 0.87),
                Spacer(),
                _iconsInBottomSheet(
                    imageName: 'send',
                    onPressedFunction: () => tController.sendButton(
                        title!, description!, todoDate!, context),
                    BorderColor: Color(0xff8687E7))
              ],
            ),
          ),
        ],
      ),
    );
  }
  //End

  // TextFields Present in Bottom Sheets
  //Start
  TextField _showTextFieldinBottom(
    String hintText,
    bool isFocus,
  ) {
    return TextField(
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        setState(() {
          if (hintText.toLowerCase().contains("title")) {
            title = value;
          } else {
            description = value;
          }
        });
      },
      autofocus: isFocus,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: const Color(0xff979797),
      style: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: const Color(0xffFFFFFF),
      ),
      decoration: InputDecoration(
        fillColor: Color(0xff363636),
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: Color(0xffFFFFFF).withOpacity(0.50),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff979797))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff979797))),
      ),
    );
  }
  //End

  // Icon Buttons in Todo Bottom Sheet
  //Start
  IconButton _iconsInBottomSheet(
      {required String imageName,
      VoidCallback? onPressedFunction,
      Color BorderColor = const Color(0xffFFFFFF),
      double? opacity = 1.0}) {
    return IconButton(
        onPressed: onPressedFunction,
        icon: ImageIcon(
          AssetImage("assets/icons/$imageName.png"),
          color: BorderColor.withOpacity(opacity!),
        ));
  }
  //End

  //Select Date Time Together for Todo
  //Start
  void _selectDateTimeTogether() async {
    todoDate = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2099)))!;
    TimeOfDay? todoTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (todoTime != null) {
      setState(() {
        todoDate = DateTime(todoDate!.year, todoDate!.month, todoDate!.day,
            todoTime.hour, todoTime.minute);
      });
    }
  }
  //End

}
