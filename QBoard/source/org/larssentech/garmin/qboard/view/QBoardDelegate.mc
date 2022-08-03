/*
MIT License

Copyright (c) 2022 Lars Andersson (software@larssentech.org)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Author: Lars Andersson (GitHub: Larssentech (https://github.com/Larssentech/garmin.git);
License: MIT License
*/

using Toybox.WatchUi as Ui;
using QBoardConst as C;

class QBoardDelegate extends Ui.BehaviorDelegate { // extends InputDelegate as the parent, which implements onBack, onSelect, etc

    private var qBoard;
    
    function initialize(qBoard) {
        
        self.qBoard = qBoard;

        BehaviorDelegate.initialize();
    }

    function onKey(event) {

        var key = event.getKey();

        switch(key) {

            //case Ui.KEY_ESC: return onBack();
            //case Ui.KEY_ENTER: return onSelect();
            case Ui.KEY_UP:   return doUp();            // 13
            case Ui.KEY_DOWN: return doDown();          //  8
            case Ui.KEY_ZOUT: return doAddSpace();      //  3
            case Ui.KEY_ZIN:  return doDeleteLast();    //  2
            case Ui.KEY_FIND: return doFind();          //  6
            case Ui.KEY_RIGHT: return doRight();        // 12
            case Ui.KEY_LEFT: return doLeft();          // 11

            default: return false;
        }
    }

    // @override Detect Menu
    function onMenu() {

        if(!self.getQBoard().getJoyStick().getMode()){

            // ;-0
            for(var i=0; i<C.ORBITAL.length(); i++){
                self.getQBoard().getJoyStick().getTypeMan().appendChar(C.ORBITAL.substring(i, i+1));
            }
        }

        Ui.requestUpdate();
        return true; // true: block parent InputDelegate function to be called
    }

    // @override Detect Enter
    function onSelect(){
        
        if(!self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().getTypeMan().doAppendChar(self.getQBoard().getJoyStick().getQBoxI());
        }

        Ui.requestUpdate();
        return true; // true: block parent InputDelegate function to be called
    }

    // @override Detect Quit (back)
    function onBack(){
        
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true; // true: block parent InputDelegate function to be called
    }

    // @override Detect Page key 17 (and arrow right, key 12)
    // We don't want to use 17, but we want to use 12
    function onNextPage() {
        return false; // false: allow parent InputDelegate function to be called
    }

    // @override Detect arrow left, key 11
    function onPreviousPage() {
        return false; // false: allow parent InputDelegate function to be called
    }

    // Custom functions for QBox behaviour
    // Movement up
    private function doUp() {
        if(!self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().moveQBoxUp();
        }

        return true;
    }

    // Movement down
    private function doDown() {
        if(!self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().moveQBoxDown();
        }

        return true;
    }

    // Edit movement right
    function doRight() {
        
        if(self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().moveCursorRight();
        }   
        
        else{
            self.getQBoard().getJoyStick().moveQBoxRight();
        }

        Ui.requestUpdate();
        return true;
    }

    // Edit movement left
    function doLeft() {

         if(self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().moveCursorLeft();
        }   
        
        else{
            self.getQBoard().getJoyStick().moveQBoxLeft();
        }

        Ui.requestUpdate();
        return true;
    }
    
    function doFind(){

        self.getQBoard().getJoyStick().toggleEditMode();

        Ui.requestUpdate();
        return true;
    }

    private function doAddSpace(){

        if(!self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().addSpace();
        }
        
        Ui.requestUpdate();
        return true;
    }

    private function doDeleteLast(){
        
        if(!self.getQBoard().getJoyStick().getMode()){
            self.getQBoard().getJoyStick().deleteLast();
        }
        
        Ui.requestUpdate();
        return true;
    }

    // Accerssors
    function getQBoard(){return self.qBoard;}
}