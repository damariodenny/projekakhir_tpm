import 'package:flutter/material.dart';
import 'fruitmodel.dart';

class DetailScreen extends StatefulWidget {
  final Welcome fruit;

  DetailScreen({required this.fruit});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String currency = 'IDR';
  double exchangeRate = 1.0;
  String price = '';

  @override
  void initState() {
    super.initState();
    setPrice();
  }

  void setPrice() {
    if (widget.fruit.nutritions.calories < 50) {
      price = (10000 * exchangeRate).toStringAsFixed(2);
    } else {
      price = (15000 * exchangeRate).toStringAsFixed(2);
    }
  }

  void convertCurrency(String selectedCurrency) {
    setState(() {
      currency = selectedCurrency;
      switch (selectedCurrency) {
        case 'USD':
          exchangeRate = 0.00007; // Contoh nilai tukar
          break;
        case 'EUR':
          exchangeRate = 0.00006; // Contoh nilai tukar
          break;
        case 'GBP':
          exchangeRate = 0.00005; // Contoh nilai tukar
          break;
        default:
          exchangeRate = 1.0;
      }
      setPrice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fruit.name),
        actions: <Widget>[
          DropdownButton<String>(
            value: currency,
            icon: Icon(Icons.money),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String? newValue) {
              convertCurrency(newValue!);
            },
            items: <String>['IDR', 'USD', 'EUR', 'GBP']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.fruit.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Family: ${widget.fruit.family}'),
            Text('Order: ${widget.fruit.order}'),
            Text('Genus: ${widget.fruit.genus}'),
            SizedBox(height: 16),
            Text(
              'Nutritions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Calories: ${widget.fruit.nutritions.calories}'),
            Text('Fat: ${widget.fruit.nutritions.fat}g'),
            Text('Sugar: ${widget.fruit.nutritions.sugar}g'),
            Text('Carbohydrates: ${widget.fruit.nutritions.carbohydrates}g'),
            Text('Protein: ${widget.fruit.nutritions.protein}g'),
            SizedBox(height: 16),
            Text(
              'Price: $price $currency',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
