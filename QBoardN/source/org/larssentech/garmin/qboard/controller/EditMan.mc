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

class EditMan {

    // Model
    private var qObjectHub;

    private var lastLine = C.EMPTY;

    function initialize(qObjectHub) as void{
        self.qObjectHub = qObjectHub;
    }

    function resetCursorIx() as void{
        self.getQManO().resetIx();
    }

    function moveCursor(way) as void{

        
        switch(way){

            case C.CURSOR_LEFT: {
                
                if(self.getIx() > 0) {

                    self.getQManO().dropIx();

                    if(self.getCursedChar().equals(C.NEW_LINE)){

                        self.getQManO().dropIx();
                    }
                }
                return;
            }

            case C.CURSOR_RIGHT: {

                if(self.getIx() < self.getFullString().length()-1) {

                    self.getQManO().addIx();

                    if(self.getCursedChar().equals(C.NEW_LINE)){

                        self.getQManO().addIx();
                    }
                }
                return;
            }
        }

        
    }

    function getCursedChar(){
        return self.getFullString().substring(self.getIx(), self.getIx()+1);
    }

    // Object accessor delegates
    function getIx(){
        return self.getQManO().getIx();
    }

    function getFullString(){
        return self.getQManO().getFullString();
    } 

    //
    function getQManO(){return self.qObjectHub.getQManO();}
    function getQBoxO(){return self.qObjectHub.getQBoxO();}
}