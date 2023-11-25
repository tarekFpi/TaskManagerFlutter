import 'package:cares_task/core/features/home/model/course_response.dart';
import 'package:cares_task/core/theme/color_scheme.dart';
import 'package:cares_task/core/utils/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseDetailsScreen extends StatefulWidget {
  final Products courselist;

  const CourseDetailsScreen({super.key, required this.courselist});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'ZzaPdXTrSb8',
    flags: YoutubePlayerFlags(
      autoPlay: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        //backgroundColor:colorScheme.surface,
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Course Details",
          style: textTheme.titleMedium?.copyWith(
              color: HexColor('#855EA9'),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                liveUIColor: Colors.red,
              ),
              SizedBox(
                height: 24,
              ),
              Card(
                color: HexColor("#FAFDFC"),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "title : ${widget.courselist.title}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Description : ${widget.courselist.description}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,),
                              overflow: TextOverflow.clip,
                            ),

                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Category : ${widget.courselist.category}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: lightColorScheme.onTertiaryContainer,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            Text(
                              "Rating : ${widget.courselist.rating}",
                              style: textTheme.bodySmall?.copyWith(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),

                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Price :${widget.courselist.price}",
                                style: textTheme.bodySmall?.copyWith(
                                    color: lightColorScheme.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),


                           widget.courselist.images!.length> 1 ?
                           Column(
                             children: [

                               Card(
                                   color: HexColor("#FAFDFC"),
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Image.network(
                                       "${widget.courselist.images![0]}",
                                       width: double.infinity,
                                       height: 200,
                                       fit: BoxFit.fill,
                                     ),
                                   )),

                               SizedBox(
                                 height: 8,
                               ),
                               Card(
                                   color: HexColor("#FAFDFC"),
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Image.network(
                                       "${widget.courselist.images![1]}",
                                       width: double.infinity,
                                       height: 200,
                                       fit: BoxFit.fill,
                                     ),
                                   )),
                               SizedBox(
                                 height: 8,
                               ),
                               Card(
                                   color: HexColor("#FAFDFC"),
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Image.network(
                                       "${widget.courselist.images![1]}",
                                       width: double.infinity,
                                       height: 200,
                                       fit: BoxFit.fill,
                                     ),
                                   )),
                             ],
                           ):Card(
                               color: HexColor("#FAFDFC"),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Image.network(
                                   "${widget.courselist.images![0]}",
                                   width: double.infinity,
                                   height: 200,
                                   fit: BoxFit.fill,
                                 ),
                               )),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
