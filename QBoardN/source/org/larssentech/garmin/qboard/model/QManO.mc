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

using Toybox.System as System;
using QBoardConst as C;

class QManO{

    private var fullString = C.EMPTY;    // Holds the entire text entered in the app
    private var ix = C.ZERO;             // Holds the index for navigating the full string

    function addIx() as void{
        self.ix +=1;
    }

    function dropIx() as void{
        self.ix -=1;
    }

    function resetIx(){
        self.ix = self.getFullString().length();
    }

    function append(char){
        self.fullString += char;
    }

    function removeLast(){
        self.fullString = self.fullString.substring(0, self.fullString.length()-1);
    }

    function getLast(){
        return self.fullString.substring(self.fullString.length()-1, self.fullString.length());
    }

    function getFrom(i){
        return self.fullString.substring(i, self.fullString.length());
    }

    // Accessors
    function getIx(){return self.ix;}
    function getFullString(){return self.fullString;}
}