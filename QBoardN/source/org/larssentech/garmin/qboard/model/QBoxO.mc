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

class QBoxO{

    private var qBoxR = C.ZERO;  // QBox Row
    private var qBoxC = C.ZERO;  // QBox Column

    private var editMode = false;

    // The linear index of where the QBox is is calculated using the coordinates
    function getQBoxI(){
        return self.getQBoxR()*C.QBOARD_COLS + self.getQBoxC();
    }

    function addQBoxR(){
        self.qBoxR += 1;
    }

    function dropQBoxR(){
        self.qBoxR -= 1;
    }

    function addQBoxC() as void{
        self.qBoxC += 1;
    }

    function dropQBoxC(){
        self.qBoxC -= 1;
    }

    function sendToRight(){
        self.qBoxC = C.QBOARD_COLS;
    }

    function sendToLeft(){
        self.qBoxC = -1;
    }

    function sendToBottom(){
        self.qBoxR = C.QBOARD_ROWS;
    }

    function sendToTop(){
        self.qBoxR = -1;
    }

    // Accessors
    function isEditMode(){ return self.editMode;}
    function setEditMode(b){self.editMode = b;}
    function getQBoxW(){return C.QBOARD_COL_W;}
    function getQBoxH(){return C.QBOARD_ROW_H;}
    function getQBoxC(){return self.qBoxC;}
    function getQBoxR(){return self.qBoxR;}
}