import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import "../../items"

Rectangle {
    id: stackedFooterContainer;
    Layout.fillWidth: true
    height: appWindow.height * 0.1

    visible:  footerNavigation.visible;

    color: "white";
    StackView
    {
        id: footerNavigation;
        initialItem: footerMain;
        anchors.fill: parent;

//        pushEnter: Transition {
//            PropertyAnimation {
//                property: "opacity"
//                from: 0
//                to:1
//                duration: 200
//            }
//        }
//        pushExit: Transition {
//            PropertyAnimation {
//                property: "opacity"
//                from: 1
//                to:0
//                duration: 200
//            }
//        }

        focus: true;
        Keys.onBackPressed:
        {
            console.log("keys backpressed on stackedFooter");
            appWindow.globalBackPressed();
        }

        // Footer görünürlüğünü içinde yer alan child elementten almalıdır ki görünürlük dinamik ve otomatik olarak değişebilmelidir.
        // Aksi taktirde manuel olarak kontrol etmek zorunda kalacağız.
        onCurrentItemChanged:
        {
            var showFooter = currentItem.showFooter();
//            console.log("Current item changed. It's visiblity" + showFooter + " - " +  currentItem.whoAmI());
            footerNavigation.visible = showFooter;
            stackedFooterContainer.visible = showFooter;
        }

        /*
         *  Functions
         *  popOneFooter
         *  pushOneFooter
         *  pushNextFooter
         *  findFooter
         *  pushFooterByfooterNumber
         *  goUpTo
         *  goDownTo
         *  goToFooter
        */
        // go one level back in stack
        function popOneFooter() {
            if(footerNavigation.depth == 1) {
                return
            }

            // check if target footer already is on the stack
            var targetIsUninitialized = false
            if(!footerNavigation.get(footerNavigation.depth-2)) {
                targetIsUninitialized = true
            }
            var footer = pop()
            if(targetIsUninitialized) {
                footerNavigation.currentItem.init()
            }

        } // popOneFooter

        function pushOneFooter(pageComponent) {
            var footer = push(pageComponent)
        }

        function pushNextFooter() {
            switch(footerNavigation.depth) {
            case 1:
                pushOneFooter(footerMain)
                break;
            case 2:
                pushOneFooter(footerSelectedCategory)
                break;
            case 3:
                pushOneFooter(footerSelectedEvent)
                break;
            case 4:
                pushOneFooter(footerAbout);
                break;
            case 5:
                pushOneFooter(footerAuth);
                break;
            case 6:
                pushOneFooter(footerSignin);
                break;
            case 7:
                pushOneFooter(footerResetRequest);
                break;
            case 8:
                pushOneFooter(footerUpdatePass);
                break;
            case 9:
                pushOneFooter(footerAboutSe);
                break;
            case 10:
                pushOneFooter(footerTerms);
                break;
            case 11:
                pushOneFooter(footerFood);
                break;
            case 12:
                pushOneFooter(footerAboutCont);
                break;
            case 13:
                pushOneFooter(footerSelectedPlace);
                break;
            default:
                break;
                // nothing - 4 is max
            }
        } // pushNextFooter

        function findFooter(pageName) {
            var targetPage = find(function(item) {
                return item.name == pageName;
            })
            if(targetPage) {
                return targetPage.StackView.index
            } else {
                console.log("Page not found in StackView: "+pageName)
                return -1
            }
        }

        function pushFooterByfooterNumber(footerNumber)
        {
            var footer;
            switch(footerNumber) {
            case 1:
                footer = footerMain;
                break;
            case 2:
                footer = footerSelectedCategory
                break;
            case 3:
                footer = footerSelectedEvent
                break;
            case 4:
                footer = footerAbout;
                break;
            case 5:
                footer = footerAuth;
                break;
            case 6:
                footer = footerSignin;
                break;
            case 7:
                footer = footerResetRequest;
                break;
            case 8:
                footer = footerUpdatePass;
                break;
            case 9:
                footer = footerAboutSe;
                break;
            case 10:
                footer = footerTerms;
                break;
            case 11:
                footer= footerFood;
                break;
            case 12:
                footer = footerAboutCont;
                break;
            case 13:
                footer = footerSelectedPlace;
                break;
            default:
                // nothing
                return
            }

            pushOneFooter(footer);
        }

        function goUpTo(footerNumber) {
            var count = footerNumber-footerNavigation.depth
            var pages = new Array (count)
            for(var i = 0; i < count; i++) {
                var thefooterNumber = footerNavigation.depth+i+1
                switch(thefooterNumber) {
                case 1:
                    pages[i] = footerMain
                    break;
                case 2:
                    pages[i] = footerSelectedCategory
                    break;
                case 3:
                    pages[i] = footerSelectedEvent
                    break;
                case 4:
                    pages[i] = footerAbout;
                    break;
                case 5:
                    pages[i] = footerAuth;
                    break;
                case 6:
                    pages[i] = footerSignin;
                    break;
                case 7:
                    pages[i] = footerResetRequest;
                    break;
                case 8:
                    pages[i] = footerUpdatePass;
                    break;
                case 9:
                    pages[i] = footerAboutSe;
                    break;
                case 10:
                    pages[i] = footerTerms;
                    break;
                case 11:
                    pages[i] = footerFood;
                    break;
                case 12:
                    pages[i] = footerAboutCont;
                    break;
                case 13:
                    pages[i] = footerSelectedPlace;
                    break;
                default:
                    // nothing
                    return
                }
            }
            var footer = push(pages)
            //            footer.init()
        } // goUpTo

        function goDownTo(footerNumber) {
            // check if cleanup must be done for popped pages
            var count = footerNavigation.depth-footerNumber
            for(var i = 0; i < count; i++) {
                if(footerNavigation.get(footerNavigation.depth-i-1)) {
                    //                    footerNavigation.get(footerNavigation.depth-i-1).cleanup()
                }
            }
            // pop all pages until targetPage will be on top
            // check if target footer already is on the stack
            var targetIsUninitialized = false
            if(!footerNavigation.get(footerNumber-1)) {
                targetIsUninitialized = true
            }
            // don't forget to set StackView.ForceLoad
            // otherwise if get() is null and get(null) means jump to root
            pop(footerNavigation.get(footerNumber-1, StackView.ForceLoad))
            if(targetIsUninitialized) {
                footerNavigation.get(footerNumber-1).init()
            }
        } // goDownTo

        function goToPage(footerNumber) {
            if(footerNumber == footerNavigation.depth) {
                // it's the current footer
                return
            }
            if(footerNumber > footerNavigation.depth) {
                goUpTo(footerNumber)
                return
            }
            goDownTo(footerNumber)
        } // goToPage
    }

    /**** Stackview altında kullanılacak olan componentler*/
    Component{  id: footerMain;  FooterMain {visible: true; } }
    Component { id: footerSelectedCategory; FooterSelectedCategory{ visible: false; }}
    Component { id: footerSelectedEvent; FooterSelectedEvent {visible: false;}}
    Component { id: footerAbout; FooterAbout{visible : false;}}
    Component { id: footerAuth; FooterAuthantication{visible : false;}}
    Component { id: footerSignin; FooterSignin{visible : false;}}
    Component { id: footerResetRequest; FooterSignin{visible : false;}}
    Component { id: footerUpdatePass; FooterSignin{visible : false;}}
    Component { id: footerAboutSe; FooterAboutSe{visible : false;}}
    Component { id: footerTerms; FooterTermsAndConditions{visible : false;}}
    Component { id: footerFood; FooterFoodCategory{visible : false;}}
    Component { id: footerAboutCont; FooterAbout{visible : false;}}
    Component { id: footerSelectedPlace; FooterSelectedPlace {visible: false;}}


    // Stackview'e ait bazı temel fonksiyonlara dışarıdan ulaşabilmesini sağlamak amacı ile eklenen köprü fonksiyonlar
    function insertFooterByID(pID)
    {
        footerNavigation.pushFooterByfooterNumber(pID);
    }

    function back()
    {
        footerNavigation.popOneFooter();
    }
    function backHome()
    {
        footerNavigation.pop(null);
    }

    // Main tarafından globalbackpressed event'i yayınlandığı zaman stack yapısından pop yapılmasını sağlayacak olan kısımdır.
    Connections
    {
        target: appWindow;
        onFooterBack:
        {
            back();
        }

        onGoHomepage:
        {
            footerNavigation.pop(null);
        }
    }
}
