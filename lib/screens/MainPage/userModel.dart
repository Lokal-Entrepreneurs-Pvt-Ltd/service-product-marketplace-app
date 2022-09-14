class Product {
    Product({
        this.type,
        this.componentStype,
        this.widgets,
        this.dataStore,
    });

    final String? type;
    final String? componentStype;
    final List<Widget>? widgets;
    final DataStore? dataStore;
}

class DataStore {
    DataStore({
        this.title,
        this.searchBar,
        this.slider,
        this.isp,
        this.financing,
        this.ev,
    });

    final Title? title;
    final SearchBar? searchBar;
    final Slider? slider;
    final Ev? isp;
    final Ev? financing;
    final Ev? ev;
}

class Ev {
    Ev({
        this.id,
        this.text,
        this.widthSize,
        this.heightSize,
        this.iWidth,
        this.imgVal,
    });

    final String? id;
    final String? text;
    final String? widthSize;
    final String? heightSize;
    final String? iWidth;
    final String? imgVal;
}

class SearchBar {
    SearchBar({
        this.id,
        this.text,
        this.label,
        this.leftElement,
    });

    final String? id;
    final String? text;
    final String? label;
    final LeftElement? leftElement;
}

class LeftElement {
    LeftElement({
        this.type,
        this.iconData,
    });

    final String? type;
    final IconData? iconData;
}

class IconData {
    IconData({
        this.iconVal,
        this.iconColor,
        this.shape,
    });

    final String? iconVal;
    final String? iconColor;
    final String? shape;
}

class Slider {
    Slider({
        this.id,
        this.heightSize,
        this.slide,
    });

    final String? id;
    final String? heightSize;
    final List<Slide>? slide;
}

class Slide {
    Slide({
        this.image,
        this.text,
    });

    final String? image;
    final String? text;
}

class Title {
    Title({
        this.id,
        this.text,
        this.color,
        this.size,
    });

    final String? id;
    final String? text;
    final String? color;
    final String? size;
}

class Widget {
    Widget({
        this.id,
        this.uiType,
    });

    final String? id;
    final String? uiType;
}
