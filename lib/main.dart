import 'package:flutter/material.dart';

void main() {
  runApp(FarmersRevenueEvaluationApp());
}

class FarmersRevenueEvaluationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmers Revenue Evaluation',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        //'/login': (context) => LoginPage(),
        '/': (context) => PlantationExpensePage(),
        '/revenue': (context) => RevenuePage(),
        //'/result': (context) => ResultPage(),
        //'/statistics': (context) => StatisticsPage(),
      },
    );
  }
}

class PlantationExpensePage extends StatefulWidget {
  @override
  _PlantationExpensePageState createState() => _PlantationExpensePageState();
}

class _PlantationExpensePageState extends State<PlantationExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _expenseController = TextEditingController();

  @override
  void dispose() {
    _yearController.dispose();
    _expenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Plantation Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expenseController,
                decoration: InputDecoration(labelText: 'Expense'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the expense amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.pushNamed(context, '/revenue', arguments: {
                      'year': _yearController.text,
                      'expense': _expenseController.text,
                    });
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RevenuePage extends StatefulWidget {
  @override
  _RevenuePageState createState() => _RevenuePageState();
}

class _RevenuePageState extends State<RevenuePage> {
  final _formKey = GlobalKey<FormState>();
  final _revenueController = TextEditingController();

  @override
  void dispose() {
    _revenueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Harvest Revenue'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _revenueController,
                decoration: InputDecoration(labelText: 'Revenue'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the revenue amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.pushNamed(context, '/result', arguments: {
                      'year': arguments?['year'],
                      'expense': arguments?['expense'],
                      'revenue': _revenueController.text,
                    });
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


