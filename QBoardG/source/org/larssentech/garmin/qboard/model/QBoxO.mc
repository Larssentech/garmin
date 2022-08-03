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

    private var qBoxW;  // QBox Width
    private var qBoxH;  // QBox Height
    private var qBoxR;  // QBox Row
    private var qBoxC;  // QBox Column

    private var editMode = false;

    function initialize(){
        self.setQBoxW(C.QBOARD_COL_W);
        self.setQBoxH(C.QBOARD_ROW_H);
        self.setQBoxR(0);
        self.setQBoxC(0);
    }

    // The linear index of where the QBox is is calculated using the coordinates
    function getQBoxI(){
        return self.getQBoxR()*C.QBOARD_COLS + self.getQBoxC();
    }

    // Accessors
    function isEditMode(){ return self.editMode;}
    function setEditMode(b){self.editMode = b;}
    function getQBoxW(){return self.qBoxW;}
    function getQBoxH(){return self.qBoxH;}
    function getQBoxC(){return self.qBoxC;}
    function getQBoxR(){return self.qBoxR;}
    function setQBoxW(qBoxW){self.qBoxW = qBoxW;}
    function setQBoxH(qBoxH){self.qBoxH = qBoxH;}
    function setQBoxC(qBoxC){self.qBoxC = qBoxC;}
    function setQBoxR(qBoxR){self.qBoxR = qBoxR;}
}