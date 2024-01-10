
import 'package:cares_task/core/features/crud/crud_controller.dart';
import 'package:cares_task/core/features/crud/model/fatch_response.dart';
import 'package:cares_task/core/theme/color_scheme.dart';
import 'package:cares_task/core/utils/hexcolor.dart';
import 'package:cares_task/core/utils/toast.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';


class UpdateScreen extends StatefulWidget {

  final FetchResponse tasklist;

  const UpdateScreen({Key? key, required this.tasklist}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {


  bool obscureText = true;

  String? title;

  String? details;

  final format = DateFormat("yyyy-MM-dd");

  final formatTime = DateFormat("hh:mm a");

  final formKey = GlobalKey<FormState>();

  final TextEditingController dateController =TextEditingController();

  final TextEditingController timeController =TextEditingController();

  final crudController = Get.put(CrudController());

  @override
  void initState() {

    title = widget.tasklist.title.toString();
    details = widget.tasklist.title.toString();

    super.initState();
  }

  void updateValidator(){

    if (formKey.currentState!.validate()) {

      crudController.updateTask(title.toString(), details.toString(), dateController.text.toString(), timeController.text.toString(),widget.tasklist.id.toString());

      formKey.currentState!.reset();

      setState(() {
        title="";
        details="";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
          appBar:AppBar(
              backgroundColor:darkColorScheme.inverseSurface,
              elevation: 2,
              centerTitle: true,
              title: Text(
                "Update Page",
                style: textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),

          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Lottie.asset("assets/animation/otp.json", height: 150)),

                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Update Task",
                    style: textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Card(
                          child: TextFormField(
                            initialValue: title,
                            keyboardType: TextInputType.text,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Your task title';
                              }
                              return null;
                            }, onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Colors.white38,
                                filled: true,
                                hintText: "Enter  task title",
                                prefixIcon: Icon(FluentIcons.task_list_add_20_filled,color: Colors.black38)
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Card(
                          child: TextFormField(
                            initialValue: details,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Enter Your task details';
                              }
                              return null;
                            }, onChanged: (value) {
                            setState(() {
                              details = value;
                            });
                          },
                            decoration: InputDecoration(
                              fillColor: Colors.white38,
                              filled: true,
                              contentPadding: const EdgeInsets.all(32),
                              hintText: "Enter task details",
                              prefixIcon: Icon(Icons.task,color: HexColor('#855EA9'),),
                            ),
                            keyboardType: TextInputType.text,

                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Card(
                          child: DateTimeField(
                            controller: dateController,
                            format: format,
                            validator: (val) {
                              if (val == null || val.toString().isEmpty) {
                                return 'Enter Your task date';
                              }
                              return null;
                            },
                            decoration:   InputDecoration(
                              labelText: 'Enter click Date',
                              prefixIcon: Icon(Icons.date_range,color: HexColor('#855EA9'),),
                            ),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate:  currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        Card(
                          child: DateTimeField(
                            controller: timeController,
                            format: formatTime,
                            validator: (val) {
                              if (val == null || val.toString().isEmpty) {
                                return 'Enter Your task time';
                              }
                              return null;
                            },
                            decoration:  InputDecoration(
                              labelText: 'Enter click Time',
                              prefixIcon: Icon(Icons.lock_clock,color: HexColor('#855EA9'),),
                            ),
                            onShowPicker: (context, currentValue) async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              //foregroundColor: colorScheme.onPrimary,
                              backgroundColor:HexColor('#855EA9'),

                            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                            onPressed: (){

                              updateValidator();
                            },
                            child: Text('Update',style: textTheme.bodyLarge?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: lightColorScheme!.onPrimary)),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
