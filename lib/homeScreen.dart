import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:serverlesslogin/subscription.dart';

import 'authService.dart';

class HomeScreen extends StatefulWidget {
  final AuthService authService;

  HomeScreen({required this.authService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subscriptionTypeController = TextEditingController();
  final _websiteNameController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  void _addSubscription() {
    if (_formKey.currentState!.validate()) {
      final newSubscription = Subscription(
        name: _nameController.text,
        subscriptionType: _subscriptionTypeController.text,
        websiteName: _websiteNameController.text,
        startDate: _startDate,
        endDate: _endDate,
      );
      widget.authService.saveSubscription(newSubscription);
      setState(() {
        _nameController.clear();
        _subscriptionTypeController.clear();
        _websiteNameController.clear();
        _startDate = DateTime.now();
        _endDate = DateTime.now();
      });
    }
  }

  void _editSubscription(Subscription subscription, int index) {
    final editNameController = TextEditingController(text: subscription.name);
    final editSubscriptionTypeController =
        TextEditingController(text: subscription.subscriptionType);
    final editWebsiteNameController =
        TextEditingController(text: subscription.websiteName);
    DateTime editStartDate = subscription.startDate;
    DateTime editEndDate = subscription.endDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Subscription'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: editNameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: editSubscriptionTypeController,
                decoration:
                    const InputDecoration(labelText: 'Subscription Type'),
              ),
              TextFormField(
                controller: editWebsiteNameController,
                decoration: const InputDecoration(labelText: 'Website Name'),
              ),
              ListTile(
                title: Text(
                    'Start Date: ${DateFormat.yMd().format(editStartDate)}'),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: editStartDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != editStartDate) {
                    setState(() {
                      editStartDate = picked;
                    });
                  }
                },
              ),
              ListTile(
                title:
                    Text('End Date: ${DateFormat.yMd().format(editEndDate)}'),
                trailing: const Icon(Icons.keyboard_arrow_down),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: editEndDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != editEndDate) {
                    setState(() {
                      editEndDate = picked;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final editedSubscription = Subscription(
                  name: editNameController.text,
                  subscriptionType: editSubscriptionTypeController.text,
                  websiteName: editWebsiteNameController.text,
                  startDate: editStartDate,
                  endDate: editEndDate,
                );
                widget.authService
                    .updateSubscription(editedSubscription, index);
                setState(() {});
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final subscriptions = widget.authService.getSubscriptions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Subscriptions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name' : null,
                  ),
                  TextFormField(
                    controller: _subscriptionTypeController,
                    decoration:
                        const InputDecoration(labelText: 'Subscription Type'),
                    validator: (value) => value!.isEmpty
                        ? 'Please enter a subscription type'
                        : null,
                  ),
                  TextFormField(
                    controller: _websiteNameController,
                    decoration:
                        const InputDecoration(labelText: 'Website Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a website name' : null,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                              'Start Date: ${DateFormat.yMd().format(_startDate)}'),
                          trailing: const Icon(Icons.keyboard_arrow_down),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _startDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != _startDate) {
                              setState(() {
                                _startDate = picked;
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                              'End Date: ${DateFormat.yMd().format(_endDate)}'),
                          trailing: const Icon(Icons.keyboard_arrow_down),
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _endDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (picked != null && picked != _endDate) {
                              setState(() {
                                _endDate = picked;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: _addSubscription,
                      child: const Text('Add Subscription')),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: subscriptions.length,
                itemBuilder: (context, index) {
                  final subscription = subscriptions[index];
                  return Dismissible(
                    key: Key(subscription.name + subscription.websiteName),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.edit, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        _editSubscription(subscription, index);
                        return false;
                      } else {
                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Subscription'),
                            content: const Text(
                                'Are you sure you want to delete this subscription?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    // onDismissed: (direction) {
                    //   if (direction == DismissDirection.startToEnd) {
                    //     widget.authService.deleteSubscription(index);
                    //     setState(() {});
                    //   }
                    // },

                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        setState(() {
                          widget.authService.deleteSubscription(index);
                        });
                      }
                    },

                    child: ListTile(
                      title: Text(subscription.name),
                      subtitle: Text(
                          '${subscription.subscriptionType} - ${subscription.websiteName}'),
                      trailing: Text(
                          '${DateFormat.yMd().format(subscription.startDate)} - ${DateFormat.yMd().format(subscription.endDate)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
