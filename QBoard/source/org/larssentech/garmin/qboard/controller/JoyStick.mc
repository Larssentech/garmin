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

/* 
    The JoyStick class uses 2 objects: 
    
    - a QBoxO, to hold data representing where the key selection is on the screen
      and whose graphical representation is moved around based on events triggered 
      by movements of the physical JoyStick,
    
    - a QMan to hold what character index from the QB is under the box (when in type 
      mode) or the character index being edited (when in edit mode). 
    
*/

class JoyStick{

    private var tMan;
    private var eMan;
    private var mode = C.TYPE_MODE;

    function initialize(){

        var qObjectHub = new QObjectHub();

        tMan  = new TypeMan(qObjectHub);
        eMan  = new EditMan(qObjectHub);
    }

    // Vim-style operation, type mode, navigate (edit) mode
    function toggleEditMode(){
        
        if(self.getTypeMan().getQManO().getFullString().length() > 0){

            self.setMode(!self.getMode());

            // Do not remove
            System.println(self.getMode()? "Edit mode": "Type mode");
            
            if(!self.getMode()) {self.getEditMan().resetCursorIx();}
            else{self.moveCursorLeft();}
        }
    }

    // To move QBox up
    function moveQBoxUp() as void {

        // Top edge case: Reset Y to bottom +1
        if(self.getTypeMan().getQBoxO().getQBoxR() <= 0) {
            self.getTypeMan().getQBoxO().sendToBottom();
        }

        // Move Y 1 up
        self.getTypeMan().getQBoxO().dropQBoxR();

       
        Ui.requestUpdate();
    }

    function moveQBoxDown() as void {

        // Bottom edge case: Reset Y to top -1
        if(self.getTypeMan().getQBoxO().getQBoxR() >= C.QBOARD_ROWS-1){
            self.getTypeMan().getQBoxO().sendToTop();
        }

        // Move Y 1 down
        self.getTypeMan().getQBoxO().addQBoxR();

        Ui.requestUpdate();
    }

    function moveQBoxLeft() as void {

        // Left edge case: Reset X to end of right +1
        if(self.getTypeMan().getQBoxO().getQBoxC() <= 0){
            self.getTypeMan().getQBoxO().sendToRight();
        }

        // Move X 1 left
        self.getTypeMan().getQBoxO().dropQBoxC();

        Ui.requestUpdate();
    }

    function moveQBoxRight() as void {

        // Reset X to start of left -1
        if(self.getTypeMan().getQBoxO().getQBoxC() >= C.QBOARD_COLS-1){
            self.getTypeMan().getQBoxO().sendToLeft();
        }

        // Move X 1 right
        self.getTypeMan().getQBoxO().addQBoxC();

        Ui.requestUpdate();
    }

    function moveCursorRight(){
        self.getEditMan().moveCursor(C.CURSOR_RIGHT);
    }

    function moveCursorLeft(){
        self.getEditMan().moveCursor(C.CURSOR_LEFT);
    }

    function deleteLast() as void{
        self.getTypeMan().deleteLast();
    }

    function addSpace(){
        self.getTypeMan().appendChar(C.SPACE);
    }

    // Object accessor delegates

    function getQBoxI(){
        return self.getTypeMan().getQBoxO().getQBoxI();
    }

    function getQBoxC(){
        return self.getTypeMan().getQBoxO().getQBoxC();
    }

    function getQBoxR(){
        return self.getTypeMan().getQBoxO().getQBoxR();
    }

    // Accessors
    function getMode(){return self.mode;}
    function setMode(mode) as void {self.mode = mode;}
    function getTypeMan(){return self.tMan;}
    function getEditMan(){return self.eMan;}
}