part of '../pages/pokemon_detail_page.dart';

Widget buildPokemonImage(Map<String, dynamic> sprites) {
  return sprites['other']['official-artwork']['front_default'] != null 
    ? SizedBox(
      height: 170,
      child: Image.network(sprites['other']['official-artwork']['front_default'])
    )
    : Container(
      alignment: Alignment.center,
      height: 40,
      padding: const EdgeInsets.only(top: 20.0),
      child: const Text('Image Not Found', style: TextStyle(fontSize: 10, color: Colors.white))
    );
}

Widget buildSectionName(String name) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, right: 20.0, bottom: 10.0, left: 20.0),
    child: Text(name.toUpperCase(),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), 
    )
  );
}

Widget buildSectionWTH(int height, int weight, List<dynamic> types) {
  String heightMetres = convertUnitTenToUnitThousand(height);
  String weightKilograms = convertUnitTenToUnitThousand(weight);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        itemSectionWTH(
          superior: Text('${weightKilograms}kg', 
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          ),
          inferior: const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('WEIGHT', style: TextStyle(fontSize: 12))
          )
        ),
        const Padding(
          padding: EdgeInsets.only(right: 8.0, bottom: 14.0, left: 8.0),
          child: SizedBox(height: 20, child: VerticalDivider(color: Colors.black))
        ),
        rowPokemonType(types),
        const Padding(
          padding: EdgeInsets.only(right: 8.0, bottom: 14.0, left: 8.0),
          child: SizedBox(height: 20, child: VerticalDivider(color: Colors.black))
        ),
        itemSectionWTH(
          superior: Text('${heightMetres}m', 
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          ),
          inferior: const Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: Text('HEIGHT', style: TextStyle(fontSize: 12))
          )
        )
      ],
    ),
  );
}

Widget itemSectionWTH({required Widget superior, required Widget inferior}){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    child: Column(children: [
      superior,
      inferior
    ])
  );
}

Widget rowPokemonType(List<dynamic> types){
  return Row(
    children: List.generate(types.length, (index) {
      return itemSectionWTH(
        superior: Image.asset(UIConstants.getPokemonTypeImage(types[index]['type']['name']), width: 28),
        inferior: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text('${types[index]['type']['name']}'.toUpperCase(), style: const TextStyle(fontSize: 12))
        )
      );
    })
  );
}

Widget buildSectionBaseStats(List<dynamic> stats) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0, bottom: 10.0, left: 16.0),
    child: Column(
      children: List.generate(stats.length, (index) => Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${stats[index]['stat']['name']}'.toUpperCase()),
              Text('${stats[index]['base_stat']}')
            ]
          )
        )
      )
    )
  );
}

Widget buildSectionAbilities(List<dynamic> abilities) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(right: 16.0, bottom: 10.0, left: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(abilities.length, (index) => Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text('${abilities[index]['ability']['name']}'.toUpperCase())
      ))
    )
  );
}

Widget buildSectionDescription(Map<String, dynamic> species){
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text('${species['genus']}'.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Text(species['flavor_text'], style: const TextStyle(fontSize: 14))
      ]
    )
  );
}

Widget titleHeader(String title, {Alignment alignment = Alignment.centerLeft}) {
  return Container(
    alignment: alignment,
    padding: const EdgeInsets.only(top: 15.0, right: 16, left: 16.0, bottom: 5.0),
    child: Text(title, 
      style: const TextStyle(fontWeight: FontWeight.bold)
    )
  );
}