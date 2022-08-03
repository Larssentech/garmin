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

class QPad {

    private var qBoard;

    function initialize(qBoard){
        self.qBoard = qBoard;
    }

    // Paints the visual area (pad) for typed characters to show in
    function paint() {

        // Paint the borders
        QBoard.dc.setPenWidth(1);
        QBoard.dc.setColor(C.CLR_QPAD_BORDER, C.CLR_QPAD_BORDER);
        QBoard.dc.drawRectangle(C.QPAD_X, C.QPAD_Y, C.QPAD_W, C.QPAD_H);

        // Paint the inside of the area
        QBoard.dc.setColor(C.CLR_QPAD_BG, C.CLR_QPAD_BG);
        QBoard.dc.fillRectangle(C.QPAD_X, C.QPAD_Y, C.QPAD_W, C.QPAD_H);
    }

    // Prints the full string and the visual cursor at the end of the last line
    function doPrintFullString() as void{

        // Get the current cursor index and the full string in memory
        var cursorIx = self.getQBoard().getJoyStick().getTypeMan().getQManO().getIx();
        var fullString = self.getQBoard().getJoyStick().getTypeMan().getQManO().getFullString();

        // Print the string
        QBoard.dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        QBoard.dc.drawText(C.QPAD_X + C.QPAD_MARGIN_LEFT, C.QPAD_Y + C.QPAD_MARGIN_TOP, C.FNT_STD, fullString, Gfx.TEXT_JUSTIFY_LEFT);

        // Print the cursor
        var cursorXY = new QPadUtil().getCursorXY(fullString, cursorIx);
        QBoard.dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_CURSED_TEXT_BG); 
        QBoard.dc.drawText(cursorXY[0], cursorXY[1], C.FNT_STD, " ", Gfx.TEXT_JUSTIFY_LEFT);
    }
    
    function doEditFullString() as void{

        // Get the current cursor index and the full string in memory
        var cursorIx = self.getQBoard().getJoyStick().getEditMan().getQManO().getIx();
        var fullString = self.getQBoard().getJoyStick().getEditMan().getQManO().getFullString();

        // Print the string
        QBoard.dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        QBoard.dc.drawText(C.QPAD_X + C.QPAD_MARGIN_LEFT, C.QPAD_Y + C.QPAD_MARGIN_TOP, C.FNT_STD, fullString, Gfx.TEXT_JUSTIFY_LEFT);

        // Print the cursor
        var cursorXY = new QPadUtil().getEditCursorXY(fullString, cursorIx);
        QBoard.dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_EDIT_TEXT_BG); 
        QBoard.dc.drawText(cursorXY[0], cursorXY[1], C.FNT_STD, self.getQBoard().getJoyStick().getEditMan().getCursedChar(), Gfx.TEXT_JUSTIFY_LEFT);
    }

    //
    private function getQBoard(){return self.qBoard;}
}