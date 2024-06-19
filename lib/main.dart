import 'package:flutter/material.dart'; // Import for building the user interface

void main() {
  runApp(FarmersRevenueEvaluationApp()); // Start the app with the main widget
}

class FarmersRevenueEvaluationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmers Revenue Evaluation',
      theme: ThemeData(
        primarySwatch: Colors.green, // Sets the app's primary color theme
      ),
      initialRoute: '/', // Defines the initial route (login screen)
      routes: {
        '/': (context) => LoginPage(),
        '/expense': (context) => PlantationExpensePage(),
        '/revenue': (context) => RevenuePage(),
        '/result': (context) => ResultPage(),
        '/statistics': (context) => StatisticsPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'), // Title for login screen
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          // Form widget for handling user input and validation
          key: _formKey,
          child: Column(
            children: [
              Container( // Container to hold the image
                child: Image.asset(
                  'assets/login.png',
                  height: 100.0, // image height
                ),
              ),
              TextFormField(
                // Text field for username
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username (user)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                // Text field for password (hidden)
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password (pass)'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), // Spacing between elements
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    if (username == 'user' && password == 'pass') {
                      // Navigate to PlantationExpensePage
                      Navigator.pushNamed(context, '/expense');
                    } else {
                      // Show an error message for invalid credentials
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid username or password'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
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
        backgroundColor: Colors.blue,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.bar_chart_outlined), // Statistics icon
                onPressed: () {
                  Navigator.pushNamed(context, '/statistics');
                },
              ),
            ],
          ),
        ],
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
        backgroundColor: Colors.blue,
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

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final year = arguments['year'];
    final expense = double.parse(arguments['expense']);
    final revenue = double.parse(arguments['revenue']);
    final profitOrLoss = revenue - expense;
    final profitOrLossPercent = (profitOrLoss / expense) * 100;

    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container( // Container to hold the image
                child: Image.asset(
                  'assets/analysis.jpg',
                  height: 100.0, // image height
                ),
              ),
            Text(
              'Year: $year',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Expense: Ksh.${expense.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Revenue: Ksh.${revenue.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              profitOrLoss >= 0
                  ? 'Profit: Ksh.${profitOrLoss.toStringAsFixed(2)} (${profitOrLossPercent.toStringAsFixed(2)}%)'
                  : 'Loss: Ksh.${(-profitOrLoss).toStringAsFixed(2)} (${(-profitOrLossPercent).toStringAsFixed(2)}%)',
              style: TextStyle(
                  fontSize: 20,
                  color: profitOrLoss >= 0 ? Colors.green : Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/statistics', arguments: {
                  'year': year,
                  'expense': expense,
                  'revenue': revenue,
                });
              },
              child: Text('View Statistics'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final newEntry = {
      'year': arguments['year'] ?? '',
      'revenue': arguments['revenue'] ?? 0.0,
      'expense': arguments['expense'] ?? 0.0,
    };

    final data = [
      {'year': '2021', 'revenue': 120000.0, 'expense': 100000.0},
      {'year': '2022', 'revenue': 150000.0, 'expense': 110000.0},
      {'year': '2023', 'revenue': 170000.0, 'expense': 130000.0},
      if (newEntry['year'] != '' && newEntry['revenue'] != 0.0 && newEntry['expense'] != 0.0) newEntry,
    ];

    return Scaffold(
      endDrawer: Container(
      width: MediaQuery.of(context).size.width * 0.5, // Set desired width (50%)
      child: const MyDrawer(), // Drawer content widget
      ),
      appBar: AppBar(
        title: Text('Statistics'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: data.map((entry) {
            final year = entry['year'];
            final revenue = entry['revenue']as double;
            final expense = entry['expense']as double;
            final profitOrLoss = revenue - expense;
            final profitOrLossPercent = (expense != 0) ? (profitOrLoss / expense) * 100 : 0;

            return Card(
              child: ListTile(
                title: Text('Year: $year'),
                subtitle: Text(
                  'Revenue: Ksh.${revenue}\nExpense: Ksh.${expense}\nProfit/Loss: Ksh.${profitOrLoss} (${profitOrLossPercent.toStringAsFixed(2)}%)',
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Farmers App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pushReplacementNamed(context, '/expense');
            },
          ),
          ListTile(
          leading: Icon(Icons.monetization_on_outlined), // Expense Icon
          title: Text('Expense'),
          onTap: () {
            // Navigate to the expense screen
            Navigator.pushNamed(context, '/expense');
          },
          ),
          ListTile(
            leading: Icon(Icons.money_off_outlined), // Revenue Icon
            title: Text('Revenue'),
            onTap: () {
              // Navigate to the revenue screen
              Navigator.pushNamed(context, '/revenue');
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart_outlined), // Statistics Icon
            title: Text('Statistics'),
            onTap: () {
              // Navigate to the statistics screen
              Navigator.pushNamed(context, '/statistics');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to the settings screen
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to the about screen
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      ),
    );
  }
}