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
using Toybox.System as System;
using QBoardConst as C;

class QPad {

    // Paints the visual area (pad) for typed characters to show in
    function paint(dc) {

        // Paint the borders
        dc.setPenWidth(1);
        dc.setColor(C.CLR_QPAD_BORDER, C.CLR_QPAD_BORDER);
        dc.drawRectangle(C.QPAD_X, C.QPAD_Y, C.QPAD_W, C.QPAD_H);

        // Paint the inside of the area
        dc.setColor(C.CLR_QPAD_BG, C.CLR_QPAD_BG);
        dc.fillRectangle(C.QPAD_X, C.QPAD_Y, C.QPAD_W, C.QPAD_H);
    }

    // Prints the full string and the visual cursor at the end of the last line
    function doPrintFullString(dc, qMan) as void{

        // Get the current cursor index and the full string in memory
        var cursorIx = qMan.getCursorIx();
        var fullString = qMan.getFullString();

        // Print the string
        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(C.QPAD_X + C.QPAD_MARGIN_LEFT, C.QPAD_Y + C.QPAD_MARGIN_TOP, C.FNT_STD, fullString, Gfx.TEXT_JUSTIFY_LEFT);

        // Print the cursor
        var cursorXY = new TextUtil().getCursorXY(fullString, cursorIx);
        dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_CURSED_TEXT_BG); 
        dc.drawText(cursorXY[0], cursorXY[1], C.FNT_STD, " ", Gfx.TEXT_JUSTIFY_LEFT);

        //System.println("Type Mode - Cursor at: " + cursorIx + "\n");
    }

    function doPaintQPadGrid(dc) as void{

        dc.setColor(C.CLR_QB_GRID, C.CLR_QB_GRID);
        dc.setPenWidth(1);

        for(var i=0; i<C.QPAD_ROWS; i+=1){
            dc.drawLine(C.QPAD_X, C.QPAD_Y + C.QBOARD_ROW_H*i, C.QPAD_X+C.QPAD_W, C.QPAD_Y + C.QBOARD_ROW_H*i);
        }

        for(var i=1; i<C.QBOARD_COLS; i+=1){
            dc.drawLine(i*C.QBOARD_COL_W, C.QPAD_Y, i*C.QBOARD_COL_W, C.QPAD_Y + C.QPAD_H);
        }
    }

    function doEditFullString(dc, eMan) as void{

        // Get the current cursor index and the full string in memory
        var cursorIx = eMan.getCursorIx();
        var fullString = eMan.getFullString();

        // Print the string
        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(C.QPAD_X + C.QPAD_MARGIN_LEFT, C.QPAD_Y + C.QPAD_MARGIN_TOP, C.FNT_STD, fullString, Gfx.TEXT_JUSTIFY_LEFT);

        // Print the cursor
        var cursorXY = new TextUtil().getEditCursorXY(fullString, cursorIx);
        dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_EDIT_TEXT_BG); 
        dc.drawText(cursorXY[0], cursorXY[1], C.FNT_STD, eMan.getCursedChar(), Gfx.TEXT_JUSTIFY_LEFT);

        var summary = 
            "Edit Mode - Cursor at: " + cursorIx + "\n";

        System.println(summary);
    }

    function doEditFullString0(dc, qMan) as void{

        // Get the current cursor index and the full string in memory
        var fullString = qMan.getFullString();
        var cursorIx = qMan.getCursorIx();
        
        // Based on where the cursor index is get 3 strings
        var part1 = fullString.substring(0, cursorIx);
        var cursedChar = fullString.substring(cursorIx, cursorIx+1);
        var part2 = fullString.substring(cursorIx+1, fullString.length());

        // Now we need to know where to print the 3 strings
        var printXYPart1  = [C.QPAD_X + C.QPAD_MARGIN_LEFT, C.QPAD_Y + C.QPAD_MARGIN_TOP];
        var printXYCursed = new TextUtil().getCursorXY(part1, cursorIx);
        var printXYPart2  = new TextUtil().getEditCursorXY(fullString, cursorIx+1);

        // Print part1, the cursed char and part 2
        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(printXYPart1[0], printXYPart1[1], C.FNT_STD, part1, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_EDIT_TEXT_BG); 
        dc.drawText(printXYCursed[0], printXYCursed[1], C.FNT_STD, cursedChar, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(printXYPart2[0], printXYPart2[1], C.FNT_STD, part2, Gfx.TEXT_JUSTIFY_LEFT);
   
        var summary = 
            "Edit Mode - Cursor at: " + cursorIx + "\n" +
            "Edit Mode - Part 1: " + part1 + "\n" + 
            "Edit Mode - Cursed char: " + cursedChar + "\n" + 
            "Edit Mode - Part 2: " + part2 + "\n";

        System.println(summary);

        //var tU = new TextUtil(self.qPadX, self.qPadY, self.qPadW, self.qPadH);
        //var printS = tU.chunkString(dc, fullString);
        
        // Count carriage returns
        //var carr = TextUtil.countCarr(printS);
        
        // And add them to our index for the cursor
        //var cursorIx = qMan.getCursorIx()+carr;

        //cursorIx += carr;

        //var part1 = printS.substring(0, cursorIx);

        //dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        //dc.drawText(qPadX + C.QPAD_MARGIN_LEFT, qPadY + C.QPAD_MARGIN_TOP, C.FNT_STD, part1, Gfx.TEXT_JUSTIFY_LEFT);

        //var cursedChar = printS.substring(cursorIx, cursorIx+1);
        //var textDims = dc.getTextDimensions(part1, C.FNT_STD);

        //dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_EDIT_TEXT_BG); 
        //dc.drawText(tU.getEditCursorX(), tU.getCursorY(), C.FNT_STD, cursedChar, Gfx.TEXT_JUSTIFY_LEFT);

        //var part2 = printS.substring(cursorIx, printS.length());
        //textDims = dc.getTextDimensions(part1 + cursedChar, C.FNT_STD);

        //dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        //dc.drawText(qPadX + C.QPAD_MARGIN_LEFT + textDims[0], qPadY + C.QPAD_MARGIN_TOP + textDims[1], C.FNT_STD, part2, Gfx.TEXT_JUSTIFY_LEFT);
    }


    // Old methods, simpler and better for debugging
    /* function doPrintFullStringBasic(dc, fullString){

        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(qPadX + C.QPAD_MARGIN_LEFT, qPadY + C.QPAD_MARGIN_TOP, C.FNT_STD, fullString, Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);

        var textDims = dc.getTextDimensions(fullString, C.FNT_STD);

        dc.setColor(C.CLR_QPAD_CURSOR, C.CLR_QPAD_CURSOR); 
        dc.drawText(qPadX + C.QPAD_MARGIN_LEFT + textDims[0], qPadY + C.QPAD_MARGIN_TOP, C.FNT_STD, C.CURSOR, Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    } */
   
    /* function doEditFullStringBasic(dc, qMan){
        
        var cursorIx = qMan.getCursorIx();
        var fullString = qMan.getFullString();

        var part1 = fullString.substring(0, cursorIx);

        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(qPadX + C.QPAD_MARGIN_LEFT, qPadY + C.QPAD_MARGIN_TOP, C.FNT_STD, part1, Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);

        var cursedChar = fullString.substring(cursorIx, cursorIx+1);
        var textDims = dc.getTextDimensions(part1, C.FNT_STD);

        dc.setColor(C.CLR_QPAD_CURSED_TEXT, C.CLR_QPAD_CURSED_TEXT_BG); 
        dc.drawText(qPadX + C.QPAD_MARGIN_LEFT + textDims[0], qPadY + C.QPAD_MARGIN_TOP, C.FNT_STD, cursedChar, Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);

        var part2 = fullString.substring(cursorIx+1, fullString.length());
        textDims = dc.getTextDimensions(part1 + cursedChar, C.FNT_STD);

        dc.setColor(C.CLR_QPAD_TEXT, C.CLR_QPAD_BG); 
        dc.drawText(qPadX + C.QPAD_MARGIN_LEFT + textDims[0], qPadY + C.QPAD_MARGIN_TOP, C.FNT_STD, part2, Gfx.TEXT_JUSTIFY_LEFT|Gfx.TEXT_JUSTIFY_VCENTER);
    } */
}