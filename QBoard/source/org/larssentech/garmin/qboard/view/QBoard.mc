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

    // Graphical objects
    var qPad;
    var qB;
    var qBox;

    // Controller
    var joyStick;

    // Only to be used when triggered by onUpdate()
    static var dc;

    function initialize() {

        self.qPad = new QPad(self);
        self.qB = new Qb();
        self.joyStick = new JoyStick();

        self.qBox = new QBox(self);

        View.initialize();
    }

    function onUpdate(dc) {
        QBoard.dc = dc;

        // Clear everything
        dc.setColor(C.CLR_QBOARD_BG, C.CLR_QBOARD_BG);
        dc.clear();

        dc.setColor(C.CLR_QBOARD_TITLE, C.CLR_TRANSPARENT); 
        dc.drawText(C.DEVICE_WIDTH0/2, C.QBOARD_TITLE_Y, C.FNT_STD, C.QB_VIEW_TITLE, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);

        // Paint the QPad typying area
        self.getQPad().paint();
        
        // Set the QPad mode to display typed text or edit typed text
        if(!self.getJoyStick().getMode()) {self.getQPad().doPrintFullString();}
        else {self.getQPad().doEditFullString();}

        // Paint the QB
        self.getQb().doPaintQBoardGrid();
        self.getQb().doCharacterLayout();

        // Paint the QBox for character selection
        self.qBox.paintQBox();
    }

    static function getTextWH(text){
        return QBoard.dc.getTextDimensions(text, C.FNT_STD);
    }

    static function getFontH(){
        return QBoard.dc.getFontHeight(C.FNT_STD);
    }

    // Accessors
    private function getQPad(){return self.qPad;}
    private function getQb(){return self.qB;}
    function getJoyStick(){return self.joyStick;}
}