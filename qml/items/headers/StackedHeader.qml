    import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

import "../../items"

Rectangle {
    id: stackedHeaderContainer;
    Layout.fillWidth: true;
    width: appWindow.width;
    height: appWindow.height * 0.1

    // Navigation Stack
    StackView
    {
        id: headerNavigation;
        initialItem: headerMain;
        anchors.fill: parent
        focus: true;

        Keys.onBackPressed:
        {
            console.log("Backpressed on stacked header");
            globalBackPressed();
        }

        onCurrentItemChanged:
        {
            var showFooter = currentItem.showFooter();
            headerNavigation.visible = showFooter;
            stackedHeaderContainer.visible = showFooter;
            var headerName = headerNavigation.currentItem.whoAmI();


            console.log("\n \n header değişti şu anki header : " + headerName + "\n");
        }
        // go one level back in stack
        function popOneHeader() {
            if(headerNavigation.depth == 1) {
                return
            }

            // check if target header already is on the stack
//            var targetIsUninitialized = false
//            if(!headerNavigation.get(headerNavigation.depth-2)) {
//                targetIsUninitialized = true
//            }
            var header = pop()
//            if(targetIsUninitialized) {
//                headerNavigation.currentItem.init()
//            }

        } // popOneHeader

        function pushOneHeader(pageComponent) {
            var header = push(pageComponent)
            //            header.init()
        }

        function pushNextHeader() {
            switch(headerNavigation.depth) {
            case 1:
                pushOneHeader(headerMain)
                break;
            case 2:
                pushOneHeader(headerSelectedCategory)
                break;
            case 3:
                pushOneHeader(headerSelectedEvent)
                break;
            case 4:
                pushOneHeader(headerAbout);
                break;
            case 5:
                pushOneHeader(headerAuthantication)
                break;
            case 6:
                pushOneHeader(headerSingin);
                break;
            case 7:
                pushOneHeader(headerResetRequest);
                break;
            case 8:
                pushOneHeader(headerUpdatePass);
                break;
            case 9:
                pushOneHeader(headerAboutSe);
                break;
            case 10:
                pushOneHeader(headerTerms);
                break;
            case 11:
                pushOneHeader(headerFood);
                break;
            case 12:
                pushOneHeader(headerAboutCont);
                break;
            case 13:
                pushOneHeader(headerSelectedPlace);
                break;
            default:
                break;
                // nothing - 4 is max
            }
        } // pushNextHeader

        function findHeader(pageName) {
            var targetPage = find(function(item) {
                return item.name === pageName;
            })
            if(targetPage) {
                return targetPage.StackView.index
            } else {
                console.log("Page not found in StackView: "+pageName)
                return -1
            }
        }

        function setTitleForHeader(pTitle)
        {
            headerNavigation.currentItem.setTitle(pTitle);
        }

        function pushHeaderByheaderNumber(headerNumber)
        {
            var header;
            switch(headerNumber) {
            case 1:
                header = headerMain
                break;
            case 2:
                header = headerSelectedCategory
                break;
            case 3:
                header = headerSelectedEvent
                break;
            case 4:
                header = headerAbout;
                break;
            case 5:
                header = headerAuthantication
                break;
            case 6:
                header = headerSingin;
                break;
            case 7:
                header = headerResetRequest;
                break;
            case 8:
                header = headerUpdatePass;
                break;
            case 9:
                header = headerAboutSe;
                break;
            case 10:
                header = headerTerms;
                break;
            case 11:
                header = headerFood;
                break;
            case 12:
                header = headerAboutCont;
                break;
            case 13:
                header = headerSelectedPlace;
                break;
            default:
                // nothing
                return
            }

            pushOneHeader(header);
        }

        function goUpTo(headerNumber) {
            var count = headerNumber-headerNavigation.depth
            var pages = new Array (count)
            for(var i = 0; i < count; i++) {
                var theheaderNumber = headerNavigation.depth+i+1
                switch(theheaderNumber) {
                case 1:
                    pages[i] = headerMain
                    break;
                case 2:
                    pages[i] = headerSelectedCategory
                    break;
                case 3:
                    pages[i] = headerSelectedEvent
                    break;
                case 4:
                    pages[i] = headerAbout;
                    break;
                case 5:
                    pages[i] = headerAuthantication;
                    break;
                case 6:
                    pages[i] = headerSingin;
                    break;
                case 7:
                    pages[i] = headerResetRequest;
                    break;
                case 8:
                    pages[i] = headerUpdatePass;
                    break;
                case 9:
                    pages[i] = headerAboutSe;
                    break;
                case 10:
                    pages[i] = headerTerms;
                    break;
                case 11:
                    pages[i] = headerFood;
                    break;
                case 12:
                    pages[i] = headerAboutCont;
                    break;
                case 13:
                    pages[i] = headerSelectedPlace;
                    break;
                default:
                    // nothing
                    return
                }
            }
            var header = push(pages)
            //            header.init()
        } // goUpTo

        function goDownTo(headerNumber) {
            // check if cleanup must be done for popped pages
            var count = headerNavigation.depth-headerNumber
            for(var i = 0; i < count; i++) {
                if(headerNavigation.get(headerNavigation.depth-i-1)) {
                    //                    headerNavigation.get(headerNavigation.depth-i-1).cleanup()
                }
            }
            // pop all pages until targetPage will be on top
            // check if target header already is on the stack
            var targetIsUninitialized = false
            if(!headerNavigation.get(headerNumber-1)) {
                targetIsUninitialized = true
            }
            // don't forget to set StackView.ForceLoad
            // otherwise if get() is null and get(null) means jump to root
            pop(headerNavigation.get(headerNumber-1, StackView.ForceLoad))
            if(targetIsUninitialized) {
                headerNavigation.get(headerNumber-1).init()
            }
        } // goDownTo

        function goToPage(headerNumber) {
            if(headerNumber === headerNavigation.depth) {
                return
            }
            if(headerNumber > headerNavigation.depth) {
                goUpTo(headerNumber)
                return
            }
            goDownTo(headerNumber)
        } // goToPage
    }


    // Components for that Stack
    Component { id: headerMain; HeaderMain{}}
    Component { id: headerSelectedCategory; HeaderSelectedCategory{  id: pageSelectedCategoryItem;}}
    Component { id: headerSelectedEvent; HeaderSelectedEvent{}}
    Component { id: headerAbout; HeaderAbout{}}
    Component { id: headerAuthantication; HeaderAuthantication{}}
    Component { id: headerSingin; HeaderSignin{}}
    Component { id: headerResetRequest; HeaderResetRequest{}}
    Component { id: headerUpdatePass; HeaderUpdatePassword{}}
    Component { id :headerAboutSe; HeaderAboutSe{}}
    Component { id :headerTerms; HeaderTerms{}}
    Component { id :headerFood; HeaderFoodCategory{}}
    Component { id :headerAboutCont; HeaderAbout{}}
    Component { id: headerSelectedPlace; HeaderSelectedPlace{}}

    // Functions to change stackview depth and content

    function setHeader(pID , pTitle)
    {
        headerNavigation.pushHeaderByheaderNumber(pID);
        headerNavigation.setTitleForHeader(pTitle);
    }

    function setEnableMenu(pState)
    {
        headerNavigation.currentItem.setEnableMenu(pState);
    }

    function back()
    {
        headerNavigation.popOneHeader();
    }

    function backHome()
    {
        headerNavigation.pop(null);
    }

    Connections
    {
        target: appWindow;
        onHeaderBack:
        {
            console.log("Global Back Pressed Received in Stacked Header");
            back();

        }
        onGoHomepage:
        {
            headerNavigation.pop(null);
        }
    }


}
