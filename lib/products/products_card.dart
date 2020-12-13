import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    home: ProductPage(),
  ));
}

class ProductPage extends StatelessWidget {
  ProductPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Passer votre commande',
            style: GoogleFonts.indieFlower(
              textStyle: TextStyle(
                fontSize: 24,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        backgroundColor: Colors.green[500],
        ),
        body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: <Widget>[
          ProductBox(
            name: "Batavia",
            description: "Rouge ou verte, on l’aime en salade, bien sûr ! Avec un trait "
                "d'huile d'olive ou de noix, garnie de croûtons ou de pignons croquants, "
                "la feuille de chêne fait merveille dans une salade composée. Elle forme "
                "aussi un lit idéal pour les poissons pochés ou grillés ou des Saint-Jacques "
                "simplement snackées.",
            price: 150,
            image: "feuille_de_chene.jpg"
          ),
          ProductBox(
              name: "Iceberg",
              description: "L’iceberg est une grosse salade ronde en forme de chou. "
                  "Craquante à souhait et rafraîchissante, elle a la particularité de "
                  "se conserver beaucoup mieux que les autres variétés de salades. Crue "
                  "en salade ou en garniture, ses feuilles fermes peuvent être servies "
                  "cuites avec des lardons, un chèvre chaud, ou même cuisinées au wok.",
              price: 150,
              image: "iceberg.jpg"
          ),
          ProductBox(
              name: "Laitue",
              description: "Savez-vous que les feuilles de laitue n’ont pas toutes "
                  "les mêmes apports énergétiques ? En effet, les feuilles externes "
                  "foncées contiennent plus de provitamine A que les feuilles du cœur. "
                  "Une bonne raison pour la consommer dans sa totalité. Et pour lui "
                  "permettre de se révéler au mieux, jouez la simplicité dans les assaisonnements.",
              price: 150,
              image: "laitue.jpg"
          ),
          ProductBox(
              name: "Salade de blé",
              description: "On y trouve de tout et en grande quantité : "
                  "des carotènes antioxydants, de la vitamine C et E, des folates, "
                  "du fer et d’autres sels minéraux, des fibres et même des oméga 3. "
                  "On chouchoute cette salade fragile en l’assaisonnant d’huiles "
                  "douces (huile d’olive ou de pépins de raisin) et d'un peu de "
                  "vinaigre (balsamique ou de xérès).",
              price: 150,
              image: "salade_de_ble.jpg"
          ),
        ],
      )
    );
  }
}
class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.name, this.description, this.price, this.image})
      : super(key: key);

  final String name;
  final String description;
  final int price;
  final String image;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      height: 225,

      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
                "lib/images/" + image,
                width: 140),
            Expanded(
                child: Container(
                  padding: EdgeInsets.all(1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        this.name,
                        style: TextStyle(
                          height: 1,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold)),
                      Text(
                          this.description,
                          style: TextStyle(
                            height: 1,
                            letterSpacing: 2,
                            //fontWeight: FontWeight.,
                          ),
                      ),
                      Text(
                        "Prix en XPF : " + this.price.toString(),
                        style: TextStyle(
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
