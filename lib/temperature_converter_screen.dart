import 'package:flutter/material.dart';

void main() => runApp(const TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _fromUnit = 'Celsius', _toUnit = 'Fahrenheit';
  double? _result;
  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  void _convertTemperature() {
    double? input = double.tryParse(_controller.text);
    if (input == null) return setState(() => _result = null);

    Map<String, Function(double)> conversionMap = {
      'Celsius->Fahrenheit': (c) => (c * 9 / 5) + 32,
      'Celsius->Kelvin': (c) => c + 273.15,
      'Fahrenheit->Celsius': (f) => (f - 32) * 5 / 9,
      'Fahrenheit->Kelvin': (f) => (f - 32) * 5 / 9 + 273.15,
      'Kelvin->Celsius': (k) => k - 273.15,
      'Kelvin->Fahrenheit': (k) => (k - 273.15) * 9 / 5 + 32,
    };

    String key = '$_fromUnit->$_toUnit';
    setState(() => _result = _fromUnit == _toUnit ? input : conversionMap[key]?.call(input));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,title: const Text('Temperature Converter',style: TextStyle(color: Colors.white),), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter temperature', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDropdown(_fromUnit, (value) => setState(() => _fromUnit = value ?? 'Celsius')),
                const Icon(Icons.swap_horiz),
                _buildDropdown(_toUnit, (value) => setState(() => _toUnit = value ?? 'Fahrenheit')),
              ],
            ),
            const SizedBox(height: 18),
            ElevatedButton(onPressed: _convertTemperature, style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue) ,child:  Text('Convert',style: TextStyle(color: Colors.white),)),
            const SizedBox(height: 16),
            Text(
              _result == null ? 'Result will be shown here' : 'Result: ${_result!.toStringAsFixed(2)} $_toUnit',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: _units.map((unit) => DropdownMenuItem(value: unit, child: Text(unit))).toList(),
    );
  }
}
