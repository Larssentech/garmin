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

class TypeMan {

    // Model
    private var qObjectHub;

    private var currentLine = C.EMPTY;

    // Holds the length of all lines as we add them
    private var lineArray = [0];

    function initialize(qObjectHub) as void{
        self.qObjectHub = qObjectHub;
    }

    function doAppendChar(i) as void{
        self.appendChar(C.QBOARD_CHARACTERS.substring(i, i+1));
    }

    // This is a bit like an old fashioned typrewriter:
    function appendChar(char){

        // We start asuming we can type the next desired character
        var formattedChar = char;
        
        // Predict if the line with the additional char would fit on the paper width
        var fitsOK = self.textFits(char);
        
        // If the paper is not wide enough to type a new char, the next character will not fit
        if(!fitsOK){

            System.println("Uh, oh, does not fit...");
 
            // Pull the "return carriage" lever of our typewriter
            formattedChar = C.NEW_LINE + char;

            // Move to the right on the index to account for the "\n" char
            self.getQManO().addIx();

            // Save the last index position as the length of the previous line
            self.getLineArray().add(self.getQManO().getIx());
        }
        
        // If this was not a delete, but a true append
        if(!char.equals(C.EMPTY)){

            // Now that we have done the typewriter thing above, we can actually record the new char(s)
            self.getQManO().append(formattedChar);

            // The carriage will move to the right +1
            self.getQManO().addIx();
        }

        // Index for the latest line
        var curr = self.getLineArray().size()-1;

        // Fetch the starting ix for our current line, the one that we keep tyoing into until it does not fit
        self.currentLine = self.getQManO().getFrom(self.getLineArray()[curr]);
        
        // Remove this (prints a nice pattern though)
        var s = self.getCurrentLine().length() == 0? "<>": self.getCurrentLine();
        System.println("Curr IX: " + self.getIx() + "; Curr line: " + curr + "; Curr col: " + self.getLineArray()[curr] + "; Currline: " + s);
    }

    function deleteLast() as void {
        
        if(self.getIx() > 0){

            // Delete the last character
            self.getQManO().removeLast();

            // Drop an index
            self.getQManO().dropIx();
            
            // Invoke the append with "" so it knows it is a delete
            self.appendChar(C.EMPTY);
            
            // If we find ourselves having deleted the first char in a row, also delete the "\n" and move up a row
            if(self.getQManO().getLast().equals(C.NEW_LINE)){
                
                var curr = self.getLineArray().size()-1;
                var lastCol = self.getLineArray()[curr];
                self.getLineArray().remove(lastCol);
                
                self.deleteLast();
            }
        }
    }

    private function textFits(char){
       return QBoard.getTextWH(self.currentLine + char)[0] < C.QPAD_X_SPACE;
    }

    private function getBoxedChar() {
        return C.QBOARD_CHARACTERS.substring(self.getIx(), self.getIx()+1);
    }

    // Object accessor delegates
    function getIx(){
        return self.getQManO().getIx();
    }

    function getFullString(){
        return self.getQManO().getFullString();
    } 

    // Accessors
    function getQManO(){return self.qObjectHub.getQManO();}
    function getQBoxO(){return self.qObjectHub.getQBoxO();}
    private function getCurrentLine(){return self.currentLine;}
    private function getLineArray(){return self.lineArray;}
}