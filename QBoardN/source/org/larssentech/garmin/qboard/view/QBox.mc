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

class QBox{

    private var qBoard;

    function initialize(qBoard){
        self.qBoard = qBoard;
    }

    function paintQBox(){

        if(!self.getQBoard().getJoyStick().getMode()) {
            QBoard.dc.setColor(C.CRL_QBOX_ACTIVE, C.CRL_QBOX_ACTIVE);
        } 
        else {
            QBoard.dc.setColor(C.CRL_QBOX_INACTIVE, C.CRL_QBOX_INACTIVE);
        }

        QBoard.dc.setPenWidth(2);
        QBoard.dc.drawRectangle(
            
            C.QBOARD_START_X + self.getQBoard().getJoyStick().getTypeMan().getQBoxO().getQBoxC() * C.QBOARD_COL_W, 
            C.QBOARD_START_Y + self.getQBoard().getJoyStick().getTypeMan().getQBoxO().getQBoxR() * C.QBOARD_ROW_H, 
            C.QBOARD_COL_W, 
            C.QBOARD_ROW_H
        );
    }

    //
    private function getQBoard(){return self.qBoard;}
}