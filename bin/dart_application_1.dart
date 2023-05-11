import 'dart:convert';
import 'dart:io';

class CoinDesk {
  CoinDesk({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });
  late final Time time;
  late final String disclaimer;
  late final String chartName;
  late final Bpi bpi;
  
  CoinDesk.fromJson(Map<String, dynamic> json){
    time = Time.fromJson(json['time']);
    disclaimer = json['disclaimer'];
    chartName = json['chartName'];
    bpi = Bpi.fromJson(json['bpi']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['time'] = time.toJson();
    data['disclaimer'] = disclaimer;
    data['chartName'] = chartName;
    data['bpi'] = bpi.toJson();
    return data;
  }
}

class Time {
  Time({
    required this.updated,
    required this.updatedISO,
    required this.updateduk,
  });
  late final String updated;
  late final String updatedISO;
  late final String updateduk;
  
  Time.fromJson(Map<String, dynamic> json){
    updated = json['updated'];
    updatedISO = json['updatedISO'];
    updateduk = json['updateduk'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['updated'] = updated;
    data['updatedISO'] = updatedISO;
    data['updateduk'] = updateduk;
    return data;
  }
}

class Bpi {
  Bpi({
    required this.usd,
    required this.gbp,
    required this.eur,
  });
  late final USD usd;
  late final GBP gbp;
  late final EUR eur;
  
  Bpi.fromJson(Map<String, dynamic> json){
    usd = USD.fromJson(json['USD']);
    gbp = GBP.fromJson(json['GBP']);
    eur = EUR.fromJson(json['EUR']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['USD'] = usd.toJson();
    data['GBP'] = gbp.toJson();
    data['EUR'] = eur.toJson();
    return data;
  }
}

class USD {
  USD({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;
  
  USD.fromJson(Map<String, dynamic> json){
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}

class GBP {
  GBP({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;
  
  GBP.fromJson(Map<String, dynamic> json){
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}

class EUR {
  EUR({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;
  
  EUR.fromJson(Map<String, dynamic> json){
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['symbol'] = symbol;
    data['rate'] = rate;
    data['description'] = description;
    data['rate_float'] = rateFloat;
    return data;
  }
}

class GetFactCat {
  GetFactCat({
    required this.fact,
    required this.length,
  });
  late final String fact;
  late final int length;
  
  GetFactCat.fromJson(Map<String, dynamic> json){
    fact = json['fact'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fact'] = fact;
    data['length'] = length;
    return data;
  }
}
class Activity {
  Activity({
    required this.toDo,
    required this.type,
    required this.link,
  });
  late final String toDo;
  late final String type;
  late final String link;
  
  Activity.fromJson(Map<String, dynamic> json){
    toDo = json['activity'];
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['activity'] = toDo;
    data['type'] = type;
    data['link'] = link;
    return data;
  }
}



HttpClient client = HttpClient();
const String urlBitcoin = "https://api.coindesk.com/v1/bpi/currentprice.json";
const String urlFactCat = "https://catfact.ninja/fact";
const String urlToDo = "https://www.boredapi.com/api/activity";

Future<void> getBitcoin() async {
  final url = Uri.parse(urlBitcoin);
  final request = await client.getUrl(url);
  final response = await request.close();
  final responseString = await response.transform(utf8.decoder).join();

  final CoinDesk coinDesk = CoinDesk.fromJson(jsonDecode(responseString)!);
  final rateValueUsd = (coinDesk.bpi.usd.rate.replaceAll(",", "").replaceAll(".", ","));
  final formattedRateUsd = rateValueUsd;
  final rateValueGbp = (coinDesk.bpi.gbp.rate.replaceAll(",", "").replaceAll(".", ","));
  final formattedRateGbp = rateValueGbp;
  final rateValueEur = (coinDesk.bpi.eur.rate.replaceAll(",", "").replaceAll(".", ","));
  final formattedRateEur = rateValueEur;
  print('On ${coinDesk.time.updated} ${coinDesk.chartName} exchange rate:');
  print('  ${coinDesk.bpi.usd.description}');
  print('     ${coinDesk.bpi.usd.code}: $formattedRateUsd \$\n');
  print('  ${coinDesk.bpi.gbp.description}');
  print('     ${coinDesk.bpi.gbp.code}: $formattedRateGbp \£\n');
  print('  ${coinDesk.bpi.eur.description}');
  print('     ${coinDesk.bpi.eur.code}: $formattedRateEur \€\n');
  print('0. Enter to exit to the previous menu\n');
  await previous();
}

Future<void> getFactCat() async {
  final url = Uri.parse(urlFactCat);
  final request = await client.getUrl(url);
  final response = await request.close();
  final responseString = await response.transform(utf8.decoder).join();

  final GetFactCat getFactCat = GetFactCat.fromJson(jsonDecode(responseString)!);
  print("Did you know this fact about cats?:\n");
  print("${getFactCat.fact}\n");
  print("0. Enter to exit to the previous menu\n");

  await previous();
}

Future<void> getToDo() async {
  final url = Uri.parse(urlToDo);
  final request = await client.getUrl(url);
  final response = await request.close();
  final responseString = await response.transform(utf8.decoder).join();

  final Activity activity = Activity.fromJson(jsonDecode(responseString)!);

  print('The type of activity offered to you:');
  print('   ${activity.type}');
  print('');
  print('What we advise you to do today:');
  print('   ${activity.toDo}');
  print('');
  print('Useful links for you:');
  print('   ${activity.link.isNotEmpty ? activity.link : "Unfortunately, there are no links"}');
  print('');
  print('0. Enter to exit to the previous menu');
  print('');

  await previous();
}

Future<void> start() async {
  print('Please enter a number between 1 and 3:');
  print('1. Display current Bitcoin price.');
  print('2. Display a random cat fact.');
  print('3. Display a random activity to do.');
  print('0. Enter to exit to the program\n');

  int option = int.parse(stdin.readLineSync()!);

  switch (option) {
    case 1:
      await getBitcoin();
      break;
    case 2:
      await getFactCat();
      break;
    case 3:
      await getToDo();
      break;
    case 0:
      await exitProgram();
      break;
    default:
      print('Invalid option selected.');
      break;
  }
}

Future<void> previous() async {
  int option = int.parse(stdin.readLineSync()!);

  switch (option) {
    case 0:
      await start();
      break;
    default:
      print("Invalid option selected.");
      break;
  }
}

Future<void> exitProgram() async {
  print("Thank you for using this program!");
  exit(0);
}

void main() {
  start();
}