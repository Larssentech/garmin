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
using Toybox.Graphics as Gfx;
using QBoardConst as C;

/**
  * QBoard class. Uses 3 artefacts for interactive typing:
  * - QPad: to display and edit text typed
  * - Qb: the actual printed keyboard
  * - QBox: to hover over the relevant character on the painted keyboard
  *   - The QBox needs an instance of QMan to keep track of the typed characters
  * 
  */
class QBoard extends Ui.View {

    var qPad;
    var qB;
    var joyStick;
    static var dc;

    function initialize() {

        self.qPad = new QPad();
        self.qB = new Qb();
        self.joyStick = new JoyStick();

        View.initialize();
    }

    function onUpdate(dc) {
        QBoard.dc = dc;

        // Clear everything
        dc.setColor(C.CLR_QBOARD_BG, C.CLR_QBOARD_BG);
        dc.clear();

        dc.setColor(C.CLR_QBOARD_TITLE, C.CLR_TRANSPARENT); 
        dc.drawText(C.DEVICE_WIDTH0/2, 10, C.FNT_STD, C.QB_VIEW_TITLE, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);

        // Paint the QPad typying area
        self.qPad.paint(dc);
        self.qPad.doPaintQPadGrid(dc);
        //self.qB.doCharacterLayout(dc);

        
        // Set the QPad mode to display typed text or edit typed text
        if(!self.joyStick.isEditMode()) {self.qPad.doPrintFullString(dc, self.joyStick.getQMan());}
        else {self.qPad.doEditFullString(dc, self.joyStick.getEditMan());}

        // Paint the QB
        self.qB.doPaintQBoardGrid(dc);
        self.qB.doCharacterLayout(dc);

        // Paint the QBox for character selection
        self.paintQBox(dc);
    }

    function getJoyStick(){
        return self.joyStick;
    }

    private function paintQBox(dc){

        if(!self.joyStick.isEditMode()) {
            dc.setColor(C.CRL_QBOX_ACTIVE, C.CRL_QBOX_ACTIVE);
        } 
        else {
            dc.setColor(C.CRL_QBOX_INACTIVE, C.CRL_QBOX_INACTIVE);
        }

        dc.setPenWidth(2);
        dc.drawRectangle(
            
            C.QBOARD_START_X + self.joyStick.getQBoxC() * self.joyStick.getQBoxW(), 
            C.QBOARD_START_Y + self.joyStick.getQBoxH() * self.joyStick.getQBoxR(), 
            self.joyStick.getQBoxW(), 
            self.joyStick.getQBoxH()
        );
    }

    static function getTextWH(text){
        return QBoard.dc.getTextDimensions(text, C.FNT_STD);
    }

    static function getFontH(){
        return QBoard.dc.getFontHeight(C.FNT_STD);
    }
}