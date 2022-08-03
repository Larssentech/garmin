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

class QMan {

    private var qManO;
    private var lastLine = "";

    function initialize(qManO) as void{
        self.qManO = qManO;
        self.qManO.setFullString(C.EMPTY);
        self.qManO.setCursorIx(0);
    }

    function doAppendChar(i) as void{

        self.appendChar(C.QBOARD_CHARACTERS.substring(i, i+1));
    }

    function appendChar(char){
        var formattedChar = char;
        var fitsOK = self.textFits();

        if(!fitsOK){
            var fullString = self.qManO.getFullString();
            //System.println(fullString);
            
            System.println("last line is: " + self.lastLine);
            
            // TODO: if we type the same lines more than once, the "lastline" will be found above where we want to find it
            var i = fullString.find(self.lastLine) + self.lastLine.length();
            self.lastLine = fullString.substring(i, fullString.length() );
            formattedChar = C.NEW_LINE + char;
        }

        //System.println(lastLine);

        lastLine += formattedChar;

        //self.qManO.setCursorIx(self.getCursorIx() + (fitsOK? 1: 2));
        //self.qManO.setFullString(self.qManO.getFullString() + formattedChar);
    }

    function addSpace() as void {
        self.appendChar(C.SPACE);
    }

    function deleteLast() as void {
        self.qManO.setFullString(self.qManO.getFullString().substring(0, self.qManO.getFullString().length() -1));
        self.appendChar("");
    }

    private function textFits(){
        
        var hSpace = C.QPAD_X + C.QPAD_W - C.QPAD_MARGIN_RIGHT - C.QPAD_MARGIN_LEFT;
        var textSize = QBoard.getTextWH(self.lastLine + self.getBoxedChar())[0];
        //System.println(textSize < hSpace);
        return textSize < hSpace;
    }

    private function getBoxedChar() {
        return C.QBOARD_CHARACTERS.substring(self.getCursorIx(), self.getCursorIx()+1);
    }


    // Object accessor delegates
    function getCursorIx(){
        return self.qManO.getCursorIx();
    }

    function getFullString(){
        return self.qManO.getFullString();
    } 
}