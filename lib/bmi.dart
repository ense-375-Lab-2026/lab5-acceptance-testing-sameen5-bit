import 'package:flutter/material.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  // Selected height values. They are nullable to detect missing input.
  int? _selectedFeet;
  int? _selectedInches;

  // Controller for the weight input (in pounds).
  final TextEditingController _weightController = TextEditingController();

  // Calculated BMI result. When null, the result text shows a prompt instead of
  // a number.
  double? _result;

  // readable description of the BMI category corresponding to the result.
  String _classification = '';

  // Error message used to accumulate warnings when fields are missing.
  String _errorMessage = '';

  @override
  void dispose() {
    // Always dispose of controllers when the widget is removed from the tree to avoid memory leaks.
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Height inputs
              const Text(
                'Height',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Feet dropdown
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Feet',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedFeet,
                      items: List<DropdownMenuItem<int>>.generate(
                        5,
                        (index) {
                          // Feet options range from 3 to 7 inclusive
                          final int value = 3 + index;
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedFeet = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Inches dropdown
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'Inches',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedInches,
                      items: List<DropdownMenuItem<int>>.generate(
                        12,
                        (index) {
                          // Inches options range from 0 to 11 inclusive
                          return DropdownMenuItem<int>(
                            value: index,
                            child: Text(index.toString()),
                          );
                        },
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedInches = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Weight input
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight (lbs)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _calculateBMI,
                  child: const Text('Calculate'),
                ),
              ),
              const SizedBox(height: 24),
              // Display error messages if any
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage.trim(),
                  style: const TextStyle(color: Colors.redAccent),
                ),
              // Display result when there is no error and a result is present
              if (_errorMessage.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BMI Result',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _result != null
                          ? _result!.toStringAsFixed(2)
                          : 'Enter values and press Calculate',
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_result != null)
                      Text(
                        _classification,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// This method first validates that the user has provided feet, inches,
  /// and weight values. If any are missing an error message is generated and
  /// the result will not be computed. Otherwise the height is converted to
  /// metres and the weight to kilograms, the BMI is computed, and a simple
  /// classification is derived. The UI is updated via `setState`.
  void _calculateBMI() {
    String error = '';
    if (_selectedFeet == null) {
      error += 'enter feet\n';
    }
    if (_selectedInches == null) {
      error += 'enter inches\n';
    }
    if (_weightController.text.trim().isEmpty) {
      error += 'enter weight\n';
    }

    if (error.isNotEmpty) {
      setState(() {
        _errorMessage = error;
        _result = null;
        _classification = '';
      });
      return;
    }

    // Parse weight and convert height into metric units.
    final int feet = _selectedFeet!;
    final int inches = _selectedInches!;
    final double weightLbs = double.tryParse(_weightController.text.trim()) ?? 0.0;

    // Total height in inches
    final int totalInches = feet * 12 + inches;

    // Convert height to metres (2.54 cm per inch, 100 cm per metre)
    final double heightMetres = totalInches * 2.54 / 100.0;

    // Convert weight to kilograms (2.2 lbs per kg)
    final double weightKg = weightLbs / 2.2;

    // Compute BMI
    final double bmi = weightKg / (heightMetres * heightMetres);

    // Determine classification
    String classification;
    if (bmi < 18.5) {
      classification = 'Underweight';
    } else if (bmi < 25) {
      classification = 'Healthy Weight Range';
    } else if (bmi < 30) {
      classification = 'Overweight';
    } else {
      classification = 'Severely Overweight';
    }

    setState(() {
      _errorMessage = '';
      _result = bmi;
      _classification = classification;
    });
  }
}