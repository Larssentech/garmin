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

class TextUtil{

    var cursorX;
    var cursorY;

    var editCursorX;
    var editCursorY;

    function initialize(){

        self.cursorX = C.QPAD_X + C.QPAD_MARGIN_LEFT;
        self.cursorY = C.QPAD_Y + C.QPAD_MARGIN_TOP;
    }

    function getCursorX(){
        return self.cursorX;
    }

    function getCursorY(){
        return self.cursorY;
    }

    function getEditCursorX(){
        return self.editCursorX;
    }

    function getEditCursorY(){
        return self.cursorY;
    }

    // Finds the location of the start of the last line
    private function getLastLineStart(fullString){

        var lastLineStart = 0;

        for(var i=0; i<fullString.length(); i+=1){
            if(fullString.substring(i, i+1).equals("\n")){
                lastLineStart = i;
            }
        }

        return lastLineStart;
    }

    function getCursorXY(fullString, cursorIx){

        // Get the dimensions for the whole text. If multiline, the dimensions will be
        // the height of all the lines BUT the length of the longest line.
        var dim = QBoard.getTextWH(fullString);

        // Cursor X
        // We need the dimensions of the last line, not the longest line.
        // Capture where thelast "\n" might be so we take the last line's X dimensions
        var lastLineStart = self.getLastLineStart(fullString);

        // If there was a "\n" lastLineStart will be > 0 so we take the substring from there to the end (last line)
        // and if no "\n" then lastLineStart is 0, the start of the single string so we take it all anyway
        var tmpX = QBoard.getTextWH(fullString.substring(lastLineStart, cursorIx))[0];
        
        // Set X
        self.cursorX += tmpX;
        
        // Cursor Y
        // If we have any amount of text, we add the height of the text, minus font height, so we end in the last
        // line and not immediately below
        self.cursorY += dim[1] - (fullString.length() > 0?  QBoard.getFontH(): 0);
       
        return [cursorX, cursorY];
    }

    private function getEditLineStart(fullString, cursorIx){

        var lastLineStart = 0;

        for(var i=0; i<cursorIx; i+=1){
            if(fullString.substring(i, i+1).equals("\n")){
                lastLineStart = i;
            }
        }

        return lastLineStart;
    }

    function getEditCursorXY(fullString, cursorIx){

        // Get the dimensions for the whole up to the cursor. If multiline, the dimensions will be
        // the height of all the lines BUT the length of the longest line.
        var dim = QBoard.getTextWH(fullString.substring(0, cursorIx));

        // Cursor X
        // We need the dimensions of the line the cursor ix is on up to the index.
        // Capture where thelast "\n" up to the cursor ix
        var lastLineStart = self.getEditLineStart(fullString, cursorIx);

        // If there was a "\n" lastLineStart will be > 0 so we take the substring from there to the cursor ix
        // and if no "\n" then lastLineStart is 0, the start of the single string so we take it all anyway
        var tmpX = QBoard.getTextWH(fullString.substring(lastLineStart, cursorIx))[0];

        // Set X now we have exactly the dimensions of the line the cursor is on, up to the char the cursor is
        self.cursorX += tmpX; // - tmpXm;
        
        // Cursor Y
        // If we have any amount of text, we add the height of the text, minus font height, so we end in the 
        // line the cursor is on and not immediately below
        self.cursorY += dim[1] - ((fullString.length() > 0 && cursorIx > 0)?  QBoard.getFontH(): 0);
       
        return [cursorX, cursorY];
    }
}