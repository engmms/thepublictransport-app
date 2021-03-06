import 'package:flutter/material.dart';
import 'package:thepublictransport_app/ui/base/tptfabscaffold.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:desiredrive_api_flutter/service/rmv/rmv_query_request.dart';
import 'package:thepublictransport_app/pages/nearby/nearby_search_result.dart';
import 'package:thepublictransport_app/ui/colors/color_theme_engine.dart';

class NearbySearchPage extends StatefulWidget {
  @override
  _NearbySearchPage createState() => _NearbySearchPage();
}

class _NearbySearchPage extends State<NearbySearchPage> {

  Widget build(BuildContext context) {
    return new TPTScaffold(
      title: "Suche in der Nähe",
      body: new Container(
          child: new Container(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: ColorThemeEngine.decideBorderSide()
              ),
              color: ColorThemeEngine.cardColor,
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      autocorrect: true,
                      style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: ColorThemeEngine.subtitleColor,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(24.0)),
                            borderSide: ColorThemeEngine.decideBorderSide()

                        ),
                        labelText: "Suche...",
                        labelStyle: new TextStyle(
                            color: ColorThemeEngine.textColor
                        ),
                      )
                  ),
                  suggestionsCallback: (pattern) async {
                    return await RMVQueryRequest.getStations(pattern).catchError((e) {
                      return RMVQueryRequest.failure();
                    });
                  },
                  itemBuilder: (context, suggestion) {
                    return Container(
                      color: ColorThemeEngine.backgroundColor,
                      child: ListTile(
                        leading: Icon(Icons.place, color: ColorThemeEngine.iconColor),
                        title: Text(
                          suggestion.name,
                          style: new TextStyle(
                              color: ColorThemeEngine.textColor
                          ),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    if(suggestion.name != "Keine Ergebnisse") {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NearbySearchResultPage(suggestion)));
                    }
                  },
                ),
              ),
            ),
          )
      ),
    );
  }
}