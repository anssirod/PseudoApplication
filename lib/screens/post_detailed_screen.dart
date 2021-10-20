import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pseudo_application/main.dart';
import 'package:pseudo_application/models/comment.dart';
import 'package:pseudo_application/stores/user_store.dart';

class PostDetailedScreen extends StatelessWidget {
  final int postId;
  final String postTitle;
  final String postBody;

  const PostDetailedScreen({
    Key? key,
    required this.postId,
    required this.postTitle,
    required this.postBody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.message),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyAlertDialog(postId: postId);
              },
            );
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  postTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(postBody),
                const SizedBox(height: 30),
                FutureBuilder<List<Comment>>(
                  future: getIt<UserStore>().getListOfCommentsForPost(postId),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<List<Comment>> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        return Observer(
                          builder: (context) {
                            return ListView.builder(
                              physics: const ScrollPhysics(),
                              itemCount:
                                  getIt<UserStore>().listOfComments.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          getIt<UserStore>()
                                              .listOfComments[index]
                                              .name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          getIt<UserStore>()
                                              .listOfComments[index]
                                              .email,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          getIt<UserStore>()
                                              .listOfComments[index]
                                              .body,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('Empty data'));
                      }
                    } else {
                      return Center(
                        child: Text('State: ${snapshot.connectionState}'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyAlertDialog extends StatefulWidget {
  final int postId;

  const MyAlertDialog({Key? key, required this.postId}) : super(key: key);

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _textTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: 'Name'),
                  controller: _nameTextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailTextEditingController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _textTextEditingController,
                  decoration: const InputDecoration(hintText: 'Comment'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      getIt<UserStore>().createCommentForPost(
                        postId: widget.postId,
                        name: _nameTextEditingController.text,
                        text: _textTextEditingController.text,
                        email: _emailTextEditingController.text,
                      );
                      Navigator.of(context, rootNavigator: true).pop();
                      _nameTextEditingController.clear();
                      _textTextEditingController.clear();
                      _emailTextEditingController.clear();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
