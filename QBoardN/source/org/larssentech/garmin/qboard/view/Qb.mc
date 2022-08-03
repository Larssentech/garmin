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

using QBoardConst as C;

class Qb {

    function doPaintQBoardGrid() as void{

        QBoard.dc.setColor(C.CLR_QB_GRID, C.CLR_QB_GRID);
        QBoard.dc.setPenWidth(1);

        for(var i=0; i<C.QBOARD_ROWS; i+=1){
            QBoard.dc.drawLine(0, C.QBOARD_START_Y + C.QBOARD_ROW_H*i, C.QBOARD_END_Y, C.QBOARD_START_Y + C.QBOARD_ROW_H*i);
        }

        for(var i=1; i<C.QBOARD_COLS; i+=1){
            QBoard.dc.drawLine(i*C.QBOARD_COL_W, C.QBOARD_START_Y, i*C.QBOARD_COL_W, C.QBOARD_END_Y);
        }
    }

    function doCharacterLayout() as void{

        QBoard.dc.setColor(C.CLR_QB_CHARS, C.CLR_QB_CHARS_BG);
        var base = 0;

        for(var i=0; i<C.QBOARD_ROWS; i+=1){

            for(var j=0; j<C.QBOARD_COLS; j+=1){

                var letterX = j*C.QBOARD_COL_W + C.QBOARD_COL_W/2;
                var letterY = (C.QBOARD_START_Y + C.QBOARD_ROW_H*i) + (C.QBOARD_ROW_H/2);

                var start = base;
                var end = start+1;
                var letter = C.QBOARD_CHARACTERS.substring(start, end);
                QBoard.dc.drawText(letterX, letterY, C.QB_CHAR_SIZE, letter, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
                base += 1;
            }
        }
    }
}