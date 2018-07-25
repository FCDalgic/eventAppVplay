import QtQuick 2.0
/// Hakkımızda sayfasına ait footer, dummy olarak eklenmiştir stackyapısını bozmamak adına. Görünütrde hiçbirşey olmayacaktır.
Rectangle
{
    id : aboutFooter;
    anchors.fill: parent;
    height: appWindow.height * 0.1
    visible: false;

    property bool show: false;
    function showFooter() {return aboutFooter.show; }
    function whoAmI() {return "FooterAbout";}
}
