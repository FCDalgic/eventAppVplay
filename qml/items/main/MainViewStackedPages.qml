import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "../../pages"
import "../../pages/favourites"
import "../../pages/authantication"
import "../../pages/others"
import "../../pages/categories"
StackView {

    id: navPane
    initialItem: pageMain
    anchors.fill: parent

    focus: true;

    property bool ableToGoTop: false;
    function canGoUp()
    {
        ableToGoTop = currentItem.canGoTop();
        return ableToGoTop;
    }
    function scrollTop()
    {
        currentItem.scrollTop();
    }

    Component {
        id: pageMain
        PageMain {
            visible: true;
            globalIndex: appWindow.globalSwipeIndex;
        }
    }

    Component {
        id: pageSelectedCategory
        PageSelectedCategory {
            id: pageSelectedCategoryItem;
            modelType: appWindow.lastSelectedCategoryTitle;
        }
    }

    Component {
        id: pageSelectedEvent

        PageSelectedEvent {
            model: selectedEventModelData;
        }

    }

    Component
    {
        id: pageAbout;

        PageAbout
        {

        }
    }
    Component
    {
        id:  pageFavourites;
        PageFavourites
        {

        }
    }
    Component
    {
        id:  pageAuthantication
        PageAuthantication
        {

        }
    }
    Component
    {
        id: pageSignin;
        PageSignin
        {

        }
    }

    Component
    {
        id: pageResetRequest;
        PageSendResetRequest
        {

        }
    }
    Component
    {
        id: pageUpdatePass;
        PageResetPassword
        {

        }
    }

    Component
    {
        id: pageAboutSe;
        PageAboutSehirEtkinlikleri
        {

        }
    }
    Component
    {
        id: pageAboutContr
        PageAboutContributions
        {

        }
    }


    Component { id : pageTerms; PageTermsAndConditions{}}

    // Modeli global olarak bağlıyoruz.
    Component { id : pageSelectedPlace; PageSelectedPlace{ model: selectedPlaceModelData; }}
    Component { id : pageFoods; PageFoodEvents{}}
    onFocusChanged:
    {
        console.log("Nav Pane: " + focus);
        if (depth > 1)
        {
            navPane.focus = true;
            navPane.forceActiveFocus();
        }
    }

    Keys.onBackPressed: {
        console.log("Stackview Back pressed, depth :  "  + navPane.depth);
        appWindow.globalBackPressed();
        return;

    }


    background: Rectangle
    {
        anchors.fill : parent;
        color : "transparent";
    }


    // go one level back in stack
    function popOnePage() {
        if(navPane.depth == 1) {
            return
        }

        console.log("Navigation Depth : " + navPane.depth);



        // check if target page already is on the stack
        var targetIsUninitialized = false
        if(!navPane.get(navPane.depth-2)) {
            targetIsUninitialized = true
        }
        var page = pop()
        if(targetIsUninitialized) {
            navPane.currentItem.init()
        }
    } // popOnePage

    function pushOnePage(pageComponent) {
        var page = push(pageComponent)
        //            page.init()
    }

    function pushNextPage() {
        switch(navPane.depth) {
        case 1:
            pushOnePage(pageMain)
            break;
        case 2:
            pushOnePage(pageSelectedCategory)
            break;
        case 3:
            pushOnePage(pageSelectedEvent)
            break;
        case 4:
            pushOnePage(pageAbout);
            break;
        case 5:
            pushOnePage(pageAuthantication);
            break;
        case 6:
            pushOnePage(pageSignin);
            break;
        case 7:
            pushOnePage(pageResetRequest);
            break;
        case 8:
            pushOnePage(pageUpdatePass);
            break;
        case 9:
            pushOnePage(pageAboutSe);
            break;
        case 10:
            pushOnePage(pageTerms);
            break;
        case 11:
            pushOnePage(pageFoods);
            break;
        case 12:
            pushOnePage(pageAboutContr);
            break;
        case 13:
            pushOnePage(pageSelectedPlace);
            break;
        default:
            break;
            // nothing - 4 is max
        }
    } // pushNextPage

    function findPage(pageName) {
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

    function pushPageByPageNumber(pageNumber)
    {
        var page;
        switch(pageNumber) {
        case 1:
            page = pageMain
            break;
        case 2:
            page = pageSelectedCategory
            break;
        case 3:
            page = pageSelectedEvent
            break;
        case 4:
            page = pageAbout;
            break;
        case 5:
            page = pageAuthantication;
            break;
        case 6:
            page = pageSignin;
            break;
        case 7:
            page = pageResetRequest;
            break;
        case 8:
            page = pageUpdatePass;
            break;
        case 9:
            page =pageAboutSe;
            break;
        case 10:
            page = pageTerms;
            break;
        case 11:
            page = pageFoods;
            break;
        case 12:
            page = pageAboutContr;
            break;
        case 13:
            page = pageSelectedPlace;
            break;
        default:
            // nothing
            return
        }

        pushOnePage(page);
    }

    function goUpTo(pageNumber) {
        var count = pageNumber-navPane.depth
        var pages = new Array (count)
        for(var i = 0; i < count; i++) {
            var thePageNumber = navPane.depth+i+1
            switch(thePageNumber) {
            case 1:
                pages[i] = pageMain
                break;
            case 2:
                pages[i] = pageSelectedCategory
                break;
            case 3:
                pages[i] = pageSelectedEvent
                break;
            case 4:
                pages[i] = pageAbout;
                break;
            case 5:
                pages[i] = pageAuthantication;
                break;
            case 6:
                pages[i] = pageSignin;
                break;
            case 7:
                pages[i] = pageResetRequest;
                break;
            case 8:
                pages[i] = pageUpdatePass;
                break;
            case 9:
                pages[i] = pageAboutSe;
                break;
            case 10:
                pages[i] = pageTerms;
                break;
            case 11:
                pages[i] = pageFoods;
                break;
            case 12:
                pages[i] = pageAboutContr;
                break;
            case 13:
                pages[i] = pageSelectedPlace;
                break;
            default:
                // nothing
                return
            }
        }
        var page = push(pages)
        //            page.init()
    } // goUpTo

    function goDownTo(pageNumber) {
        // check if cleanup must be done for popped pages
        var count = navPane.depth-pageNumber
        for(var i = 0; i < count; i++) {
            if(navPane.get(navPane.depth-i-1)) {
                //                    navPane.get(navPane.depth-i-1).cleanup()
            }
        }
        // pop all pages until targetPage will be on top
        // check if target page already is on the stack
        var targetIsUninitialized = false
        if(!navPane.get(pageNumber-1)) {
            targetIsUninitialized = true
        }
        // don't forget to set StackView.ForceLoad
        // otherwise if get() is null and get(null) means jump to root
        pop(navPane.get(pageNumber-1, StackView.ForceLoad))
        if(targetIsUninitialized) {
            navPane.get(pageNumber-1).init()
        }
    } // goDownTo

    function goToPage(pageNumber) {
        if(pageNumber == navPane.depth) {
            // it's the current page
            return
        }
        if(pageNumber > navPane.depth) {
            goUpTo(pageNumber)
            return
        }
        goDownTo(pageNumber)
    } // goToPage




}
