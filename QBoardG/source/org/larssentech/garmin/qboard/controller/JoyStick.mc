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

    private var qBoxO = new QBoxO();
    private var qManO = new QManO();
    private var qMan  = new QMan(qManO);
    private var eMan  = new EditMan(qManO);
    

    // Vim-style operation, type mode, navigate (edit) mode
    function toggleEditMode(){
        
        self.setEditMode(!self.isEditMode());
        
        if(!self.isEditMode()) {self.getEditMan().resetCursorIx();}
        else{self.getEditMan().moveCursorLeft();}
    }

    // To move QBox up
    function moveQBoxUp() as void {

        // Top edge case: Reset Y to bottom +1
        if(self.qBoxO.getQBoxR() <= 0) {
            //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI() + C.QBOARD_IX_MAX);
            self.qBoxO.setQBoxR(C.QBOARD_ROWS);
        }

        // Move Y 1 up
        //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI() - C.QBOARD_COLS);
        self.qBoxO.setQBoxR(self.qBoxO.getQBoxR()-1);

        //self.qMan.updateCurrentCharBoxed(self.qBoxO.getQBoxI());

        Ui.requestUpdate();
    }

    function moveQBoxDown() as void {

        // Bottom edge case: Reset Y to top -1
        if(self.qBoxO.getQBoxR() >= C.QBOARD_ROWS-1){
            //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI() - C.QBOARD_IX_MAX);
            self.qBoxO.setQBoxR(-1);
        }

        // Move Y 1 down
        //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI() + C.QBOARD_COLS);
        self.qBoxO.setQBoxR(self.qBoxO.getQBoxR() +1);

        Ui.requestUpdate();
    }

    function moveQBoxLeft() as void {

        // Left edge case: Reset X to end of right +1
        if(self.qBoxO.getQBoxC() <= 0){
            //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI() + C.QBOARD_COLS);
            self.qBoxO.setQBoxC(C.QBOARD_COLS);
        }

        // Move X 1 left
        //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI()-1);
        self.qBoxO.setQBoxC(self.qBoxO.getQBoxC()-1);

        Ui.requestUpdate();
    }

    function moveQBoxRight() as void {

        // Reset X to start of left -1
        if(self.qBoxO.getQBoxC() >= C.QBOARD_COLS-1){
            //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI() - C.QBOARD_COLS);
            self.qBoxO.setQBoxC(-1);
        }

        // Move X 1 right
        //self.qBoxO.setQBoxI(self.qBoxO.getQBoxI()+1);
        self.qBoxO.setQBoxC(self.qBoxO.getQBoxC()+1);

        //self.qMan.updateCurrentCharBoxed(self.qBoxO.getQBoxI());

        Ui.requestUpdate();
    }

    function moveCursorRight(){
        self.getEditMan().moveCursorRight();
    }

    function moveCursorLeft(){
        self.getEditMan().moveCursorLeft();
    }


    function getQMan(){
        return self.qMan;
    }

    function getEditMan(){
        return self.eMan;
    }

    // Object accessor delegates
    function isEditMode(){
        return self.qBoxO.isEditMode();
    }

    function setEditMode(b){
        self.qBoxO.setEditMode(b);
    }

    function getQBoxI(){
        return self.qBoxO.getQBoxI();
    }

    function getQBoxW(){
        return self.qBoxO.getQBoxW();
    }

    function getQBoxH(){
        return self.qBoxO.getQBoxH();
    }

    function getQBoxC(){
        return self.qBoxO.getQBoxC();
    }

    function getQBoxR(){
        return self.qBoxO.getQBoxR();
    }

    function setQBoxI(qBoxI){
        self.setQBoxI(qBoxI);
    }

    function setQBoxW(qBoxW){
        self.qBoxO.setQBoxW(qBoxW);
    }

    function setQBoxH(qBoxH){
        self.qBoxO.setQBoxH(qBoxH);
    }

    function setQBoxC(qBoxC){
        self.qBoxO.setQBoxC(qBoxC);
    }

    function setQBoxR(qBoxR){
        self.qBoxO.setQBoxR(qBoxR);
    }
}