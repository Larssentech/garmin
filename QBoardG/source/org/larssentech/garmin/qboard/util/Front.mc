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
using Toybox.Application as App;
using QBoardConst as C;

class Front extends Ui.View {

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {

        dc.setColor(C.CLR_FRONT_BG, C.CLR_FRONT_BG);
        dc.clear();
        
        dc.setColor(C.CLR_FRONT_TITLE, C.CLR_TRANSPARENT);
        dc.drawText(120, 60, Gfx.FONT_SYSTEM_LARGE, C.TITLE, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);

        dc.setColor(C.CLR_FRONT_TEXT, C.CLR_TRANSPARENT);
        dc.drawText(120, 120, C.FNT_STD, C.SUBTITLE_1, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(120, 140, C.FNT_STD, C.SUBTITLE_2, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);

        dc.setColor(C.CLR_FRONT_MADE_BY, C.CLR_TRANSPARENT);
        dc.drawText(120, 370, Gfx.FONT_SYSTEM_TINY, C.MADE_BY, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);

        dc.setColor(C.CLR_FRONT_VERSION, C.CLR_TRANSPARENT);
        dc.drawText(120, 390, Gfx.FONT_SYSTEM_XTINY, C.VERSION_S, Gfx.TEXT_JUSTIFY_CENTER|Gfx.TEXT_JUSTIFY_VCENTER);
    }     
}